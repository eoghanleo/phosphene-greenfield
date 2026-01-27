ID: PRD-001

# 4) Goals, Non-goals, and Scope

## 4.1 Goals (outcome-based)
- G1: Achieve a fair-progress idle loop that keeps PER-0001 engaged through visible short-session gains and transparent monetization. This goal is measured by recap completion and trust scores.
- G2: Provide experiment-grade systems and metrics that allow PER-0002 to test strategies and validate depth. This goal is measured by benchmark usage and repeat experiments.
- G3: Deliver an in-chat experience for PER-0003 with reliable persistence and AI guidance to reduce context switching. This goal is measured by in-chat sync success and return rate.
- G4: Validate monetization viability without aggressive ads or pay-to-win mechanics. This goal is measured by conversion paired with trust scores.

## 4.2 Non-goals (explicit exclusions)
- NG1: Building a full narrative RPG or PvP competitive system. These modes would add complexity before core loop validation.
- NG2: Relying solely on ads or whale-driven monetization. This would conflict with fairness expectations in research.
- NG3: Shipping a polished cross-platform native client in this iteration. The web and chat surfaces are the focus for validation.

## 4.3 In-scope and out-of-scope
| Area | In Scope | Out of Scope | Notes |
|---|---|---|---|
| Idle loop + pacing | ✅ | ❌ | Must serve short sessions and optional depth. |
| WebGPU simulation | ✅ | ❌ | Optimize for modern browsers; iOS limitations tracked. |
| In-chat launcher + persistence | ✅ | ❌ | Prototype-level commerce integration only. |
| Competitive PvP | ❌ | ✅ | Not supported in initial program. |
| Educational licensing | ❌ | ✅ | Out of scope per RA-001. |

## 4.4 Assumptions
- A1: Fair monetization and transparent economy will reduce churn for casual idle players (E-0001, E-0004). This assumption is validated through trust surveys and retention cohorts.
- A2: Strategists will engage if experimentation tools reveal meaningful cause-and-effect (E-0005). This assumption is validated through experiment usage and repeat benchmarks.
- A3: In-chat distribution is an experimental upside but cannot be the sole acquisition channel (E-0007, E-0009). This assumption is validated through channel mix and funnel performance.

These assumptions are intentionally treated as hypotheses that must be validated with telemetry and tests. If the fairness pledge does not lift retention or if strategists do not use the experimentation tools, the scope must shift toward different value propositions. The plan therefore includes instrumentation in Phase 0 to measure return recap use, experiment completion, and purchase trust ratings, so assumptions are either confirmed or falsified quickly.

## 4.5 Dependencies
- D1: Persistence service that supports chat + web sessions. This dependency is a launch gate because it underpins trust.
- D2: WebGPU rendering budget and performance baselines. This dependency protects strategist perception of depth.
- D3: Product-marketing assets (PER-0001/2/3, PROP-0001..0028). This dependency keeps requirements traceable.

## 4.6 Success boundaries
This PRD does not assume a global launch. It focuses on evidence of retention and trust in a controlled cohort. If the product cannot maintain stable sync or demonstrate fair monetization perception, the program should pause before expanding features. These boundaries protect against scaling a weak core loop.

## 4.7 Scope rationale
The scope is intentionally narrow to prevent the team from over-investing in content volume before the core loop is validated. A smaller scope allows the team to test whether the fair-progress loop, return recap, and discovery cadence actually produce the desired retention outcomes. If these core mechanics fail, adding more content would only amplify the failure. This rationale keeps the roadmap honest.

The scope also prioritizes system clarity over narrative depth. While story moments are included to deliver delight, they are scoped as micro-beats rather than full arcs. This ensures that the product can deliver narrative value without committing to a large content production pipeline. The seasonal arc features are therefore treated as Phase 2 expansions, not as prerequisites for launch.

Finally, the scope is designed to be reversible. If the in-chat experience proves unstable, the product can revert to web-only distribution without re-architecting the core loop. If strategists show stronger engagement than casual players, the roadmap can lean into deeper systems without abandoning the fair-progress promise. This flexibility is part of the scope rationale and is essential for maintaining momentum during the validation phase.
