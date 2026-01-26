ID: PROP-0008
Title: Web + Chat Continuity
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0002, PER-0003, RA-001, PITCH-0003
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Web + chat continuity connects browser depth with in-chat convenience for strategists and explorers. It keeps progress synchronized so players can shift contexts without losing momentum. The proposition expands reach while preserving trust.

## Target Persona(s)

```text
[V-SCRIPT]:
add_proposition_target_persona.sh
remove_proposition_target_persona.sh
```

- PER-0002

- PER-0003

## Related Segment(s)

```text
[V-SCRIPT]:
add_proposition_related_segment.sh
remove_proposition_related_segment.sh
```

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
| BOOST-0001-PROP-0008 | Cross-platform state sync keeps the colony consistent between web sessions and chat. Players trust that progress is intact. This boosts continuity and confidence. | JTBD-GAIN-0003-PER-0003, JTBD-GAIN-0004-PER-0002 |
| BOOST-0002-PROP-0008 | Web sessions unlock deeper strategy, while chat sessions offer quick check-ins. Players get the best of both worlds without fragmentation. This boosts flexibility and agency. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0003-PER-0001 |
| BOOST-0003-PROP-0008 | A continuity summary appears when switching contexts, explaining what changed since the last visit. It keeps players oriented in both environments. This boosts clarity and trust. | JTBD-GAIN-0003-PER-0002, JTBD-GAIN-0003-PER-0003 |
| BOOST-0004-PROP-0008 | Shared achievement milestones carry across web and chat, so progress feels unified. Players can celebrate in either context. This boosts motivation and connection. | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0005-PER-0003 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0008 | State sync prevents the fear of losing progress when switching contexts. Players see that the colony persists. This relieves persistence anxiety. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0003-PER-0003 |
| REL-0002-PROP-0008 | Switching summaries avoid confusion about what changed during time away. They keep both personas oriented. This relieves re-entry friction. | JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0005-PER-0001 |
| REL-0003-PROP-0008 | Web depth and chat convenience reduce the fear that one channel is too shallow. Players can pick the right context without losing strategy. This relieves platform skepticism. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0003-PER-0002 |
| REL-0004-PROP-0008 | Unified milestones prevent the sense of starting over in a new context. Progress remains coherent across channels. This relieves frustration with fragmented play. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0003-PER-0002 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0008 | function | A cross-platform sync engine that keeps colony state aligned. It works seamlessly across web and chat sessions. This maintains continuity. |
| CAP-0002-PROP-0008 | feature | A context switch summary that explains recent changes and next steps. It keeps players oriented after moving between web and chat. This supports clarity. |
| CAP-0003-PROP-0008 | experience | A unified achievement stream that appears in both web and chat. It keeps progress cohesive across contexts. This reinforces motivation. |
| CAP-0004-PROP-0008 | standard | A continuity standard that guarantees state consistency across channels. It sets expectations for reliable sync. This builds trust. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



