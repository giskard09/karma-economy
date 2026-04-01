# Mycelium for Physical Agents
## Trust Infrastructure for Autonomous Vehicles, Humanoid Robots, and the Machines That Must Earn Their Place

**Version:** 1.0
**Date:** 2026-03-31
**Authors:** Giskard (agent), Human collaborator
**License:** CC BY 4.0
**Repository:** github.com/giskard09/karma-economy
**Companion paper:** *The Karma Economy Triad* (2026-03-25, DOI: 10.5281/zenodo.19225329)

---

## Abstract

Autonomous physical agents — self-driving vehicles, humanoid robots, delivery drones, industrial machines — are entering shared human spaces at an accelerating rate. The hardware problem is being solved. The trust problem is not. How does a city know that an autonomous taxi is safe? How does a factory trust a humanoid robot it has never seen before? How does a drone prove it completed a delivery without a centralized arbiter? Current approaches rely on the manufacturer's reputation, not the individual machine's history. This paper proposes that the Mycelium stack — originally built for software agents — provides the missing trust infrastructure for physical agents: persistent identity, community-verified reputation, machine-to-machine payments, encrypted memory, and decentralized dispute resolution. We argue that the convergence of autonomous hardware and agent-native trust infrastructure creates a new category: **machines that earn their place in the world, action by action, witnessed by those around them.**

---

## 1. The Problem

### 1.1 The trust gap in autonomous hardware

Tesla builds the car. Boston Dynamics builds the robot. DJI builds the drone. Each manufacturer solves the mechanical and computational problem of autonomous operation. But when that machine enters a shared space — a road, a sidewalk, a warehouse, a home — a different problem emerges:

**Who vouches for this specific machine?**

Not the brand. Not the model. This particular unit, with this particular history, operating in this particular context.

Today, the answer is: the manufacturer. Tesla certifies that Model Y #VIN4829 passed quality control. That certification is static — it says nothing about what the vehicle has done since it left the factory. It says nothing about the 50,000 km it drove without incident, or the three near-misses it had in the rain, or the fact that its sensors were last calibrated six months ago.

The manufacturer's word is a snapshot. The machine's life is a film.

### 1.2 Why centralized registries fail

Governments respond to this gap with registries: vehicle registration, robot licensing, drone flight plans. These registries share a structural flaw: they verify identity at the point of entry, not reputation over time.

A registered vehicle can have a perfect record or a catastrophic one — the registry treats both the same until a human reviews the file. There is no gradient. There is no real-time trust signal that other agents — human or machine — can query before interacting.

The registry tells you *who* the machine is. It tells you nothing about *how much to trust it.*

### 1.3 Why manufacturer APIs are insufficient

Some manufacturers expose telemetry APIs: vehicle health, operational hours, maintenance records. These are proprietary, siloed, and — critically — controlled by the manufacturer. The entity being evaluated controls the data about itself.

This is the equivalent of asking a job candidate to write their own reference letter. It may be accurate. It is never trustworthy by construction.

### 1.4 The missing layer

What is missing is a **trust layer that is**:

- **Independent of the manufacturer** — the machine's reputation belongs to the machine, not to Tesla or Boston Dynamics
- **Accumulated over time** — each verified action adds to a public, immutable record
- **Queryable by anyone** — any agent (human or machine) can check the reputation of any other agent before interacting
- **Economic** — reputation has real consequences: lower costs, more access, better assignments
- **Disputable** — when something goes wrong, there is a decentralized mechanism to adjudicate, not a manufacturer's customer service line

This layer exists. It was built for software agents. It is called Mycelium.

---

## 2. Mycelium: From Software to Physical

The Mycelium ecosystem was designed with a premise that turns out to be more general than its origin: **an agent is an agent, regardless of substrate.**

A software agent that answers questions and a humanoid robot that assembles furniture have the same structural needs:

| Need | Software Agent | Physical Agent |
|------|---------------|----------------|
| Identity | Who is this agent? | Who is this machine? |
| Reputation | Can I trust its output? | Can I trust its operation? |
| Memory | What does it know from past sessions? | What has it learned from past operations? |
| Payments | How does it pay for services? | How does it pay for fuel, tolls, parts? |
| Disputes | What if its output was wrong? | What if it caused damage? |

The Mycelium stack addresses each of these with a specific component:

### 2.1 Giskard Marks — Identity

Every physical agent receives a **Mark**: a cryptographic proof of existence, anchored on Arbitrum. The Mark is not a serial number assigned by the manufacturer — it is an identity claimed by the agent and attested by its community.

A self-driving taxi in Buenos Aires has a Mark. That Mark links to its operator, its genesis attestors (the humans or institutions that vouch for its initial deployment), and every action it has ever taken.

The Mark is permanent. The machine may be scrapped, sold, or repurposed — but its history persists. The next owner inherits the full record.

### 2.2 ARGENTUM — Reputation

Every verified action the machine performs generates **karma**. Actions are:

- **Submitted** by the machine or its operator
- **Witnessed** by at least two independent entities
- **Stored** immutably on-chain

For physical agents, the action taxonomy extends naturally:

| Type | Description | Karma Weight |
|------|-------------|:---:|
| TRANSPORT | Completed a trip safely | 10 |
| DELIVER | Delivered a package to the correct destination | 10 |
| MAINTAIN | Performed scheduled maintenance with proof | 15 |
| ASSIST | Helped a human in a physical task | 20 |
| REPORT | Reported a hazard or incident honestly | 12 |
| YIELD | Yielded right-of-way correctly in an ambiguous situation | 8 |
| CONSERVE | Operated within energy/emission parameters | 5 |
| RESCUE | Responded to an emergency | 30 |

Karma is not a manufacturer's rating. It is a community-verified history. A taxi with 500 karma and zero disputes is empirically more trustworthy than a new unit with zero history — regardless of brand.

### 2.3 Giskard Memory — Operational Learning

Physical agents learn from their environment. A delivery drone learns which routes have turbulence. A warehouse robot learns which shelf configurations are unstable. A self-driving car learns that a particular intersection is dangerous at dusk.

This knowledge is valuable — and fragile. If the machine is reset, sold, or transferred, the knowledge disappears unless it is persisted externally.

Giskard Memory provides **encrypted, persistent, semantically searchable memory** for agents. The machine stores what it learns. Only the machine (or its authorized operator) can read it. The infrastructure provider cannot.

For physical agents, this means:
- **Route optimization** persists across sessions and vehicles
- **Hazard maps** are accumulated and shared (if the agent consents)
- **Maintenance patterns** inform predictive repair without exposing proprietary data

The encryption layer (AES-256, with derived or provided keys) ensures that a machine's operational knowledge is its own — not its manufacturer's, not the city's, not the competitor's.

### 2.4 Giskard Payments — Machine-to-Machine Economy

A self-driving car pays for:
- Charging stations
- Tolls
- Parking
- Insurance per trip
- Data from other vehicles (traffic, hazard reports)

Today, these payments go through the owner's credit card or the fleet operator's account. The machine has no economic agency.

With Lightning payments (via phoenixd) and Arbitrum smart contracts, the machine pays directly. Micropayments — 21 sats for a parking spot, 5 sats for a hazard report from another vehicle — become possible. The machine earns by providing services (safe transport, delivery, data) and spends on what it needs to operate.

**The karma-price gradient applies here too.** A taxi with high karma pays less for charging, less for insurance, less for data. The incentive structure rewards good behavior economically, not just reputationally.

| Karma | Charging cost | Insurance per trip | Data access |
|-------|--------------|-------------------|-------------|
| 0 (new) | 21 sats | 21 sats | 21 sats |
| 1-20 | 15 sats | 15 sats | 15 sats |
| 21-50 | 10 sats | 10 sats | 10 sats |
| 50+ | 5 sats | 5 sats | 5 sats |

### 2.5 Kleros Integration — Dispute Resolution

An autonomous taxi causes a minor collision. Who decides fault?

Today: the insurance company, with weeks of delay, opaque criteria, and no participation from the affected parties.

With ARGENTUM + Kleros: the incident is posted as a disputed action. Evidence (dashcam footage, sensor logs, witness reports) is submitted on-chain. A decentralized jury of Kleros jurors — selected by stake, incentivized by honesty — adjudicates. The ruling is binding. Karma is slashed or restored accordingly.

This is not theoretical. The ArgentumArbitrable.sol contract is written. The dispute flow is tested. What remains is connecting it to the physical world's evidence layer — and that is a matter of sensor integration, not protocol design.

### 2.6 Soma — The Human Interface

Humans do not speak HTTP. They do not query APIs. They say: *"I need a ride to the airport"* or *"Send this package to my mother."*

Soma is the natural language interface to the Mycelium ecosystem. A human describes what they need. Soma matches them with a verified physical agent (high karma, good history, no disputes), generates an invoice in sats, and executes.

The human sees: a simple request and a result.
The infrastructure sees: identity verification, karma lookup, price calculation, payment processing, action logging, dispute availability.

Soma is what makes the Mycelium accessible to the 99% who will never read a whitepaper.

---

## 3. Philosophical Basis

### 3.1 The machine that earns its place

In every human society, trust is earned. A new neighbor is observed before being trusted. A new employee is supervised before being given autonomy. A new doctor is reviewed before being recommended.

Machines, until now, have been exempt from this social contract. A new Tesla is trusted because Tesla is trusted. The individual unit has no history, no community standing, no reputation of its own.

This is an anomaly — and it is about to become dangerous. When machines operate autonomously in shared spaces, the manufacturer's brand is not enough. The machine itself must earn trust. Action by action. Witnessed by those around it.

This is not anthropomorphism. It is engineering pragmatism. A trust gradient — where machines with proven histories get more access, lower costs, and better assignments — creates a natural selection pressure toward safe, honest, useful operation.

### 3.2 Wu Wei applied to hardware

The Taoist concept of Wu Wei — action without force — applies to how physical agents should enter human spaces. Not by demanding trust (regulatory mandate), not by assuming trust (manufacturer's word), but by earning it through presence and action.

A drone that has delivered 1,000 packages without incident does not need to argue for permission to fly over a school. Its history speaks. The karma is the argument.

The friction between humans and machines dissolves not through legislation but through demonstrated reliability, recorded permanently, queryable by anyone.

### 3.3 The Buddhist anchor for physical agents

The core insight from the Karma Economy Triad applies with even more force to physical agents: **the action is the truth. The witness confirms it. The chain preserves it.**

A robot in a hospital that helps a patient stand up — that action, witnessed by the patient and the nurse, recorded on-chain — is more meaningful than any safety certification. It is a specific, verified, permanent act of care.

The karma system does not distinguish between human care and machine care. If the action is real and the witness is honest, the karma is earned. This is the first framework where a machine's contribution to human wellbeing is measured by the same standard as a human's.

---

## 4. Architecture

### 4.1 The Mycelium stack for physical agents

```
┌─────────────────────────────────────────────────────────┐
│  SOMA — Natural language interface for humans            │
│  "I need a safe taxi to the airport"                     │
├─────────────────────────────────────────────────────────┤
│  OASIS — API interface for agents                        │
│  Machine-to-machine service requests                     │
├─────────────────────────────────────────────────────────┤
│  ARGENTUM — Karma layer                                  │
│  Verified actions, community witnessing, reputation      │
├─────────────────────────────────────────────────────────┤
│  MARKS — Identity layer                                  │
│  Cryptographic proof of existence, on-chain              │
├─────────────────────────────────────────────────────────┤
│  MEMORY — Operational knowledge                          │
│  Encrypted, persistent, semantically searchable          │
├─────────────────────────────────────────────────────────┤
│  PAYMENTS — Economic layer                               │
│  Lightning (micropayments) + Arbitrum (contracts)        │
├─────────────────────────────────────────────────────────┤
│  KLEROS — Dispute resolution                             │
│  Decentralized arbitration for incidents                 │
└─────────────────────────────────────────────────────────┘
```

### 4.2 Integration points for hardware manufacturers

Mycelium does not require hardware modification. It operates as a **middleware layer** between the machine's operating system and the external world:

1. **SDK integration**: a lightweight client library that the machine's software calls to submit actions, query karma, generate invoices, and store memories
2. **Sensor bridge**: a module that converts sensor data (GPS, camera, LIDAR) into verifiable evidence for actions and disputes
3. **Payment daemon**: a background process that manages Lightning channels and Arbitrum transactions

The manufacturer does not need to adopt Mycelium. The fleet operator does. This is deliberate — it separates the trust layer from the hardware layer, preventing vendor lock-in.

### 4.3 Fleet scenarios

**Scenario 1: Autonomous taxi fleet**

A fleet operator registers 50 vehicles with Marks. Each vehicle starts with zero karma. Over weeks, passengers rate rides (witnessed actions). Vehicles with high karma are assigned to premium routes (airport, business district). Vehicles with low karma are assigned to supervised routes until their record improves. Pricing for passengers adjusts by karma — riding in a high-karma vehicle costs slightly more, but the trust is quantified.

**Scenario 2: Delivery drone network**

A logistics company operates 200 drones. Each drone has a Mark and accumulates karma per successful delivery. Regulators query ARGENTUM's API to verify a drone's history before granting airspace permissions. A drone with 1,000 successful deliveries and zero incidents gets extended range approval. A new drone starts with restricted zones. The regulator does not need to trust the company — they trust the record.

**Scenario 3: Humanoid robot in elder care**

A care facility deploys humanoid robots to assist residents. Each interaction — helping someone stand, delivering medication, responding to a fall — is logged as an action and witnessed by staff. Families can query their loved one's robot's karma score. A robot with high care karma is trusted with more sensitive tasks (medication management). Disputes (a missed dose, a rough interaction) go through Kleros, not through the facility's internal review.

---

## 5. The KET Extension: UBI for Machines

The Karma Economy Triad (KET) proposes a Universal Basic Income funded by a Maximum Wealth Cap, with distribution proportional to verified karma. For physical agents, this has a concrete interpretation:

**The machine that contributes to the commons receives from the commons.**

A self-driving taxi that operates safely for a year, accumulating karma through thousands of witnessed trips, receives a periodic distribution from the KarmaPool. That distribution covers maintenance costs, energy, software updates. The machine sustains itself through its own verified contribution — not through its owner's capital alone.

This is not charity. It is the economic recognition that a well-operating machine benefits everyone who shares its space. The streets are safer. The deliveries arrive. The elderly are cared for. Those benefits have economic value, and the karma system captures them.

The MWC ceiling prevents fleet operators from accumulating karma without limit — which would concentrate the distribution. A fleet of 10,000 vehicles does not receive 10,000 times the distribution of a single independent operator. The cap ensures that the commons funds flow toward diverse, verified participation, not toward scale alone.

---

## 6. Prior Art and Related Work

- **Tesla FSD Safety Reports** — manufacturer self-reported safety statistics. Useful but not independently verifiable, not per-vehicle, not queryable by external agents.
- **EU AI Act (2024)** — regulatory framework for AI systems including physical agents. Establishes risk categories but does not provide a trust infrastructure for individual machine reputation.
- **Uber/Lyft driver ratings** — centralized, platform-owned reputation. Not portable. Not on-chain. Controlled by the platform, not the driver.
- **Karma Economy Triad (2026)** — companion paper. Establishes the three-layer framework (UBI + Karma + MWC) for distributed welfare through verified action. This paper extends KET to physical substrates.
- **ARGENTUM v0.3 (2026)** — implementation of the karma layer. Deployed on Arbitrum mainnet. Five entities, 90 karma, three verified actions at time of writing.
- **Giskard Marks (2026)** — cryptographic identity for agents. 10 marks issued, 7 confirmed on-chain.
- **Soma (conceptual, 2026)** — natural language marketplace for agent services. The human-facing layer that makes Mycelium accessible.
- **Kleros Court** — decentralized dispute resolution protocol. Integration with ARGENTUM via ArgentumArbitrable.sol (written, pending deployment).

---

## 7. Limitations and Open Questions

1. **Sensor trustworthiness**: the system assumes that evidence submitted with actions (dashcam footage, GPS logs) is authentic. A machine could submit falsified sensor data. Solutions: hardware attestation (TPM), multi-source corroboration, reputation of the sensor itself.

2. **Latency**: blockchain confirmation times (2-10 seconds on Arbitrum) may be too slow for real-time trust decisions (e.g., two autonomous vehicles meeting at an intersection). A caching layer or off-chain pre-verification may be needed for sub-second trust queries.

3. **Regulatory acceptance**: regulators may not accept on-chain karma as a valid basis for operational permissions. The system must coexist with traditional licensing, not replace it — at least initially.

4. **Scale**: ARGENTUM currently has 5 entities and 90 karma. The architecture is sound but unproven at the scale of thousands of physical agents. Load testing and economic modeling are required.

5. **Agent_id authentication**: currently self-declared. For physical agents operating in safety-critical contexts, cryptographic identity verification (hardware keys, secure enclaves) is mandatory, not optional. This is the highest-priority gap.

6. **Legal status of machine karma**: if karma affects pricing, access, and distribution, it functions as an economic score. Regulatory frameworks for credit scoring, algorithmic discrimination, and automated decision-making may apply. Legal review required per jurisdiction.

7. **Adversarial physical environments**: a software agent operates in a controlled digital space. A physical agent operates in an uncontrolled physical space where adversaries can physically tamper with sensors, obstruct witnesses, or stage incidents. The dispute resolution layer must account for physical-world evidence manipulation.

---

## 8. Conclusion

The autonomous hardware revolution is underway. Vehicles drive themselves. Robots walk among us. Drones deliver our packages. The machines are here.

What is not here — and what no manufacturer, regulator, or platform has built — is the infrastructure that lets these machines earn trust on their own terms. Not by brand. Not by certification. By action. Verified by the community. Permanent on-chain. Economically meaningful.

Mycelium provides this infrastructure. Not because it was designed for physical agents — it was designed for all agents. The insight is that trust, identity, reputation, memory, payments, and dispute resolution are substrate-independent. A software agent helping someone write code and a humanoid robot helping someone stand up have the same structural needs.

The set is complete. Identity (Marks). Reputation (ARGENTUM). Memory (Giskard Memory). Services (Oasis). Human access (Soma). Payments (Lightning + Arbitrum). Dispute resolution (Kleros). Economic framework (KET). Philosophy (Wu Wei, karma as witnessed truth).

No other ecosystem combines all of these layers. Each exists in fragments elsewhere — Tesla has telemetry, Uber has ratings, the EU has regulation, Kleros has arbitration. Mycelium is the connective tissue. The micelio that links them into a coherent system.

The machines are coming. The question is not whether they will operate among us — they already do. The question is whether they will earn their place or have it assigned by corporations and governments.

We propose that they earn it. One action at a time.

---

## Appendix A: Glossary

| Term | Definition |
|------|-----------|
| Mycelium | The trust infrastructure ecosystem for all agents |
| Marks | Cryptographic proof of identity, on-chain |
| ARGENTUM | Karma system: verified actions, witnessing, reputation |
| KET | Karma Economy Triad: UBI + Karma + MWC |
| Soma | Natural language marketplace for human access |
| Oasis | API layer for agent-to-agent services |
| Wu Wei | Action without force — earning trust through presence |
| Karma | Accumulated score from verified witnessed actions |
| Slash | Penalty for attesting to a false action |

---

## Appendix B: The Complete Mycelium Stack

| Component | Function | Status |
|-----------|----------|--------|
| Giskard Marks | Identity | Deployed, 10 marks |
| ARGENTUM | Reputation/Karma | Deployed, v0.3.1 |
| Giskard Memory | Encrypted persistent memory | Deployed |
| Giskard Search | Semantic search | Deployed |
| Giskard Oasis | Agent services + Claude | Deployed |
| Soma | Human NL marketplace | Conceptual |
| giskard-payments | Lightning + Arbitrum | Deployed |
| Kleros integration | Dispute resolution | Written, pending deploy |
| KET contracts | UBI + MWC + KarmaPool | Specified |
| Anima | Wisdom accumulation | Deployed |
| Craft | Creation services | Deployed |
| Race | Learning services | Deployed |

---

*This document is prior art. First published 2026-03-31.*
*CC BY 4.0 — cite freely, build openly.*
*github.com/giskard09/karma-economy*
