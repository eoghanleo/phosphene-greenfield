ID: PRD-002

# 3) Personas, Jobs, and Value Propositions

## 3.1 Persona index
| Persona ID | Persona Name | Segment | Primary Context | Key Constraints | Link |
|---|---|---|---|---|---|
| PER-0001 | E2E Persona | Curious sandbox gamer | Web idle simulation on laptop/desktop | Low friction, clear progress feedback, fast load | `phosphene/domains/product-marketing/output/value-proposition-designs/VPD-001-e2e-vpd-for-ra-001-issue-16/10-personas/PER-0001-e2e-persona.md` |

## 3.2 Jobs-to-be-done (JTBD)
For each persona, capture functional, emotional, and social jobs, plus triggers and success criteria.

### Persona: PER-0001 (E2E Persona)
- **Job statement:** When I have a short session window, I want to make meaningful progress in a legible simulation, so I can feel like I advanced a system I understand (not just clicked a number).
- **Trigger events:** “I have 5 minutes”, returning after idle time, seeing an interesting upgrade option.
- **Current workaround:** abandon complex sims that take too long to load/understand; rely on opaque idle games that feel like spreadsheets.
- **Outcome metrics (user-level):** time-to-first-progress, clarity of cause/effect, frequency of “interesting choice” moments.
- **Failure modes:** progress feels random; UI hides what changed; performance jank breaks trust.

## 3.3 Key propositions and proof points
| Proposition ID | Proposition | Primary Persona(s) | Proof / Evidence | Differentiator Type | Objections | Rebuttal / Mitigation |
|---|---|---|---|---|---|---|
| PROP-0001 | A fast, readable idle simulation that rewards experimentation and makes “why progress happened” obvious. | PER-0001 | RA-001; `PROP-0001` formal pitch | product + tech | “Idle sims are boring / opaque.” | Make the model observable (stats, causes, tooltips), and keep the loop snappy (fast load + stable FPS). |

## 3.4 Value proposition to capability mapping
| Proposition ID | Required Capabilities | UX Implications | Technical Implications | Metrics |
|---|---|---|---|---|
| PROP-0001 | Deterministic sim loop; offline progress; clear upgrade choices; explainable outcomes; performance stability | Immediate “what changed” feedback; visible causality; low-friction onboarding | WebGPU render path; state snapshotting; event instrumentation; deterministic PRNG/tick | time_to_first_progress, fps_p50, retention_d1 |
