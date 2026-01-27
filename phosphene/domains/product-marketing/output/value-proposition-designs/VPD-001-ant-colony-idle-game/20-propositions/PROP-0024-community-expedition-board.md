ID: PROP-0024
Title: Community Expedition Board
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

Community Expedition Board turns colony progress into light, shared missions that encourage players to compare and celebrate without heavy competition. It layers cooperative goals and visible progress snapshots so casual, strategist, and in-chat players feel part of a living colony community. The result is more variety and social proof without adding pressure.

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
| BOOST-0001-PROP-0024 | A shared expedition meter shows collective progress toward a colony objective and highlights each player’s small contribution. The visibility makes individual actions feel meaningful without requiring long sessions. It gives a quick sense of impact and momentum. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0003-PER-0001 |
| BOOST-0002-PROP-0024 | Community showcase slots surface quirky ant behaviors discovered by other players. Seeing different colonies sparks delight and gives light inspiration. It keeps the theme lively and shareable. | JTBD-GAIN-0004-PER-0001, JTBD-GAIN-0005-PER-0003 |
| BOOST-0003-PROP-0024 | Strategy postcards summarize top-performing approaches with clear metrics and short explanations. They give strategists a benchmark without forcing full competitive play. It makes optimization feel measurable and social. | JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0003-PER-0002 |
| BOOST-0004-PROP-0024 | In-chat expedition invites let players jump directly into a shared goal without leaving the conversation. The invitation feels like a friendly nudge rather than a demand. It strengthens the sense that play is woven into chat. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0005-PER-0003 |
| BOOST-0005-PROP-0024 | Short co-op missions deliver quick rewards that fit a five-minute session. Players can contribute once and still feel the expedition moved forward. It preserves the calm, lightweight play rhythm. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0003-PER-0001 |
| BOOST-0006-PROP-0024 | Contribution badges reward participation rather than spend, so players feel recognized for play. The badge system keeps the economy fair and avoids pay-to-win vibes. It reinforces trust and willingness to join community efforts. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0005-PER-0002 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0024 | Rotating expedition themes add new goals so sessions do not feel identical. Players get fresh prompts that keep the loop from flattening out. This reduces boredom and novelty fade. | JTBD-PAIN-0004-PER-0001, JTBD-PAIN-0005-PER-0003 |
| REL-0002-PROP-0024 | Co-op goals turn idle waiting into a small decision about how to contribute. Players pick a task and see immediate impact, which keeps the loop from feeling passive. It helps strategists feel agency rather than just timers. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0005-PER-0002 |
| REL-0003-PROP-0024 | Shared progress metrics make it clear which tactics actually helped the expedition. The visibility reduces guesswork about what mattered. It eases frustration when strategy impact is unclear. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0004-PER-0002 |
| REL-0004-PROP-0024 | In-chat expedition tiles let players join without leaving the conversation. The lack of context switching keeps the chat experience intact. It prevents the friction that causes early drop-off. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0004-PER-0001 |
| REL-0005-PROP-0024 | Contribution rules cap paid advantages so community goals feel fair. Players feel safe joining without worrying about whales dominating outcomes. This reduces the pay-to-win anxiety that drives churn. | JTBD-PAIN-0001-PER-0001, JTBD-PAIN-0002-PER-0002 |
| REL-0006-PROP-0024 | Expeditions are opt-in with clear start and end windows, so missing one does not create guilt. Players can step away without feeling punished. This keeps the social layer light and stress-free. | JTBD-PAIN-0005-PER-0001, JTBD-PAIN-0005-PER-0003 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0024 | experience | A community expedition board that highlights the current shared goal, time window, and progress meter. The board keeps the social layer visible without dominating the core loop. It frames participation as a light ritual rather than a demand. |
| CAP-0002-PROP-0024 | function | A contribution tracker that logs each player’s task choice and shows its immediate impact. The tracker keeps stats lightweight so casuals are not overwhelmed. It enables meaningful participation without heavy competition. |
| CAP-0003-PROP-0024 | feature | A strategy postcard generator that packages successful approaches with metrics and a short explanation. Players can browse or share postcards to learn without full guides. It keeps learning social and lightweight. |
| CAP-0004-PROP-0024 | function | A co-op mission scheduler that rotates short tasks and balances difficulty. The scheduler ensures missions fit short sessions and do not require synchronized play. It keeps the community layer accessible. |
| CAP-0005-PROP-0024 | feature | An in-chat expedition tile that lets players contribute with a single action. The tile keeps the experience inside the conversation. It removes the friction of switching contexts. |
| CAP-0006-PROP-0024 | standard | A fairness rule set that caps paid advantages inside community goals. The standard is communicated clearly so expectations are set upfront. It keeps social play welcoming and trustworthy. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



- 2026-01-26T23:07:30Z: Community expeditions should feel cooperative, not competitive; lean on festival, campfire, or scout metaphors. Favor asynchronous participation and opt-in cadence to prevent social pressure.
