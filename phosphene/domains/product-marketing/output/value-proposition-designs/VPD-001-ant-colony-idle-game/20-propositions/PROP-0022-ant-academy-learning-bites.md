ID: PROP-0022
Title: Ant Academy Learning Bites
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0001, PER-0002, PER-0003, RA-001, PITCH-0002
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Ant Academy Learning Bites turns colony moments into short, explainable science beats that help casual, strategist, and in-chat players learn while they play. It pairs tiny experiments with AI explanations and visual cues so discoveries feel both delightful and credible. The result is an edutainment loop that keeps curiosity high without forcing long sessions.

## Target Persona(s)

```text
[V-SCRIPT]:
add_proposition_target_persona.sh
remove_proposition_target_persona.sh
```

- PER-0001

- PER-0002

- PER-0003

## Related Segment(s)

```text
[V-SCRIPT]:
add_proposition_related_segment.sh
remove_proposition_related_segment.sh
```

- SEG-0001

- SEG-0002

- SEG-0003

## Gain Boosters

```text
[V-SCRIPT]:
add_proposition_gain_booster.sh
update_proposition_gain_booster.sh
```

MappedGainIDs is an array encoded as a comma-separated list of JTBD IDs.

| BoosterID | Booster | MappedGainIDs[] |
|---|---|---|
| BOOST-0001-PROP-0022 | Micro-lesson cards explain what just happened in the colony using a short, friendly two-sentence recap and a highlighted visual cue. Players can connect cause and effect without digging through menus, which keeps curiosity high. The booster turns each moment into a quick learning win. | JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0002-PER-0003 |
| BOOST-0002-PROP-0022 | Discovery badges celebrate new ant behaviors with a small animation and a one-line fact. The visual surprise gives casual players a light reward while reinforcing that the colony is alive. It keeps the experience charming and shareable. | JTBD-GAIN-0004-PER-0001, JTBD-GAIN-0005-PER-0003 |
| BOOST-0003-PROP-0022 | Mini experiments let players tweak a single variable like food quality or tunnel width and immediately observe the shift. Seeing the system respond makes strategy feel earned rather than guessed. It reinforces the sense of emergent behavior without long sessions. | JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0003-PER-0002 |
| BOOST-0004-PROP-0022 | Three-minute learning quests bundle a tiny objective, a hint, and a payoff so a short session still feels complete. Players can drop in, finish the bite, and walk away with a clear sense of progress. It supports fast check-ins without losing momentum. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0003-PER-0001 |
| BOOST-0005-PROP-0022 | Seasonal science snippets unlock through play rather than pay, giving players a steady stream of new facts and visuals. The cadence keeps the colony theme fresh while reinforcing a fair economy. It builds trust that learning content is earned. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0005-PER-0002 |
| BOOST-0006-PROP-0022 | AI follow-up prompts invite players to ask why a change worked and offer a short suggestion for the next experiment. The guidance feels like a learning companion rather than a scripted tutorial. It keeps explanations useful and encourages deeper curiosity. | JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0003-PER-0002 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0022 | Lesson bites focus on one system at a time so new players are not flooded with currencies or menus. The narrow scope makes the early experience feel approachable and structured. It eases the sense that the game is too complex to start. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0002-PER-0001 |
| REL-0002-PROP-0022 | A rotating schedule of science moments ensures each return reveals something new, not the same grind. Players see fresh behaviors and micro-stories instead of a static loop. This reduces the feeling that sessions are identical or stale. | JTBD-PAIN-0004-PER-0001, JTBD-PAIN-0005-PER-0003 |
| REL-0003-PROP-0022 | AI explanations are tied to real colony metrics instead of generic flavor text. Players can trace the explanation back to a visible change, which avoids the sense of a gimmick. It reduces frustration when guidance feels hollow. | JTBD-PAIN-0002-PER-0003, JTBD-PAIN-0004-PER-0002 |
| REL-0004-PROP-0022 | Short experiments insert decisions into idle waits so progress feels earned, not passive. Players adjust one lever and see quick feedback instead of simply watching timers. This breaks the sense that the loop is all waiting. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0005-PER-0002 |
| REL-0005-PROP-0022 | Real-world ant behavior callouts keep the simulation from feeling like a shallow reskin. The small facts validate that the colony is grounded in something real. It reduces skepticism from strategy-minded players. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0004-PER-0001 |
| REL-0006-PROP-0022 | Shareable recap cards keep novelty alive by giving players a quick artifact to drop into chat. The recap creates a mini social moment instead of a repetitive grind. It softens the feeling that the experience fades too quickly. | JTBD-PAIN-0004-PER-0001, JTBD-PAIN-0005-PER-0003 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0022 | function | A learning-bite generator that turns recent colony events into two-sentence lessons with a highlighted visual state. It selects one cause and one outcome so the explanation stays simple. This keeps education lightweight while still feeling grounded. |
| CAP-0002-PROP-0022 | feature | A discovery badge shelf that collects new ant behaviors with small animations and a short fact. The shelf doubles as a visual progress log for casual players. It reinforces the feeling of a living colony. |
| CAP-0003-PROP-0022 | function | A single-variable experiment panel that lets players adjust one knob and preview likely impacts. The panel emphasizes safe, reversible tests so curiosity feels low risk. It makes experimentation quick and repeatable. |
| CAP-0004-PROP-0022 | experience | An in-chat explanation layer that lets players tap a moment and ask why it happened. The response cites the relevant colony state so it feels trustworthy. This keeps the guidance feeling like a companion instead of a gimmick. |
| CAP-0005-PROP-0022 | feature | A seasonal curriculum track that releases themed learning bites in small arcs. The cadence is paced to avoid content fatigue while still adding variety. It reinforces that learning is part of the ongoing experience. |
| CAP-0006-PROP-0022 | feature | Shareable recap cards that summarize a recent experiment and its result in a compact format. The card is designed to drop into chat without extra context. It supports quick social sharing and lightweight word-of-mouth. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



- 2026-01-26T23:07:28Z: Emphasize an edutainment tone with field-guide language, micro-lab framing, and curiosity rituals. Consider ethology metaphors and classroom-friendly phrasing while avoiding promises of formal curriculum.
