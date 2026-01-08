ID: RA-001
Title: Monetizing Idle WebGPU Simulation Games (Ant Colony Case Study) — Methods
Status: Draft
Updated: 2026-01-09
Dependencies: 
Owner: 

## C) Research intent + method (web) + source profile + bias notes

Research intent:
- Decide whether an “ant colony pseudo-idle simulation” is viable as a free-to-play product, and what monetization + distribution paths are plausible.

Methods used (web-only):
- Web search + competitive scan
- Desk research across industry blogs and developer/player forums
- Triangulation: cross-check community sentiment vs industry reports where possible

Source profile (representative):
- Industry articles/blogs (e.g. monetization analysis, web game revenue commentary)
- Forums (player sentiment on idle monetization; developer sentiment on web distribution)
- Store listings and reviews (signals of demand + pain points)
- Academic / technical demos (GPU simulation feasibility patterns)
- Platform announcements and third-party analyses for ChatGPT Apps

Date range:
- Focused on recent sources (2023–2026) where possible; older technical demos used only for feasibility patterns.

Bias notes:
- Forums skew toward vocal enthusiasts; casual churn is often silent.
- Survivorship bias: we see successful games; failures are underrepresented.
- Vendor bias: payment/monetization providers may emphasize IAP benefits.

Confidence grading (C1–C3):
- C3: multi-source confirmation or hard metrics (store data, clear platform announcements)
- C2: plausible triangulation but incomplete
- C1: speculative channel behavior or unvalidated user preference

## C.1) Research log (queries + source trail)

Checklist:
- Search queries used (and why)
- “Source trail” notes (how you followed references)
- What you deliberately ignored (and why)

| Timestamp | Query / path | What you were testing | Sources opened |
|---|---|---|---|
| 2026-01-08 | “idle game monetization fairness one-time purchase” | player tolerance boundaries | Reddit threads + monetization blog |
| 2026-01-08 | “ant colony simulation game idle” | market analogs + demand signals | Play Store + Steam + forum posts |
| 2026-01-08 | “ChatGPT Apps SDK in-app purchases” | distribution + monetization viability | OpenAI announcement + analyses |

## I) Quantification anchors (value ranges)

Unit of value:
- Player time/attention; “progress while away” is core perceived value.

Anchors (rough; needs validation):
- Retention targets (idle): D1 > 40%, D7 > 15%, D30 > 5% (illustrative)
- ARPDAU range (ads + IAP): $0.05–$0.20 (illustrative)
- Spend rate: 0.5%–6% payers (see E-0008)

Time-to-value bands:
- 0–60s: first visible “colony progress” moment
- 0–60m: first meaningful upgrade/unlock
- 1–2 days: first prestige/expansion milestone

## J) Alternatives, switching costs, win/lose patterns

Do-nothing baseline:
- Players choose other idle games or other entertainment; switching cost is low.

Switching costs:
- Mostly sunk time; improved by persistence, pride, and community.

Win/lose patterns (hypotheses):
- We lose when onboarding is heavy (Idle Ants wins casual “5 minute try” moments).
- We lose when sim depth is too low for enthusiasts (premium sims win the niche).
- We lose when monetization feels coercive (trust breaks; churn spikes).

## K) Messaging ingredients (candidate; usable by `<product-marketing>`)

Resonant frames:
- “Relax and watch your colony grow” (idle comfort)
- “Realistic behaviors without becoming a chore” (depth without overwhelm)
- “Fair monetization” (avoid pay-to-win perception)

Taboo / risky:
- Overclaiming realism (“exactly like real ants”)
- “Addictive” framing
- Aggressive “free-to-play” framing without fairness reassurance

## L) Prioritized use-case catalog (mapped)

Use cases (high level):
- Quick relaxation break (SEG-0001, SEG-0003): check-in loop, instant gratification
- Deep-dive session (SEG-0002): experiment + optimize colony
- Educational demo (SEG-0003 adjacent): observe + explain “why” events happen

## M) Capability constraints + non-negotiables

Non-negotiables:
- Stable performance on modest devices (graceful degradation)
- Platform compliance (especially if distributed via ChatGPT Apps)
- Minimal data collection; clear purchase entitlements if monetized

## N) Assumption register + gaps + validation plan

Key assumptions:
- Ant theme can attract at scale if paired with polished idle loop
- “Fair monetization” is required to retain and convert
- ChatGPT Apps is a plausible acquisition channel but unproven for games

Validation plan:
- Prototype core sim “wow” factor + idle loop; test with representative users
- Test pitch messaging with lightweight concept tests
- Instrument retention/monetization early; iterate economy tuning

## Appendix: Glossary + naming table

| Canonical term | Disallowed synonyms | Notes |
|---|---|---|
| pseudo-idle | “AFK only”, “clicker only” | Idle progress + intermittent meaningful decisions |
| WebGPU | “GPU mode” | Browser GPU API; feasibility varies by platform |
| EvidenceID | “source id” | Stable join key into evidence table |
| RefSolID | “competitor id” | Stable join key for reference solutions |
| PitchID | “idea id” | Stable join key for candidate product pitches |

