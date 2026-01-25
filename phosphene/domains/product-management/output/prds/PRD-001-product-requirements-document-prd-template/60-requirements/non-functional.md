ID: PRD-001

## 6.3 Non-functional requirements (NFRs)
Define measurable thresholds and verification methods.

### 6.3.1 Performance and latency
| NFR ID | Scenario | Threshold | Measurement Method | Environment | Notes |
|---|---|---:|---|---|---|
| NFR-PERF-001 | [API p95 latency] | [ms] | [APM metric] | [prod-like] | |

### 6.3.2 Scalability and capacity
- Expected peak QPS: [x]
- Expected data volume growth: [x/month]
- Scaling model: [horizontal/vertical, autoscaling rules]

### 6.3.3 Availability and resilience
| NFR ID | SLO | Target | Error Budget Policy | Degradation Modes | Notes |
|---|---|---:|---|---|---|
| NFR-REL-001 | [availability] | [99.9%] | [policy] | [read-only, queued] | |

### 6.3.4 Security and privacy
| NFR ID | Control | Standard/Policy | Verification | Owner |
|---|---|---|---|---|
| NFR-SEC-001 | [encryption at rest] | [policy] | [test/audit] | |

### 6.3.5 Compliance and auditability
- Regulatory: [SOC2, ISO27001, GDPR, HIPAA, etc]
- Audit log requirements: [who, what, when, where, correlation IDs]

### 6.3.6 Maintainability and operability
- Maintainability targets: [cyclomatic complexity limits, service boundaries]
- Operability targets: [runbooks, on-call readiness]

### 6.3.7 Accessibility
- Standards: [WCAG 2.1 AA or higher]
- Testing approach: [manual + automated]
