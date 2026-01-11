ID: PROP-0001
Title: Five-Minute Progress Loop
Status: Draft
Updated: 2026-01-11
Dependencies: PER-0001, RA-001, PITCH-0001
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/virric/product-marketing/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Our quick-check-in loop helps casual idle gamers get satisfying progress in minutes by reducing overwhelm and pacing stalls while boosting stress-free momentum and clear next steps.

## Target Persona(s)

```text
[V-SCRIPT]:
add_proposition_target_persona.sh
remove_proposition_target_persona.sh
```


- PER-0001

## Related Segment(s)

```text
[V-SCRIPT]:
add_proposition_related_segment.sh
remove_proposition_related_segment.sh
```


- SEG-0001

## Gain Boosters

```text
[V-SCRIPT]:
add_proposition_gain_booster.sh
update_proposition_gain_booster.sh
```

MappedGainIDs is an array encoded as a comma-separated list of JTBD IDs.

| BoosterID | Booster | MappedGainIDs[] |
|---|---|---|
| BOOST-0001-PROP-0001 | Instant offline summary with clear next-step choices | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0005-PER-0001 |
| BOOST-0002-PROP-0001 | Visible growth moments in under five minutes | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0003-PER-0001 |
| BOOST-0003-PROP-0001 | Relaxed pacing with low-stakes feedback | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0005-PER-0001 |
| BOOST-0004-PROP-0001 | Daily micro-milestones without streak pressure | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0005-PER-0001 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0001 | Simplified first-session path with one obvious action | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0004-PER-0001 |
| REL-0002-PROP-0001 | Catch-up boosts when progression slows | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0004-PER-0001 |
| REL-0003-PROP-0001 | Optional reminders instead of forced ad breaks | JTBD-PAIN-0001-PER-0001, JTBD-PAIN-0005-PER-0001 |
| REL-0004-PROP-0001 | Compact UI that hides advanced systems until ready | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0003-PER-0001 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0001 | experience | Five-minute check-in flow with offline summary |
| CAP-0002-PROP-0001 | function | Auto-collect rewards with a quick upgrade picker |
| CAP-0003-PROP-0001 | feature | Goal cards that highlight the next best action |
| CAP-0004-PROP-0001 | standard | Pacing guardrails to prevent stalls in early/mid game |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```

<free-form notes>

