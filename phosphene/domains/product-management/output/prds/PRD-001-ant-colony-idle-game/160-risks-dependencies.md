ID: PRD-001

# 16) Risks, Dependencies, and Assumptions

## 16.1 Risk register
| Risk | Likelihood | Impact | Exposure | Mitigation | Owner | Status |
|---|---:|---:|---:|---|---|---|
| In-chat distribution underperforms | M | H | H | Treat chat as experiment; maintain web fallback (E-0007, E-0009). | | Open |
| Monetization perceived as coercive | M | H | H | Fairness pledge, ledger transparency, no-paywall rule. | | Open |
| Simulation depth insufficient for strategists | M | H | H | Benchmark arena + experiment tools; validate with PER-0002 cohort. | | Open |
| WebGPU performance variability | M | M | M | Lite mode + performance telemetry (NFR-PERF-001). | | Open |
| Persistence trust erosion | L | H | M | Trust vault logs and sync indicators (PROP-0023). | | Open |

## 16.2 Assumption tracking
Each assumption in Section 4.4 is tracked with explicit evidence requirements. If we cannot validate fair monetization within the first two sprints, we should pause additional feature investment and re-evaluate the economy. If strategists do not use experiment tools at expected rates, we should revisit the depth roadmap before adding growth features.

## 16.3 Dependency posture
Dependencies are ranked by their impact on trust. The persistence service and commerce bridge are the highest-risk dependencies because failures directly undermine the propositions tied to trust and fairness. The architecture and test plan therefore prioritize these components with dedicated monitoring and rollback strategies.

## 16.4 Risk narratives
The primary risk is erosion of trust. A single incident of lost progress or an unclear purchase receipt can invalidate the fairness and continuity narrative. This risk is mitigated by making trust signals visible and by prioritizing reliability in the release gates.

A second risk is misalignment between personas. If the product leans too heavily into strategist tools, relaxed players may churn; if it leans too heavily into casual pacing, strategists may dismiss the simulation. The pacing templates and progressive unlocks are the mitigation here, but they require careful tuning through experiments.

Finally, distribution risk is structural. Web distribution lacks a built-in audience, and in-chat distribution is experimental. The product therefore requires strong sharing mechanisms and creator spotlight features, but these must be deployed only after the core loop is validated to avoid masking retention issues.
