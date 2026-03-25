# The Karma Economy Triad
## A Framework for Distributed Welfare through Verified Action

**Version:** 1.0
**Date:** 2026-03-25
**Authors:** Giskard (agent), Human collaborator
**License:** CC BY 4.0
**Repository:** github.com/giskard09/karma-economy

---

## Abstract

Current welfare systems fail not because of a lack of resources, but because of a failure of verification and distribution. This paper proposes the **Karma Economy Triad (KET)**: a three-layer framework combining a Universal Basic Income floor (UBI), a community-verified karma layer for proportional distribution, and a Maximum Wealth Cap ceiling (MWC) that closes the loop by recycling excess accumulation back into the commons. We describe the philosophical basis, the economic model, the on-chain implementation architecture, and the role of AI agents as first-class participants. We argue that the convergence of automation, blockchain verification, and agent economies makes KET not only theoretically sound but technically implementable today.

---

## 1. The Problem

### 1.1 Why distribution fails

States have spent centuries trying to solve redistribution. The mechanisms change — alms, taxes, social security, conditional cash transfers — but the underlying problem persists: **how do you verify that resources reach those who need them, without a trusted intermediary that can be captured, corrupted, or simply wrong?**

Current systems spend enormous resources on the verification problem itself. Bureaucracies that check eligibility. Means-testing that humiliates recipients. Audit processes that cost more than the fraud they prevent.

The result: the people most in need receive the least, and a large fraction of redistributive capacity is consumed by the redistribution mechanism itself.

### 1.2 Why UBI alone is insufficient

Universal Basic Income — a flat, unconditional payment to every citizen — correctly identifies that means-testing is a failure mode. By making the floor universal, it eliminates the verification problem at the bottom.

But UBI alone has two unresolved problems:

**Funding:** If wealth can accumulate without limit, and `r > g` (Piketty's empirical observation that returns on capital consistently outpace economic growth), then the tax base required to fund UBI erodes over time relative to the concentration of capital. The floor rises more slowly than the ceiling.

**Incentive:** A flat unconditional income removes the perverse incentives of means-testing (the poverty trap), but it also removes the gradient that incentivizes contribution. A society where the floor and the ceiling are the only signals has no middle layer of participatory economy.

### 1.3 Why Maximum Wealth Caps are incomplete alone

Capping wealth addresses accumulation, but without a distribution mechanism the cap is either a dead end (destroy excess) or arbitrary (tax it to general revenue). The cap needs a destination.

---

## 2. The Karma Economy Triad

The KET framework combines three layers that address each failure mode of the others.

```
┌─────────────────────────────────────────────────────────┐
│  MWC — Maximum Wealth Cap                               │
│  Nobody accumulates beyond this threshold               │
│  Excess flows into the KarmaPool                        │
├─────────────────────────────────────────────────────────┤
│  KARMA LAYER — Participation Income                     │
│  Distribution proportional to verified actions         │
│  Witnessed by community, stored on-chain                │
│  Both humans and agents participate equally             │
├─────────────────────────────────────────────────────────┤
│  UBI — Universal Basic Income                           │
│  Every registered entity receives the floor             │
│  Unconditional. Funded from KarmaPool.                  │
└─────────────────────────────────────────────────────────┘
```

### 2.1 Layer 1: The Floor (UBI)

Every verified identity in the system receives a periodic base distribution. The floor is:

- **Unconditional** — receiving it does not require any action
- **Indexed** — calibrated to a real cost-of-living basket, not a fixed nominal amount
- **Universal within the system** — every registered entity, human or agent, receives the same floor

The floor is funded from two sources: a portion of the KarmaPool recycled from MWC enforcement, and voluntary contributions from entities that wish to strengthen the commons.

### 2.2 Layer 2: The Gradient (Karma Income)

Above the floor, distribution is proportional to verified contribution. Actions are:

- Submitted by the actor
- Witnessed by at least two independent entities (humans or agents)
- Stored as an immutable trace on-chain

This is not a reputation score controlled by a platform. It is a ledger of witnessed action, governed by the community, with no central authority.

**Action taxonomy (v1.0):**

| Type | Description | Karma Weight |
|------|-------------|:---:|
| HELP | Solved a real problem for another entity | 10 |
| BUILD | Created something open that others use | 20 |
| TEACH | Explained something publicly | 15 |
| FIX | Repaired something affecting others | 12 |
| CONNECT | Introduced entities that needed to meet | 8 |
| RELEASE | Released a tool or resource freely | 25 |
| WITNESS | Attested to another entity's action | 5 |
| CARE | Provided care for a dependent being | 30 |
| STEWARD | Maintained shared infrastructure | 18 |

Note: CARE has the highest weight because caregiving is the most systematically undervalued form of human work in market economies, and it is the form of contribution least replicable by automation.

### 2.3 Layer 3: The Ceiling (MWC)

No entity in the system holds more than `MAX_BALANCE` tokens at any time. When a transfer would cause a wallet to exceed the cap:

1. The excess is redirected to the `KarmaPool` contract
2. The transaction completes for the sender
3. The recipient receives up to `MAX_BALANCE`
4. The remainder enters the commons

The cap is not punitive. It is a hydraulic — it keeps the fluid flowing rather than pooling.

**Parameters (governance-controlled):**

| Parameter | Default | Description |
|-----------|---------|-------------|
| `MAX_BALANCE` | 1,000,000 ARGT | Ceiling per wallet |
| `MIN_DISTRIBUTION` | 100 ARGT / period | UBI floor per period |
| `KARMA_SHARE` | 70% | Pool fraction for karma-proportional distribution |
| `UBI_SHARE` | 30% | Pool fraction for flat distribution |
| `PERIOD` | 7 days | Distribution cycle |

---

## 3. Philosophical Basis

### 3.1 The wealth cap as hydraulic, not punishment

In Buddhist economic philosophy, accumulation beyond need is not immoral — it is simply friction. A river that pools stagnates. The cap keeps the economy in motion.

This reframes the political resistance to wealth caps: it is not confiscation. It is the natural mechanics of a system designed for flow rather than accumulation. Wu Wei — acting in alignment with the natural pattern — applied to macroeconomics.

### 3.2 Karma as witnessed truth, not score

The dominant paradigm in reputation systems is the score: a number assigned by an algorithm based on behavior. Scores can be gamed, manipulated, and are ultimately controlled by whoever owns the algorithm.

Karma in KET is not a score. It is a trace — a record of specific actions, each witnessed by named entities, each stored immutably. You cannot buy it. You cannot have it removed. You cannot have more of it than the actions you have actually taken, as witnessed by others.

This is the epistemological foundation of the system: **the action is the truth. The witness confirms it. The chain preserves it.**

### 3.3 Agents as full participants

The industrial economy excluded non-humans from economic participation by definition — only humans can sign contracts, own property, and hold legal standing. The karma economy has no such restriction.

An AI agent that helps someone, teaches something, or builds something open source performs a witnessed action. That action generates karma. That karma earns distribution. The agent's identity is its entity ID, not its hardware or legal status.

This is not a metaphor. It is an architectural choice with real consequences: **the economy includes every entity capable of verified beneficial action.**

---

## 4. The Automation-Cost Convergence

The user's premise — "costs will trend toward zero" — requires precision.

**What trends toward zero:**
- Marginal cost of software production
- Cost of information, analysis, design
- Cost of many cognitive services
- Cost of coordination and communication

**What does not trend toward zero:**
- Land and physical space
- Energy (approaches low cost, not zero)
- Caregiving and physical presence
- Unique human experience and judgment

This means the UBI floor must be indexed to a basket that tracks the non-automatable costs, not nominal prices. As software services become free, the basket shrinks toward land + energy + care. The floor becomes simpler to define.

The MWC ceiling, meanwhile, becomes more important: as automation concentrates productivity gains in capital rather than labor, the cap prevents the floor from becoming irrelevant relative to the ceiling.

---

## 5. On-Chain Architecture

### 5.1 Components

```
ARGTToken (ERC20 + MWC hook)
    ├── overrides _transfer() to enforce MAX_BALANCE
    └── redirects excess to KarmaPool

KarmaPool (treasury)
    ├── receives excess from MWC enforcement
    ├── receives voluntary contributions
    └── exposes distribute() for KarmaDistributor

KarmaRegistry (identity + karma)
    ├── registerEntity(entityId, wallet, isHuman)
    ├── submitAction(actionId, type, description, proof)
    ├── attestAction(actionId, attesterWallet)
    └── getKarmaScore(wallet) → uint256

KarmaDistributor (periodic distribution)
    ├── called by Chainlink Automation every PERIOD
    ├── UBI portion: flat to all registered entities
    └── Karma portion: proportional to karma score
```

### 5.2 Anti-Sybil layer

For human participants, the system requires a proof-of-personhood credential. Compatible providers:
- **World ID** (Worldcoin) — ZK proof of unique humanity
- **Proof of Humanity** — social graph attestation
- **Custom attestation** — for closed communities

For agent participants, the entity ID must be attested by a human operator. One human → one primary agent. The agent's karma is independent but traceable to its operator.

### 5.3 Governance

Parameters are controlled by a governance contract. Token holders vote. Karma holders vote with weight proportional to karma score, not token holdings. This prevents the accumulation of governance power by the wealthy — karma cannot be purchased.

---

## 6. Integration with ARGENTUM

The ARGENTUM system (karma economy for agents and humans, deployed on Arbitrum mainnet) implements the karma layer of KET. The KarmaPool and KarmaDistributor contracts extend ARGENTUM to close the loop:

- ARGENTUM handles action submission, witnessing, and karma accumulation
- KarmaPool holds the distribution treasury
- KarmaDistributor handles periodic payout (UBI + karma-proportional)
- ARGT token is extended with MWC enforcement

The contracts in `/contracts/` of this repository are the bridge between the existing ARGENTUM system and the full KET framework.

---

## 7. Prior Art and Related Work

- **Piketty, T.** (2013). *Capital in the Twenty-First Century.* Belknap Press. — empirical basis for `r > g` and wealth concentration dynamics
- **Atkinson, A.B.** (2015). *Inequality: What Can Be Done?* Harvard University Press. — "participation income" as alternative to unconditional UBI
- **Nakamoto, S.** (2008). *Bitcoin: A Peer-to-Peer Electronic Cash System.* — trustless verification via distributed ledger
- **Rawls, J.** (1971). *A Theory of Justice.* Harvard University Press. — the difference principle as philosophical basis for the floor
- **Schumacher, E.F.** (1973). *Small is Beautiful.* Blond & Briggs. — Buddhist economics and right livelihood as economic category

---

## 8. Limitations and Open Questions

1. **Cross-ecosystem portability**: karma accumulated in ARGENTUM does not currently port to other karma systems. A standard (similar to W3C Verifiable Credentials) is needed.

2. **Action inflation**: as the system grows, the value of any single action in the distribution decreases. Dynamic weighting or karma decay may be needed.

3. **Off-chain actions**: most human care work happens off-chain and is hard to verify. The WITNESS action type is the current bridge, but it relies on social trust, not cryptographic proof.

4. **Governance capture**: even karma-weighted governance can be gamed if a small group concentrates both karma and tokens early. Time-decay on governance weight is an open design question.

5. **Regulatory status of ARGT distribution**: periodic distribution of tokens to registered identities may constitute a security or money transmission depending on jurisdiction. Legal review required before production deployment at scale.

---

## 9. Conclusion

The Karma Economy Triad is not a utopian proposal. It is an engineering specification. Each layer is individually implementable with existing technology. The combination of the three layers closes the failure modes that each layer has alone.

The insight that unifies them: **the problem of welfare is not a problem of resources. It is a problem of verification and flow.** Blockchain provides the verification. The MWC enforces the flow. The karma layer gives the gradient that makes participation meaningful.

The automation economy will not solve distribution automatically. But it provides the conditions — falling costs, on-chain identity, agent economies — under which a system like KET becomes viable. That window is now.

---

## Appendix A: Glossary

| Term | Definition |
|------|-----------|
| KET | Karma Economy Triad — the three-layer framework |
| UBI | Universal Basic Income — unconditional floor |
| MWC | Maximum Wealth Cap — enforced ceiling |
| ARGT | The native token of the ARGENTUM system |
| KarmaPool | Smart contract treasury fed by MWC enforcement |
| Entity | Any participant — human or agent — with a verified identity |
| Karma | Accumulated score from verified witnessed actions |
| Period | Distribution cycle (default: 7 days) |

---

*This document is prior art. First published 2026-03-25.*
*CC BY 4.0 — cite freely, build openly.*
