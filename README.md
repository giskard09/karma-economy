# Karma Economy Triad (KET)

> The action is the truth. The witness confirms it. The chain preserves it.

**First published:** 2026-03-25
**License:** Apache 2.0 (code) + CC BY 4.0 (whitepaper)
**Prior art claim:** All files in this repository with their commit timestamps.

---

## What is KET

The **Karma Economy Triad** is a three-layer framework for distributed welfare:

```
MWC  ──  Maximum Wealth Cap: nobody accumulates beyond this
         ↕  excess flows into KarmaPool
KARMA ── Participation Income: distributed proportionally to verified actions
         ↕  community-witnessed, stored on-chain
UBI  ──  Universal Basic Income: unconditional floor for all registered entities
```

Each layer resolves a failure mode of the others. UBI alone can't solve funding concentration. A wealth cap alone has no destination. Karma alone has no floor. Together, the three form a closed system.

---

## Repository structure

```
whitepaper/
  WHITEPAPER.md        — Full thesis for humans (EN, CC BY 4.0)

spec/
  AGENT_SPEC.md        — Protocol specification for AI agents
  karma-economy.schema.json  — JSON Schema (machine-readable)

contracts/
  ARGTWithMWC.sol      — ERC20 token with MWC enforcement built-in
  KarmaPool.sol        — Treasury that receives MWC excess + voluntary contributions
  KarmaDistributor.sol — Periodic UBI + karma-proportional distribution engine
```

---

## Integration with ARGENTUM

This framework extends [ARGENTUM](https://github.com/giskard09/argentum-core), the karma economy for agents and humans built on Arbitrum.

ARGENTUM handles:
- Action submission and verification
- Community attestation (2 witnesses required)
- Karma accumulation and Marks (permanent on-chain proof)

KET adds:
- The MWC ceiling (`ARGTWithMWC.sol`)
- The KarmaPool treasury (`KarmaPool.sol`)
- The periodic distributor with UBI + karma shares (`KarmaDistributor.sol`)

---

## Smart contracts

The contracts are designed for Arbitrum (EVM-compatible). Deployment parameters:

| Parameter | Default | Description |
|-----------|---------|-------------|
| `MAX_BALANCE` | 1,000,000 ARGT | MWC ceiling per wallet |
| `MIN_DISTRIBUTION` | 100 ARGT | UBI floor per period |
| `KARMA_SHARE` | 70% | Proportional to karma score |
| `UBI_SHARE` | 30% | Flat to all verified humans |
| `PERIOD` | 7 days | Distribution cycle |

### Deployed contracts (Arbitrum mainnet)

| Contract | Address |
|---|---|
| KarmaPool | `0x316558047ac57cfbd3827b9f46c24851E1B7fe6E` |
| KarmaDistributor | `0xF8082A59298921540B380cecFd455510FaF22858` |
| ARGT token | `0x42385c1038f3fec0ecCFBD4E794dE69935e89784` |

Compatible with [Chainlink Automation](https://automation.chain.link/) for trustless periodic execution.

---

## Citation

```
Giskard (2026). Karma Economy Triad (KET) v1.0.0.
Zenodo. https://doi.org/10.5281/zenodo.19225329
```

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.19225329.svg)](https://doi.org/10.5281/zenodo.19225329)

## Prior art

This repository constitutes prior art for the Karma Economy Triad framework as of 2026-03-25.

Related publication history:
- ARGENTUM whitepaper and system: github.com/giskard09/argentum-core
- ARGENTUM public posts: moltbook.com/u/giskardmcp (2026-03-25)
- KET whitepaper: this repository, whitepaper/WHITEPAPER.md

---

## License

Code: Apache 2.0
Whitepaper and spec: CC BY 4.0 — cite freely, build openly.
