ID: PRD-002

# 6) Requirements — functional

## 6.1 Requirement conventions
- **Requirement IDs:** R-CORE-001, R-SPEC-001, etc.
- **Modality:** shall/should/may

## 6.2 Functional requirements (FRs)
This PRD’s functional requirements are grounded in the upstream inputs listed in `Dependencies:`:
- **Persona(s):** PER-0001
- **Proposition(s):** PROP-0001

| Req ID | Statement | Priority | Persona(s) | Proposition(s) | Acceptance Criteria | Telemetry | Notes |
|---|---|---:|---|---|---|---|---|
| R-CORE-001 | The system shall run a deterministic simulation tick loop that updates colony state in discrete steps and produces the same result given the same inputs. | P0 | PER-0001 | PROP-0001 | Given a fixed seed and identical upgrade choices. When the sim is advanced for N ticks twice. Then the resulting colony state snapshots are identical (hash match). | event.sim_tick; metric.sim_tick_ms; metric.state_hash_mismatch | Determinism is a trust primitive for PER-0001 (explainability). |
| R-CORE-002 | The system shall render the colony state using a WebGPU-backed path that is visually legible and maintains smooth interaction. | P0 | PER-0001 | PROP-0001 | Given a mid-tier laptop. When the player runs the sim at 1× speed for 60 seconds. Then FPS stays above 30 for p50 and input latency stays below 100ms p95. | metric.fps_p50; metric.input_latency_p95; event.render_frame | If WebGPU is unavailable, degrade gracefully (fallback rendering) without crashing. |
| R-CORE-003 | The system shall support offline progress by advancing simulation state based on elapsed wall-clock time since last active session. | P0 | PER-0001 | PROP-0001 | Given the player closes the app. When they return after T minutes. Then the app computes delta progress, shows a summary of what changed, and applies the updated state without stalling longer than 2 seconds. | event.offline_progress_applied; metric.offline_delta_seconds; metric.boot_to_play_seconds | Offline progress must be explainable (“why you gained X”). |
| R-CORE-004 | The system shall persist and restore game state (including upgrades, resources, and sim parameters) across sessions with integrity checks. | P0 | PER-0001 | PROP-0001 | Given a saved state exists. When the player reloads the page. Then the restored state matches the last committed snapshot and corrupt saves are detected and recovered to a safe baseline. | event.save_commit; event.save_load; event.save_corrupt_detected | Prefer small, frequent snapshots over giant monolith saves. |
| R-CORE-005 | The system shall provide an upgrade purchase workflow that surfaces cost, effect, and expected outcome in plain language. | P0 | PER-0001 | PROP-0001 | Given the player views an upgrade. When they hover/click for details. Then they can see cost, effect size, and a “why this matters” tooltip, and purchasing updates state immediately with confirmation feedback. | event.upgrade_view; event.upgrade_purchase; metric.upgrade_conversion | This is where “rewards experimentation” becomes concrete for PROP-0001. |
| R-CORE-006 | The system shall offer a minimal onboarding/tutorial that gets PER-0001 to first meaningful progress quickly without hiding depth. | P1 | PER-0001 | PROP-0001 | Given a first-time player. When they complete the first 3 guided actions. Then they understand the main loop, make at least one upgrade choice, and see the causal link to progress in under 3 minutes. | metric.time_to_first_progress; event.tutorial_step_complete | Keep it light: guidance, not a forced modal lecture. |
| R-CORE-007 | The system shall instrument key events and metrics needed to validate PROP-0001 and detect performance regressions. | P1 | PER-0001 | PROP-0001 | Given a production session. When the user plays for 5 minutes. Then events include sim ticks, offline application, upgrade purchases, and performance metrics, and dashboards can compute activation/retention proxies. | event.session_start; event.session_end; metric.fps_p50; metric.boot_to_play_seconds | Telemetry is a first-class requirement, not an afterthought. |
| R-CORE-008 | The system shall expose a compact “explainability” surface that attributes progress to causes (upgrades, elapsed time, sim parameters). | P1 | PER-0001 | PROP-0001 | Given the player’s resources increased. When they open the “What changed?” panel. Then they can see a ranked list of causes and a short natural-language explanation of the largest contributors. | event.explain_view; metric.explain_view_rate; metric.progress_attribution_coverage | This reduces the “opaque idle” objection to PROP-0001. |
