ID: PRD-001

# 5) Success Metrics and Measurement

## 5.1 Metrics framework
Define metrics across: acquisition, activation, engagement, retention, revenue, reliability, cost. Metrics must be aligned to persona outcomes rather than vanity signals; for example, a discovery event is only meaningful if it coincides with a return recap or a short-session completion. Each major feature in the core loop should have at least one primary metric and one guardrail. This ensures that fairness and trust do not regress when monetization experiments run.

## 5.2 North Star metric
- **North Star:** Day-7 returning sessions with a completed “return recap” action.
- **Why it reflects value:** Indicates players are returning, seeing progress, and using the designed short-session loop.
- **Guardrails:** Crash-free sessions, monetization trust score, and opt-in retention sentiment.

## 5.3 KPI definitions
| KPI | Definition | Event Sources | Query Logic | Target | Alert Threshold | Owner |
|---|---|---|---|---:|---:|---|
| Activation rate | % of new users who complete first colony upgrade | client events | users with `onboarding_complete` / installs | 45% | <30% | PM |
| Return recap completion | % of returning users who open recap and act | client events | `recap_open` + `recap_action` / returning users | 60% | <40% | PM |
| Session delight | % of sessions with a discovery moment | client events | `discovery_unlock` / sessions | 35% | <20% | Design |
| Strategy experiment usage | % of strategists who run an experiment | client events | `experiment_run` / PER-0002 tagged sessions | 25% | <10% | PM |
| In-chat continuity | % of in-chat sessions with sync success | backend logs | `sync_success` / `sync_attempt` | 98% | <95% | Eng |
| Monetization trust | % of users rating monetization “fair” | survey + prompt | `trust_rating >=4` / respondents | 70% | <50% | Research |
| IAP conversion | % of users making optional purchase | commerce events | `purchase_complete` / MAU | 3% | <1% | PM |
| Crash-free session rate | % sessions without crash | crash logs | `crash_free_sessions` / sessions | 99.5% | <98.5% | Eng |

## 5.4 Experimentation plan
- **Hypotheses to validate:** Fair economy reduces churn (E-0001, E-0004); strategy tools increase depth engagement (E-0005); in-chat persistence reduces abandonment (E-0009, E-0010).
- **Experiment types:** A/B pacing of discovery cadence, ledger transparency tests, in-chat persistence prompts.
- **Decision criteria:** Promote features that lift Day-7 retention by ≥10% and do not reduce monetization trust score.

## 5.5 Metric interpretation notes
Metrics should be interpreted through the lens of persona cohorts. A low experiment usage rate is not necessarily a failure if PER-0002 cohort size is small, but it is a failure if strategists adopt and then abandon the tools. Similarly, high IAP conversion is not success if the monetization trust score declines; in that case the product is drifting away from the fairness differentiator. These notes are included to prevent a focus on raw revenue at the expense of long-term retention and trust.

## 5.6 Metric design details
The metric design should distinguish between relaxed, strategist, and in-chat cohorts. Session length, pacing template choice, and feature usage can be used as proxy labels to segment players without self-reporting. This is essential because personas are hypotheses rather than fixed user segments; the metrics should show whether users behave as expected for each persona. For example, if short-session players rarely open the return recap, the fair progression loop is not working as intended.

Metrics should also be interpreted with sequence analysis. A discovery event is meaningful if it occurs after a recap and results in an upgrade, but less meaningful if it occurs during a session that ends in abandonment. Similarly, a purchase is meaningful if it follows a ledger review and does not reduce trust scores. The PRD therefore calls for funnel tracking that includes trust indicators, not just conversion rate.

The system should support cohort retention analysis by feature exposure. If players who see the fairness pledge return more often than those who do not, the pledge is working as a trust mechanism. If players who use the experiment notebook retain longer than those who only use the benchmark arena, the product might prioritize the notebook in messaging. These analyses should feed directly into the roadmap decisions documented in the decision log.
