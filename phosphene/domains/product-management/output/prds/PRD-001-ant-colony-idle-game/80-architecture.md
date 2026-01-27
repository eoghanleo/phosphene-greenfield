ID: PRD-001

# 8) Architecture and Technical Design

## 8.1 Architecture overview
- **Architecture style:** Client-heavy simulation with authoritative persistence service.
- **Primary runtime model:** WebGPU simulation loop with deterministic snapshots for benchmark and replay.
- **Core boundaries:**
  - Client simulation + rendering
  - Persistence + sync service
  - Experiment/benchmark service
  - Commerce + telemetry pipeline

The architecture must support two pacing modes without branching the codebase. The client should run a unified simulation loop while exposing configuration layers for relaxed and strategist play. Persistence must be durable and verifiable so the trust vault can display explicit confirmations of state saves. This also means that any in-chat surface must be able to render a summary without requiring the full heavy simulation to boot.

## 8.2 Key flows
- **Return recap flow:** client pulls last snapshot → computes delta → displays recap → writes new snapshot.
- **Experiment flow:** client clones snapshot → runs simulation parameters → logs metrics → writes experiment log.
- **In-chat continuity flow:** chat session token → sync service → state hash validation → UI indicator update.

Each flow is instrumented so product analytics can trace outcomes back to propositions. For example, the return recap flow is the core of PROP-0002 and PROP-0015, and must include telemetry that measures recap engagement and resulting actions. The experiment flow underpins PROP-0016 and PROP-0020, and therefore must include benchmark scoring outputs and parameter capture so strategists can verify the effect of their choices.

## 8.3 Component responsibilities
- **Simulation engine:** Runs deterministic colony behavior, exposes hooks for discovery events, and emits progression metrics.
- **Recap generator:** Computes deltas, summarizes progress, and selects the next best action based on pacing templates.
- **Experiment runner:** Allows branching snapshots, applies parameter overrides, and records outputs for comparison.
- **Sync service:** Stores snapshots, verifies state hashes, and resolves conflicts across devices.
- **Commerce bridge:** Handles optional purchases and receipts without blocking core progression.

These components should be built so they can fail gracefully. If the experiment runner is unavailable, the simulation still needs to run for relaxed players. If the sync service is down, the client should enter read-only mode and inform the player rather than silently losing progress. These failure behaviors are part of the trust contract and are therefore product requirements, not optional engineering decisions.

## 8.4 Data flow and observability
The data flow starts with the simulation engine emitting state updates and milestone events. These events are summarized into a lightweight snapshot that includes economy deltas, discovery moments, and progress toward milestones. The snapshot is stored through the sync service and becomes the source for return recaps, trust vault entries, and experiment baselines. This approach keeps the client responsive while ensuring that every key event is traceable.

Observability should be built into each flow. The system should emit telemetry for recap views, discovery unlocks, benchmark runs, and in-chat launches. Each event should be tagged with pacing template and surface (web or chat) so product analytics can track persona-aligned behaviors. If telemetry is missing, the product team will be unable to validate the core hypotheses, which is why observability is treated as a first-class architecture requirement.

The architecture must also support content scheduling without disrupting core simulation. Discovery events and seasonal arcs should be delivered as content payloads that can be updated without full client redeploys. This allows the product to tune novelty cadence while keeping the simulation engine stable. It also ensures that content experiments can be run safely without compromising core fairness or performance.
