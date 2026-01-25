ID: PRD-002

# 7) Feature Catalogue — core

## 7.2 Core features (detailed)

### Feature: Simulation loop + state engine
- **Feature ID:** F-CORE-01
- **Summary:** Deterministic simulation tick loop that evolves the colony, supports offline progress, and persists state safely.
- **Primary persona(s):** PER-0001
- **Linked propositions:** PROP-0001
- **User story:** As PER-0001, I want progress to be consistent and explainable so I can trust the model and experiment without feeling scammed.
- **Workflow steps:**
  1. Initialize state from saved snapshot (or safe baseline).
  2. Run deterministic tick loop; commit snapshots periodically.
  3. On resume, compute elapsed time and apply offline delta with a summary.
- **Functional requirements:** R-CORE-001, R-CORE-003, R-CORE-004
- **Edge cases and failure modes:**
  - Corrupt save detected -> recover to last-known-good snapshot and notify.
  - Very long idle gap -> cap delta or apply in chunks to avoid lockups.
- **Telemetry:** event.sim_tick, event.offline_progress_applied, event.save_commit, metric.sim_tick_ms
- **Risks:** determinism broken by floating point drift -> fixed-step math + state hashing tests.

### Feature: WebGPU renderer + interaction layer
- **Feature ID:** F-CORE-02
- **Summary:** WebGPU-backed renderer that keeps the colony visually legible and responsive under load.
- **Primary persona(s):** PER-0001
- **Linked propositions:** PROP-0001
- **User story:** As PER-0001, I want the simulation to feel alive and smooth so I can “read” what’s happening at a glance.
- **Workflow steps:**
  1. Map sim state to render buffers.
  2. Render frames at stable cadence; degrade gracefully if WebGPU unavailable.
  3. Surface key state changes with lightweight UI affordances (highlights, counters).
- **Functional requirements:** R-CORE-002, R-CORE-007
- **Edge cases and failure modes:**
  - WebGPU not supported -> fallback render path with reduced fidelity.
  - GPU resource exhaustion -> lower resolution or reduce particle count.
- **Telemetry:** event.render_frame, metric.fps_p50, metric.input_latency_p95
- **Risks:** performance regressions -> perf budget + CI guardrails + instrumentation.

### Feature: Upgrades + explainability UI
- **Feature ID:** F-CORE-03
- **Summary:** Upgrade workflow that explains cost/effect and attributes progress to causes (“what changed and why”).
- **Primary persona(s):** PER-0001
- **Linked propositions:** PROP-0001
- **User story:** As PER-0001, I want to choose upgrades intelligently and understand their impact so experimentation feels rewarding.
- **Workflow steps:**
  1. Browse upgrades with clear effect descriptions and costs.
  2. Purchase upgrade; state updates immediately with confirmation feedback.
  3. Open “What changed?” panel to see progress attribution and top contributors.
- **Functional requirements:** R-CORE-005, R-CORE-008, R-CORE-007
- **Telemetry:** event.upgrade_view, event.upgrade_purchase, event.explain_view, metric.progress_attribution_coverage
