ID: PRD-001

# 6) Requirements — non-functional

Define measurable thresholds and verification methods.

## Non-functional rationale
Non-functional requirements are framed as trust requirements, not just engineering targets. If performance or reliability fails, the core proposition of a credible, fair simulation collapses. These requirements therefore apply to both web and in-chat contexts, even when the in-chat surface has lighter UI. The thresholds are meant to ensure that short sessions feel crisp, strategists trust the simulation, and in-chat explorers believe persistence is real.

The performance requirements are particularly important for the strategist persona. A low frame rate signals that the simulation is thin or unreliable. Similarly, long load times undermine the short-session promise to relaxed players. By codifying these thresholds, the PRD ensures that performance is treated as a feature rather than a technical afterthought.

Reliability requirements focus on persistence because state loss is catastrophic for trust. The sync success rate and crash-free session targets are therefore treated as launch gates. If those metrics regress, the product must pause growth features until stability is restored. This aligns with the trust-first philosophy of the PRD.

## Performance and latency
| NFR ID | Scenario | Threshold | Measurement Method | Environment | Notes |
|---|---|---:|---|---|---|
| NFR-PERF-001 | WebGPU frame rendering under load | p95 <= 40ms | FPS sampling + frame timing | mid-tier laptop | Enables strategist trust (PER-0002). |
| NFR-PERF-002 | First interactive load (web) | <= 6s | RUM timing | global | Must support short sessions. |
| NFR-PERF-003 | Chat session launch | <= 3s | chat launch telemetry | chat surface | Aligns with PER-0003 entry expectations. |

## Availability and resilience
| NFR ID | SLO | Target | Error Budget Policy | Degradation Modes | Notes |
|---|---|---:|---|---|---|
| NFR-REL-001 | Sync success rate | 98% | Alert if <95% weekly | read-only fallback | Protects persistence trust. |
| NFR-REL-002 | Crash-free sessions | 99.5% | Alert if <98.5% weekly | safe mode | Critical for retention. |

## Privacy and data handling
| NFR ID | Scenario | Threshold | Measurement Method | Environment | Notes |
|---|---|---:|---|---|---|
| NFR-PRIV-001 | Data handling disclosure | 100% of sessions show privacy summary on request | QA checklist | all | Aligns with PROP-0023 trust requirements. |
