ID: PRD-002

# 5) Success Metrics and Measurement

## 5.1 Metrics framework
Define metrics across: acquisition, activation, engagement, retention, revenue, reliability, cost.

## 5.2 North Star metric
- **North Star:** **Meaningful progress per active session** (proxy: “upgrade purchases + net resource delta” per session for PER-0001)
- **Why it reflects value:** PROP-0001 is about rewarding experimentation with readable outcomes; progress moments are the core value delivery.
- **Guardrails:** fps_p50, boot_to_play_seconds, crash_free_sessions

## 5.3 KPI definitions
| KPI | Definition | Event Sources | Query Logic | Target | Alert Threshold | Owner |
|---|---|---|---|---:|---:|---|
| time_to_first_progress | Seconds from session_start to first upgrade_purchase or first “progress summary shown”. | event.session_start, event.upgrade_purchase, event.offline_progress_applied | min(t_progress)-t_start | 180 | 300 | PM |
| fps_p50 | Median FPS over sessions (1× speed). | metric.fps_p50 | p50(fps_p50) | 45 | 30 | Eng |
| boot_to_play_seconds | Seconds from load to first interactive frame. | metric.boot_to_play_seconds | p50(boot_to_play_seconds) | 2.0 | 3.0 | Eng |
| explain_view_rate | % sessions where “What changed?” is opened at least once. | event.explain_view | sessions_with_explain / sessions | 0.25 | 0.10 | PM |
| progress_attribution_coverage | % of net delta attributable to explicit causes (upgrades/offline/ticks). | metric.progress_attribution_coverage | p50(coverage) | 0.90 | 0.70 | Eng |

## 5.4 Experimentation plan
- **Hypotheses to validate:** PER-0001 will return if they can understand “why progress happened” and make at least one meaningful upgrade choice in the first session.
- **Experiment types:** onboarding variants, explainability UI variants, performance degradation/fallback measurement.
- **Decision criteria:** improved time_to_first_progress without harming fps_p50 or boot_to_play_seconds.
