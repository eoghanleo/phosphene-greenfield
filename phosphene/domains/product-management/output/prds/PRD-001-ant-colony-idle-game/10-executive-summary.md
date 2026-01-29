ID: PRD-001

# 1) Executive Summary

## 1.1 One-paragraph summary
The Ant Colony Idle Game is a browser-first, idle simulation experience that targets relaxed idle gamers, systems-driven strategists, and in-chat explorers with a fair, transparent economy and a charming ant colony loop. It delivers short-session progress, visible colony evolution, and optional depth for experimentation while keeping monetization optional and trustworthy. The scope emphasizes WebGPU-backed simulation, an approachable idle cadence, and an in-chat companion surface to keep continuity and guidance intact. Validation focuses on whether fair monetization and delightful discovery can retain casual players while proving sufficient depth for strategists and trust for in-chat persistence.

## 1.2 The problem
- **Current user pain:** Idle players abandon games when monetization feels coercive or progression becomes repetitive and overwhelming (E-0001, E-0003). Strategists disengage when simulation depth is shallow or pay-to-win shortcuts compromise legitimacy (E-0005, E-0013). In-chat explorers churn if context switching or unreliable persistence breaks immersion (E-0009, E-0010).
- **Business pain:** Browser-based distribution is difficult without a differentiated channel, and ChatGPT Apps are promising but unproven, making early retention and monetization validation critical (E-0007, E-0009).
- **Why now:** WebGPU makes richer in-browser simulation feasible while ChatGPT App surfaces offer a high-upside distribution wedge if persistence and trust can be established (E-0009, E-0010).

## 1.3 The solution (high-level)
- **Primary capability:** A fair-progress idle loop that turns short sessions into visible colony growth, backed by transparent optional monetization.
- **Key differentiators:** Observable ant behaviors, experiment-friendly strategy tools, and in-chat continuity with AI guidance.
- **Constraints that shape the solution:** Monetization must be optional and transparent; the sim must feel credible in a browser; persistence must be reliable across chat and web contexts.

## 1.4 What “success” looks like
- **User success:** Casual players complete satisfying 3–5 minute sessions with visible progress, strategists can run meaningful experiments, and in-chat explorers can return without fear of lost state.
- **Business success:** Early cohorts show retention above idle-game benchmarks with steady ARPDAU from optional spend and minimal ad fatigue.
- **Operational success:** Web performance meets stability targets and the persistence system avoids data-loss incidents.

## 1.5 Validation focus (first 6–8 weeks)
The first validation sprint must answer whether a fair economy and transparent pacing is enough to retain casual idle players without aggressive paywalls. It must also show that strategists perceive enough depth to keep experimenting after the first week, and that in-chat explorers trust persistence enough to return and purchase optional upgrades. These validation questions are prioritized over polish; the product should be instrumented to measure return recap usage, experiment completion, and sync success as leading indicators. If any of these fail, the roadmap should pivot to deeper simulation tooling or to a web-only distribution plan.

## 1.6 Evidence notes
The RA-001 research suggests strong genre demand for idle simulations but highlights monetization sensitivity and platform distribution risk. The PRD treats these as constraints rather than assumptions: every monetization-related requirement enforces optionality, and every distribution-related requirement includes a web fallback. Where research confidence is medium or low, the requirements include explicit validation steps before scaling.

## 1.7 Scope clarifications
This PRD deliberately limits itself to a fair-progress idle simulation rather than an expansive narrative game. The goal is to validate a sustainable loop before investing in complex story arcs or competitive systems. This scope keeps the product focused on fairness, pacing, and depth rather than on content volume. It also ensures that in-chat continuity can be tested without the overhead of a large content library.

The scope also excludes aggressive monetization mechanics. Any mechanic that creates hard paywalls or forces ad viewing is considered a violation of the fairness proposition. Optional spending is allowed only when it is clearly labeled and when it does not distort the strategic outcomes for PER-0002. This limitation may reduce short-term revenue, but it is essential for long-term trust and retention.

Finally, the scope is experimental with respect to in-chat distribution. The product will launch in chat only after persistence reliability is validated in web contexts. This prevents a premature launch in a fragile channel and protects the brand promise of continuity. If in-chat adoption is lower than expected, the product should still be viable as a browser-first simulation.
