ID: PROP-0021
Title: Seasonal colony arcs
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0001, PER-0003
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Seasonal colony arcs give relaxed players and chat explorers a gentle narrative rhythm that keeps the idle loop fresh. Each arc adds a small twist, a clear recap, and a shareable moment without demanding long sessions. The result is lightweight novelty with low pressure.

## Target Persona(s)

```text
[V-SCRIPT]:
add_proposition_target_persona.sh
remove_proposition_target_persona.sh
```

- PER-0001

- PER-0003

## Related Segment(s)

```text
[V-SCRIPT]:
add_proposition_related_segment.sh
remove_proposition_related_segment.sh
```

- SEG-0001

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
| BOOST-0001-PROP-0021 | Seasonal chapter cards deliver a quick twist that feels fresh in chat. Each card doubles as a shareable moment that keeps explorers excited. | JTBD-GAIN-0004-PER-0001, JTBD-GAIN-0005-PER-0003 |
| BOOST-0002-PROP-0021 | Chapter goals are scoped to under five minutes so relaxed players get a fast win. The short arc keeps progress satisfying without long sessions. | JTBD-GAIN-0003-PER-0001 |
| BOOST-0003-PROP-0021 | Seasonal return mail summarizes what changed while away and highlights one small reward. It makes offline progress feel tangible and worth checking. | JTBD-GAIN-0003-PER-0003, JTBD-GAIN-0005-PER-0001 |
| BOOST-0004-PROP-0021 | AI narration frames the season arc in simple language and explains why it matters. The guidance keeps in-chat explorers oriented and curious. | JTBD-GAIN-0002-PER-0003 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0021 | Seasonal arcs rotate the loop so daily check-ins do not feel identical. The steady refresh fights novelty fatigue for both casual players and chat explorers. | JTBD-PAIN-0004-PER-0001, JTBD-PAIN-0005-PER-0003 |
| REL-0002-PROP-0021 | Season recaps summarize what moved forward while the player was away. The reminder reduces re-entry friction and keeps the loop feeling friendly. | JTBD-PAIN-0005-PER-0001 |
| REL-0003-PROP-0021 | Season updates post directly in the chat thread so explorers do not have to leave the conversation. This removes the context-switching pain that often kills momentum. | JTBD-PAIN-0001-PER-0003 |
| REL-0004-PROP-0021 | Seasonal rewards are framed as optional celebrations rather than fear-of-missing-out pressure. This keeps the experience calm and avoids coercive monetization cues. | JTBD-PAIN-0001-PER-0001 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0021 | feature | Season arc timeline that previews upcoming themes and recent milestones. It helps players anticipate what is next without feeling rushed. |
| CAP-0002-PROP-0021 | function | Seasonal recap digest that highlights progress, rewards, and one suggested next action. It keeps return sessions short while still feeling complete. |
| CAP-0003-PROP-0021 | experience | Shareable season postcard that summarizes the latest colony moment in chat. It encourages light social sharing without demanding long sessions. |
| CAP-0004-PROP-0021 | standard | Opt-in seasonal cadence with no penalties for skipping weeks. It reinforces a relaxed, guilt-free play pattern. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



- 2026-01-26T13:09:23Z: Season language should focus on discovery and care rather than competition. Keep rewards small and charming so the arc feels like a relaxing ritual.
