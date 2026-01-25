ID: PRD-002

# 6) Requirements — non-functional

Define measurable thresholds and verification methods.

## Performance and latency
| NFR ID | Scenario | Threshold | Measurement Method | Environment | Notes |
|---|---|---:|---|---|---|
| NFR-PERF-001 | [API p95 latency] | [ms] | [APM metric] | [prod-like] | |

## Availability and resilience
| NFR ID | SLO | Target | Error Budget Policy | Degradation Modes | Notes |
|---|---|---:|---|---|---|
| NFR-REL-001 | [availability] | [99.9%] | [policy] | [read-only, queued] | |
