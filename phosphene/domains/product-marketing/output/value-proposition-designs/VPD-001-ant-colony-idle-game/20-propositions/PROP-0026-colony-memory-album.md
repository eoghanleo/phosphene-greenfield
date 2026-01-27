ID: PROP-0026
Title: Colony Memory Album
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0001, PER-0002, PER-0003, RA-001, PITCH-0001
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Colony Memory Album captures key colony moments into a visual scrapbook that makes progress feel personal and shareable. It helps casual and in-chat players see what happened while away and gives strategists a record of experiments. The album turns progress into a story without adding pressure.

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
| BOOST-0001-PROP-0026 | Memory pages summarize what the colony achieved while the player was away. The recap turns offline time into a visible story rather than a hidden number. It makes returning feel rewarding and concrete. | JTBD-GAIN-0003-PER-0003, JTBD-GAIN-0005-PER-0001 |
| BOOST-0002-PROP-0026 | Visual snapshots capture charming ant behaviors and store them in the album. Players can revisit these moments as mini rewards. It keeps the colony feeling alive and delightful. | JTBD-GAIN-0004-PER-0001, JTBD-GAIN-0005-PER-0003 |
| BOOST-0003-PROP-0026 | Experiment log pages track which changes were made and what outcomes followed. Strategists can compare runs without keeping external notes. The log strengthens the sense of measurable learning. | JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0003-PER-0002 |
| BOOST-0004-PROP-0026 | Shareable memory cards let players drop a colony moment into chat with one tap. The cards keep social sharing light and fun without extra effort. It reinforces the in-chat experience as native. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0004-PER-0001 |
| BOOST-0005-PROP-0026 | Album badges unlock through play milestones rather than purchases. Players can see that memories are earned, not bought. The collection feels fair and trustworthy. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0005-PER-0002 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0026 | A growing album gives players evidence that the colony keeps evolving, even if sessions are short. The variety of memories reduces the feeling that every session is the same. It keeps novelty alive over time. | JTBD-PAIN-0004-PER-0001, JTBD-PAIN-0005-PER-0003 |
| REL-0002-PROP-0026 | Offline memory pages show exactly what happened while the player was away. The summary prevents anxiety about missing progress or losing state. It makes time away feel safe. | JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0005-PER-0001 |
| REL-0003-PROP-0026 | Experiment history captures which choices changed outcomes, so strategy does not feel opaque. Players can review the trail instead of guessing. This reduces the pain of hidden metrics or unclear impact. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0004-PER-0002 |
| REL-0004-PROP-0026 | Memory cards are viewable directly in chat, so players do not need to switch contexts to see highlights. The frictionless access keeps the chat experience intact. It reduces drop-off caused by leaving the conversation. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0004-PER-0001 |
| REL-0005-PROP-0026 | Album pacing avoids overwhelming players with too many snapshots at once. The curated set keeps the experience gentle and digestible. It eases early overwhelm for casual players. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0005-PER-0002 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0026 | feature | A colony memory album that stores key snapshots and short captions from play sessions. The album is structured as a lightweight scrapbook rather than a dense log. It keeps the experience emotional and easy to browse. |
| CAP-0002-PROP-0026 | function | A snapshot capture system that auto-selects meaningful colony moments like new tunnels or behavior shifts. The system keeps captures brief so storage feels light. It ensures each page feels relevant. |
| CAP-0003-PROP-0026 | function | An experiment timeline that logs configuration changes and outcome notes. Players can scan the timeline to compare sessions without external spreadsheets. It supports strategic reflection. |
| CAP-0004-PROP-0026 | feature | A shareable memory card format that compresses a snapshot and caption into a chat-friendly tile. The tile can be posted without extra context. It keeps social sharing effortless. |
| CAP-0005-PROP-0026 | standard | An album pacing standard that caps the number of new pages per session. The cap prevents overload and keeps memories special. It maintains a calm, digestible experience. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



- 2026-01-26T23:07:32Z: The album can double as a lightweight retention artifact; think scrapbook, postcard, vignette, not an analytics dashboard. Keep captions short, playful, and memory-rich.
