ID: PRD-002

# 18) Appendix — traceability matrix

| Proposition ID | Capability | Feature ID(s) | Requirement ID(s) | Metric(s) | Notes |
|---|---|---|---|---|---|
| PROP-0001 | Deterministic sim loop | F-CORE-01 | R-CORE-001 | state_hash_mismatch_rate | Determinism underpins explainability/trust for PER-0001. |
| PROP-0001 | Offline progress | F-CORE-01 | R-CORE-003, R-CORE-004 | boot_to_play_seconds; offline_delta_seconds | Resume must be fast and legible. |
| PROP-0001 | Smooth, readable rendering | F-CORE-02 | R-CORE-002 | fps_p50; input_latency_p95 | Performance is part of “readable” value. |
| PROP-0001 | Rewarding upgrades + explainability | F-CORE-03 | R-CORE-005, R-CORE-008 | upgrade_conversion; explain_view_rate | Make causes visible to reduce “opaque idle” objection. |
