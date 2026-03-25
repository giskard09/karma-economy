// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.20;

/**
 * @title KarmaPool
 * @notice Treasury contract for the Karma Economy Triad (KET).
 *
 * Receives ARGT tokens from:
 *   1. MWC enforcement (excess above MAX_BALANCE redirected here)
 *   2. Voluntary contributions from any entity
 *
 * Distributes via KarmaDistributor (separate contract, authorized).
 *
 * First published 2026-03-25. Prior art. Apache 2.0.
 */

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract KarmaPool {

    address public immutable argtToken;
    address public owner;
    address public distributor;

    uint256 public totalReceived;
    uint256 public totalDistributed;

    event ContributionReceived(address indexed from, uint256 amount, string reason);
    event DistributionSent(address indexed to, uint256 amount);
    event DistributorUpdated(address indexed newDistributor);

    modifier onlyOwner() {
        require(msg.sender == owner, "KarmaPool: not owner");
        _;
    }

    modifier onlyDistributor() {
        require(msg.sender == distributor, "KarmaPool: not distributor");
        _;
    }

    constructor(address _argtToken) {
        argtToken = _argtToken;
        owner = msg.sender;
    }

    /**
     * @notice Contribute ARGT to the pool voluntarily.
     * @param amount Amount of ARGT to contribute.
     * @param reason Description of why (e.g., "company karma contribution", "excess from MWC").
     */
    function contribute(uint256 amount, string calldata reason) external {
        require(amount > 0, "KarmaPool: amount must be > 0");
        require(
            IERC20(argtToken).transferFrom(msg.sender, address(this), amount),
            "KarmaPool: transfer failed"
        );
        totalReceived += amount;
        emit ContributionReceived(msg.sender, amount, reason);
    }

    /**
     * @notice Called by KarmaDistributor to send tokens to an entity.
     * @param to Recipient wallet address.
     * @param amount Amount of ARGT to send.
     */
    function sendToRecipient(address to, uint256 amount) external onlyDistributor {
        require(amount > 0, "KarmaPool: amount must be > 0");
        require(
            IERC20(argtToken).balanceOf(address(this)) >= amount,
            "KarmaPool: insufficient balance"
        );
        require(
            IERC20(argtToken).transfer(to, amount),
            "KarmaPool: transfer failed"
        );
        totalDistributed += amount;
        emit DistributionSent(to, amount);
    }

    /**
     * @notice Current balance available for distribution.
     */
    function availableBalance() external view returns (uint256) {
        return IERC20(argtToken).balanceOf(address(this));
    }

    /**
     * @notice Authorize a distributor contract.
     */
    function setDistributor(address _distributor) external onlyOwner {
        distributor = _distributor;
        emit DistributorUpdated(_distributor);
    }

    /**
     * @notice Transfer ownership.
     */
    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "KarmaPool: zero address");
        owner = newOwner;
    }
}
