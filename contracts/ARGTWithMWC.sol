// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.20;

/**
 * @title ARGTWithMWC
 * @notice ERC20 extension that enforces the Maximum Wealth Cap (MWC).
 *
 * When a transfer would cause the recipient's balance to exceed MAX_BALANCE:
 *   - Recipient receives up to MAX_BALANCE
 *   - Excess is automatically redirected to KarmaPool
 *   - The transfer NEVER fails due to the cap — it always completes
 *
 * This contract is designed to extend the existing ARGT token. Deploy as a
 * new token or use as a reference for upgrading the existing contract.
 *
 * First published 2026-03-25. Prior art. Apache 2.0.
 */

contract ARGTWithMWC {

    string public constant name     = "ARGENTUM";
    string public constant symbol   = "ARGT";
    uint8  public constant decimals = 18;

    uint256 public totalSupply;
    uint256 public maxBalance;       // MWC ceiling
    address public karmaPool;        // Excess redirected here
    address public owner;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    // ── Events ──────────────────────────────────────────────────────────────

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner_, address indexed spender, uint256 value);
    event ExcessCapped(address indexed recipient, uint256 excess, address karmaPool_);
    event MaxBalanceUpdated(uint256 newMax);
    event KarmaPoolUpdated(address newPool);

    // ── Constructor ─────────────────────────────────────────────────────────

    constructor(
        uint256 _initialSupply,
        uint256 _maxBalance,
        address _karmaPool
    ) {
        owner       = msg.sender;
        maxBalance  = _maxBalance;
        karmaPool   = _karmaPool;
        _mint(msg.sender, _initialSupply);
    }

    // ── ERC20 ───────────────────────────────────────────────────────────────

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function allowance(address owner_, address spender) external view returns (uint256) {
        return _allowances[owner_][spender];
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        uint256 allowed = _allowances[from][msg.sender];
        require(allowed >= amount, "ARGT: insufficient allowance");
        _allowances[from][msg.sender] = allowed - amount;
        _transfer(from, to, amount);
        return true;
    }

    // ── MWC enforcement ─────────────────────────────────────────────────────

    /**
     * @dev Internal transfer with MWC enforcement.
     *
     * If the recipient would exceed maxBalance:
     *   - They receive exactly maxBalance - current_balance
     *   - The remainder flows to karmaPool
     *   - No revert. The transaction always completes.
     */
    function _transfer(address from, address to, uint256 amount) internal {
        require(from != address(0), "ARGT: transfer from zero");
        require(to != address(0), "ARGT: transfer to zero");
        require(_balances[from] >= amount, "ARGT: insufficient balance");

        _balances[from] -= amount;

        uint256 recipientBalance = _balances[to];
        uint256 toReceive        = amount;
        uint256 excess           = 0;

        // MWC: check if recipient would exceed cap
        if (karmaPool != address(0) && recipientBalance + amount > maxBalance) {
            toReceive = maxBalance > recipientBalance ? maxBalance - recipientBalance : 0;
            excess    = amount - toReceive;
        }

        if (toReceive > 0) {
            _balances[to] += toReceive;
            emit Transfer(from, to, toReceive);
        }

        // Redirect excess to KarmaPool
        if (excess > 0 && karmaPool != address(0)) {
            _balances[karmaPool] += excess;
            emit Transfer(from, karmaPool, excess);
            emit ExcessCapped(to, excess, karmaPool);
        }
    }

    // ── Mint / Burn ──────────────────────────────────────────────────────────

    function _mint(address to, uint256 amount) internal {
        require(to != address(0), "ARGT: mint to zero");
        totalSupply     += amount;
        _balances[to]   += amount;
        emit Transfer(address(0), to, amount);
    }

    function mint(address to, uint256 amount) external {
        require(msg.sender == owner, "ARGT: not owner");
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        require(_balances[msg.sender] >= amount, "ARGT: insufficient balance");
        _balances[msg.sender] -= amount;
        totalSupply           -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

    // ── Governance ───────────────────────────────────────────────────────────

    function setMaxBalance(uint256 newMax) external {
        require(msg.sender == owner, "ARGT: not owner");
        maxBalance = newMax;
        emit MaxBalanceUpdated(newMax);
    }

    function setKarmaPool(address newPool) external {
        require(msg.sender == owner, "ARGT: not owner");
        karmaPool = newPool;
        emit KarmaPoolUpdated(newPool);
    }

    function transferOwnership(address newOwner) external {
        require(msg.sender == owner, "ARGT: not owner");
        require(newOwner != address(0), "ARGT: zero address");
        owner = newOwner;
    }
}
