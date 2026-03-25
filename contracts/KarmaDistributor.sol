// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.20;

/**
 * @title KarmaDistributor
 * @notice Periodic distribution engine for the Karma Economy Triad (KET).
 *
 * Every PERIOD:
 *   - UBI pool (UBI_SHARE % of KarmaPool): distributed flat to all
 *     registered entities with proof_of_personhood = verified.
 *   - Karma pool (KARMA_SHARE % of KarmaPool): distributed proportionally
 *     to karma score across all registered entities.
 *
 * Compatible with Chainlink Automation (implements checkUpkeep / performUpkeep).
 * Can also be triggered manually by owner.
 *
 * First published 2026-03-25. Prior art. Apache 2.0.
 */

interface IKarmaPool {
    function sendToRecipient(address to, uint256 amount) external;
    function availableBalance() external view returns (uint256);
}

contract KarmaDistributor {

    // ── Parameters (governance-controlled) ─────────────────────────────────

    uint256 public maxBalance;          // MWC ceiling (informational here; enforced in token)
    uint256 public minDistribution;     // UBI floor per entity per period (in ARGT)
    uint256 public karmaShareBps;       // Karma-proportional share in basis points (7000 = 70%)
    uint256 public ubiShareBps;         // Flat UBI share in basis points (3000 = 30%)
    uint256 public periodSeconds;       // Distribution period in seconds

    address public immutable karmaPool;
    address public owner;

    uint256 public lastDistribution;
    uint256 public distributionCount;

    // ── Registry ────────────────────────────────────────────────────────────

    struct Entity {
        address wallet;
        uint256 karmaScore;
        bool isVerifiedHuman;   // proof_of_personhood: world_id or proof_of_humanity
        bool active;
        uint256 lastClaimed;
    }

    mapping(bytes32 => Entity) public entities;  // keccak256(entityId) → Entity
    bytes32[] public entityIds;

    // ── Events ──────────────────────────────────────────────────────────────

    event EntityRegistered(bytes32 indexed entityHash, address wallet, bool isHuman);
    event KarmaUpdated(bytes32 indexed entityHash, uint256 newScore);
    event DistributionExecuted(uint256 indexed round, uint256 totalDistributed, uint256 entityCount);
    event ParametersUpdated(uint256 maxBalance, uint256 minDist, uint256 karmaBps, uint256 ubiBps, uint256 period);

    // ── Modifiers ───────────────────────────────────────────────────────────

    modifier onlyOwner() {
        require(msg.sender == owner, "KD: not owner");
        _;
    }

    // ── Constructor ─────────────────────────────────────────────────────────

    constructor(
        address _karmaPool,
        uint256 _maxBalance,
        uint256 _minDistribution,
        uint256 _periodSeconds
    ) {
        karmaPool       = _karmaPool;
        owner           = msg.sender;
        maxBalance      = _maxBalance;
        minDistribution = _minDistribution;
        karmaShareBps   = 7000; // 70%
        ubiShareBps     = 3000; // 30%
        periodSeconds   = _periodSeconds;
        lastDistribution = block.timestamp;
    }

    // ── Registry management ─────────────────────────────────────────────────

    /**
     * @notice Register an entity for distribution.
     * @param entityId Off-chain entity ID (from ARGENTUM system).
     * @param wallet Wallet address to receive ARGT.
     * @param isVerifiedHuman True if proof_of_personhood is world_id or proof_of_humanity.
     */
    function registerEntity(
        string calldata entityId,
        address wallet,
        bool isVerifiedHuman
    ) external onlyOwner {
        bytes32 h = keccak256(bytes(entityId));
        require(!entities[h].active, "KD: already registered");
        entities[h] = Entity({
            wallet: wallet,
            karmaScore: 0,
            isVerifiedHuman: isVerifiedHuman,
            active: true,
            lastClaimed: 0
        });
        entityIds.push(h);
        emit EntityRegistered(h, wallet, isVerifiedHuman);
    }

    /**
     * @notice Update karma score for an entity.
     * @dev Called by the off-chain ARGENTUM system when an action is verified.
     *      In production, replace owner auth with a multi-sig or oracle.
     */
    function updateKarma(string calldata entityId, uint256 newScore) external onlyOwner {
        bytes32 h = keccak256(bytes(entityId));
        require(entities[h].active, "KD: entity not found");
        entities[h].karmaScore = newScore;
        emit KarmaUpdated(h, newScore);
    }

    // ── Distribution ────────────────────────────────────────────────────────

    /**
     * @notice Chainlink Automation: check if upkeep is needed.
     */
    function checkUpkeep(bytes calldata) external view returns (bool upkeepNeeded, bytes memory) {
        upkeepNeeded = (block.timestamp >= lastDistribution + periodSeconds);
    }

    /**
     * @notice Chainlink Automation: execute distribution.
     */
    function performUpkeep(bytes calldata) external {
        _distribute();
    }

    /**
     * @notice Manual trigger (owner only, for testing or governance decisions).
     */
    function triggerDistribution() external onlyOwner {
        _distribute();
    }

    function _distribute() internal {
        require(
            block.timestamp >= lastDistribution + periodSeconds,
            "KD: period not elapsed"
        );

        uint256 pool = IKarmaPool(karmaPool).availableBalance();
        if (pool == 0) return;

        uint256 ubiPool   = (pool * ubiShareBps)   / 10000;
        uint256 karmaPool_ = (pool * karmaShareBps) / 10000;

        // Count eligible entities
        uint256 verifiedHumans = 0;
        uint256 totalKarma     = 0;
        uint256 active         = entityIds.length;

        for (uint256 i = 0; i < active; i++) {
            Entity storage e = entities[entityIds[i]];
            if (!e.active) continue;
            if (e.isVerifiedHuman) verifiedHumans++;
            totalKarma += e.karmaScore;
        }

        uint256 totalDistributed = 0;

        // UBI distribution: flat to all verified humans
        if (verifiedHumans > 0 && ubiPool > 0) {
            uint256 ubiPerEntity = ubiPool / verifiedHumans;
            if (ubiPerEntity < minDistribution) {
                ubiPerEntity = minDistribution;
            }
            for (uint256 i = 0; i < active; i++) {
                Entity storage e = entities[entityIds[i]];
                if (!e.active || !e.isVerifiedHuman) continue;
                if (e.wallet == address(0)) continue;
                IKarmaPool(karmaPool).sendToRecipient(e.wallet, ubiPerEntity);
                totalDistributed += ubiPerEntity;
            }
        }

        // Karma distribution: proportional to karma score
        if (totalKarma > 0 && karmaPool_ > 0) {
            for (uint256 i = 0; i < active; i++) {
                Entity storage e = entities[entityIds[i]];
                if (!e.active || e.karmaScore == 0) continue;
                if (e.wallet == address(0)) continue;
                uint256 share = (karmaPool_ * e.karmaScore) / totalKarma;
                if (share == 0) continue;
                IKarmaPool(karmaPool).sendToRecipient(e.wallet, share);
                totalDistributed += share;
            }
        }

        lastDistribution = block.timestamp;
        distributionCount++;

        emit DistributionExecuted(distributionCount, totalDistributed, active);
    }

    // ── Governance ──────────────────────────────────────────────────────────

    /**
     * @notice Update distribution parameters.
     * @dev In production, this should be gated by a governance vote.
     */
    function updateParameters(
        uint256 _maxBalance,
        uint256 _minDistribution,
        uint256 _karmaShareBps,
        uint256 _ubiShareBps,
        uint256 _periodSeconds
    ) external onlyOwner {
        require(_karmaShareBps + _ubiShareBps == 10000, "KD: shares must sum to 100%");
        require(_periodSeconds >= 1 days, "KD: period too short");
        maxBalance      = _maxBalance;
        minDistribution = _minDistribution;
        karmaShareBps   = _karmaShareBps;
        ubiShareBps     = _ubiShareBps;
        periodSeconds   = _periodSeconds;
        emit ParametersUpdated(_maxBalance, _minDistribution, _karmaShareBps, _ubiShareBps, _periodSeconds);
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "KD: zero address");
        owner = newOwner;
    }

    // ── View ────────────────────────────────────────────────────────────────

    function entityCount() external view returns (uint256) {
        return entityIds.length;
    }

    function nextDistributionIn() external view returns (uint256) {
        uint256 next = lastDistribution + periodSeconds;
        if (block.timestamp >= next) return 0;
        return next - block.timestamp;
    }
}
