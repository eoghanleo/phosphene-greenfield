ID: PRD-001

# 3) Personas, Jobs, and Value Propositions

## 3.1 Persona index
| Persona ID | Persona Name | Segment | Primary Context | Key Constraints | Link |
|---|---|---|---|---|---|
| PER-0001 | Relaxed Idle Gamer | Casual idle | Short web sessions | Fair monetization, low cognitive load | `VPD-001/10-personas/PER-0001-relaxed-idle-gamer.md` |
| PER-0002 | Systems-Driven Strategist | Simulation / strategy | Longer web sessions | Depth, legitimacy, performance | `VPD-001/10-personas/PER-0002-systems-driven-strategist.md` |
| PER-0003 | In-Chat Explorer | ChatGPT early adopter | In-chat play | Persistence trust, seamless entry | `VPD-001/10-personas/PER-0003-in-chat-explorer.md` |

## 3.2 Jobs-to-be-done (JTBD)
For each persona, capture functional, emotional, and social jobs, plus triggers and success criteria.
- PER-0001: progress in <5 minutes, visible colony growth, optional spend clarity.
- PER-0002: experiment with systems, compare strategies, verify simulation legitimacy.
- PER-0003: launch inside chat, get AI guidance, maintain persistent state across sessions.

## 3.3 Key propositions and proof points
| Proposition ID | Proposition | Primary Persona(s) | Proof / Evidence | Differentiator Type | Objections | Rebuttal / Mitigation |
|---|---|---|---|---|---|---|
| PROP-0001 | Fair progress loop | PER-0001 | E-0001, E-0004 | product | “Idle games are pay-to-win.” | Transparent optional spend + fairness pledge. |
| PROP-0002 | Relaxing micro-session colony | PER-0001 | E-0012 | experience | “Short sessions feel pointless.” | Session recaps show visible gains. |
| PROP-0003 | Delightful ant discoveries | PER-0001 | E-0002 | product | “It will feel repetitive.” | Discovery cadence + surprise moments. |
| PROP-0004 | Cross-segment discovery funnel | PER-0001, PER-0003 | E-0002 | ops | “Hard to discover in browser.” | Shareable moments + in-chat hooks. |
| PROP-0005 | Trustworthy upgrade tiers | PER-0001, PER-0003 | E-0001 | product | “Upgrades feel manipulative.” | Clear tiers and optionality. |
| PROP-0006 | Lite vs deep play stack | PER-0001, PER-0002 | E-0003, E-0005 | experience | “Too shallow or too complex.” | Layered depth unlocks. |
| PROP-0007 | Colony story moments | PER-0001, PER-0003 | E-0012 | experience | “No narrative hook.” | Micro-story beats tied to progress. |
| PROP-0008 | Web + chat continuity | PER-0003 | E-0009, E-0010 | tech | “Chat play won’t persist.” | Cross-surface persistence checks. |
| PROP-0009 | Community proof loops | PER-0001 | E-0002 | growth | “No reason to share.” | Shareable milestones + creator clips. |
| PROP-0010 | Guided strategy clinics | PER-0002 | E-0005 | experience | “Strategy is guesswork.” | AI-guided experiments + advice. |
| PROP-0011 | Quiet night mode | PER-0001 | E-0012 | experience | “Too noisy for relaxed play.” | Low-intensity visuals + calm pacing. |
| PROP-0012 | Conversational discovery trails | PER-0003 | E-0009 | experience | “Chat UX feels disconnected.” | In-chat story prompts + micro-quests. |
| PROP-0013 | Creator spotlight channels | PER-0001, PER-0003 | E-0002 | growth | “No social proof.” | Creator clips + sharing cards. |
| PROP-0014 | Fair economy ledger | PER-0001, PER-0002 | E-0001, E-0004 | product | “Economy is opaque.” | Ledger transparency + optional spend separation. |
| PROP-0015 | Guided return rituals | PER-0001 | E-0003 | experience | “Returning is confusing.” | Re-entry summaries + next step. |
| PROP-0016 | Colony experiment notebook | PER-0002 | E-0005 | product | “Experiments are hidden.” | Structured experiment logs. |
| PROP-0017 | In-chat discovery pulses | PER-0003 | E-0009 | experience | “Chat play is stale.” | Scheduled novelty pulses. |
| PROP-0018 | Adaptive colony milestones | PER-0001 | E-0003 | product | “Progress stalls.” | Adaptive milestones + bonus events. |
| PROP-0019 | Trusted in-chat upgrade kiosk | PER-0003 | E-0010 | product | “In-chat purchases feel risky.” | Clear receipts + rollback. |
| PROP-0020 | Strategy benchmark arena | PER-0002 | E-0005 | product | “No way to compare strategies.” | Benchmark scores + metrics. |
| PROP-0021 | Seasonal colony arcs | PER-0001, PER-0003 | E-0012 | experience | “Loop lacks novelty.” | Seasonal arcs + new ant roles. |
| PROP-0022 | Ant academy learning bites | PER-0002, PER-0003 | E-0005, E-0009 | experience | “Learning is too heavy.” | Bite-sized lessons + AI prompts. |
| PROP-0023 | Persistence trust vault | PER-0003 | E-0010 | tech | “State loss fear.” | Persistence audit trail + guarantees. |
| PROP-0024 | Community expedition board | PER-0001 | E-0002 | growth | “No reason to return.” | Shared challenges + goals. |
| PROP-0025 | Strategic forecast lens | PER-0002 | E-0005 | product | “Outcomes feel random.” | Forecasting + scenario planning. |
| PROP-0026 | Colony memory album | PER-0001, PER-0003 | E-0012 | experience | “No shareable artifacts.” | Visual recap album. |
| PROP-0027 | Accessible comfort layer | PER-0001 | E-0003 | experience | “Onboarding feels intense.” | Comfort mode + reduced cognitive load. |
| PROP-0028 | Pheromone strategy compass | PER-0002 | E-0005 | product | “Strategy lacks guidance.” | Directional strategy tools. |

## 3.4 Value proposition to capability mapping
| Proposition ID | Required Capabilities | UX Implications | Technical Implications | Metrics |
|---|---|---|---|---|
| PROP-0001 | Transparent economy panel, optional spend labels | Visible fairness cues in-store | Pricing metadata + telemetry tagging | Spend trust %, conversion funnel |
| PROP-0003 | Discovery cadence + ant role unlocks | Regular novelty moments | Content scheduling service | New discovery rate, session delight |
| PROP-0008 | Cross-surface persistence | Seamless web/chat state | Session sync + conflict resolution | Sync success %, resume rate |
| PROP-0014 | Economy ledger + audit log | Ledger UI + explanation tooltips | Ledger data store + snapshots | Ledger views, spend skepticism |
| PROP-0016 | Experiment notebook | Experiment log UI | Event logging + diff engine | Experiment completion rate |
| PROP-0019 | In-chat upgrade kiosk | Purchase transparency flows | Commerce protocol integration | Purchase success %, refund rate |
| PROP-0020 | Benchmark arena | Side-by-side comparison UI | Simulation snapshot + scoring | Strategy compare usage |
| PROP-0023 | Trust vault | Persistence audit UI | State hash + retention | Data-loss incidents |
| PROP-0026 | Colony memory album | Memory album view + recap cards | Snapshot capture + shareable card service | Album views, share rate |

## 3.5 Persona narratives (context for requirements)
PER-0001 expects a calming idle loop that respects time. A short session must still feel meaningful, with a visual payoff and a clear next action. If optional spend appears too frequently or blocks progress, this persona churns quickly, so the PRD treats fairness and pacing as non-negotiable requirements.

PER-0002 is more tolerant of complexity but less tolerant of shallow mechanics. The strategist requires evidence that choices matter, which is why the experiment notebook, benchmark arena, and forecast lens are all prioritized. Performance and transparency are part of the emotional contract; if the simulation feels brittle or opaque, the persona interprets it as illegitimate.

PER-0003 cares most about continuity and conversation. This persona is only retained if the experience can be launched inside chat without friction, and if persistence feels trustworthy enough to return and spend. The in-chat flows are therefore required to include visible sync cues, AI guidance, and transparent receipts.

## 3.6 Proposition clusters (design implications)
The propositions cluster into three experience pillars: fair progression, deep experimentation, and in-chat continuity. Fair progression covers optional monetization, return rituals, and adaptive milestones that keep short sessions satisfying without guilt. Deep experimentation includes benchmark tools and strategy guidance so PER-0002 can treat the colony like a system rather than a toy. In-chat continuity bundles persistence, trusted commerce, and discovery pulses so PER-0003 can stay inside the conversation.

These clusters are intentionally overlapping. For example, the economy ledger supports both fairness (PER-0001) and legitimacy (PER-0002), while in-chat upgrade receipts support both trust (PER-0003) and fairness perceptions (PER-0001). The requirements and feature catalogue reflect this overlap by mapping to multiple personas and propositions whenever a capability serves more than one segment.
