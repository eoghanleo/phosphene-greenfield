ID: PROP-0007
Title: Seamless In-Chat Play
Status: Draft
Updated: 2026-01-11
Dependencies: PER-0003, RA-001, PITCH-0002
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/virric/product-marketing/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Our seamless in-chat play proposition helps ChatGPT power-users stay in flow by eliminating tab switching, offering instant launch and resume, and keeping the UI native to the conversation.

## Target Persona(s)

```text
[V-SCRIPT]:
add_proposition_target_persona.sh
remove_proposition_target_persona.sh
```


- PER-0003

## Related Segment(s)

```text
[V-SCRIPT]:
add_proposition_related_segment.sh
remove_proposition_related_segment.sh
```


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
| BOOST-0001-PROP-0007 | Embedded UI that keeps chat context | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0003-PER-0003 |
| BOOST-0002-PROP-0007 | One-command launch flow | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0003-PER-0003 |
| BOOST-0003-PROP-0007 | Fast resume with prior state | JTBD-GAIN-0003-PER-0003, JTBD-GAIN-0004-PER-0003 |
| BOOST-0004-PROP-0007 | In-chat discovery prompts that surface play opportunities | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0005-PER-0003 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0007 | Eliminates tab switching to keep flow | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0002-PROP-0007 | Quick load times that avoid clunky UI | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0003-PROP-0007 | Session persistence cues that reinforce trust | JTBD-PAIN-0002-PER-0003, JTBD-PAIN-0003-PER-0003 |
| REL-0004-PROP-0007 | Minimal setup steps before play | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0002-PER-0003 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0007 | experience | Embedded in-chat play surface |
| CAP-0002-PROP-0007 | function | Instant launch and resume flow |
| CAP-0003-PROP-0007 | feature | Context-preserving UI layout for conversation |
| CAP-0004-PROP-0007 | standard | Performance target for embedded UI responsiveness |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```

<free-form notes>

