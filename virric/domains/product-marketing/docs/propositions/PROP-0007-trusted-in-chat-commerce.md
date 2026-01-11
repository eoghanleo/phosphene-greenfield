ID: PROP-0007
Title: Trusted In-Chat Commerce
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

Our trusted in-chat commerce flow helps ChatGPT power users who want quick upgrades without leaving chat by reducing purchase friction and trust anxiety while boosting seamless progression and confidence. We achieve this by making pricing clear, explaining value in-context, and keeping purchases reversible and secure.

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
| BOOST-0001-PROP-0007 | Clear value framing for upgrades. | JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0004-PER-0003 |
| BOOST-0002-PROP-0007 | Low-friction checkout steps inside chat. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0004-PER-0003 |
| BOOST-0003-PROP-0007 | Immediate upgrade feedback and confirmations. | JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0003-PER-0003 |
| BOOST-0004-PROP-0007 | Preview or trial moments before purchase. | JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0005-PER-0003 |
| BOOST-0005-PROP-0007 | Confidence badges in checkout flows. | JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0004-PER-0003 |
| BOOST-0006-PROP-0007 | In-chat value comparisons before purchase. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0004-PER-0003 |
| BOOST-0007-PROP-0007 | Trusted payment badges that build confidence. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0004-PER-0003 |
| BOOST-0008-PROP-0007 | Transparent receipts and invoices. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0003-PER-0003, JTBD-GAIN-0004-PER-0003, JTBD-GAIN-0005-PER-0003 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0007 | Trust cues and clear policies to reduce anxiety. | JTBD-PAIN-0002-PER-0003, JTBD-PAIN-0003-PER-0003 |
| REL-0002-PROP-0007 | One-step checkout to avoid friction. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0003-PROP-0007 | Guarantee purchases persist across sessions. | JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0004-PER-0003 |
| REL-0004-PROP-0007 | Fast, reliable checkout UI that feels smooth. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0005-PROP-0007 | Undo window to reduce purchase anxiety. | JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0004-PER-0003 |
| REL-0006-PROP-0007 | Confirmation steps to prevent mistaken purchases. | JTBD-PAIN-0002-PER-0003, JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0004-PER-0003 |
| REL-0007-PROP-0007 | Secure payment flow that feels safe. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0008-PROP-0007 | Charge dispute prevention and receipts. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0002-PER-0003, JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0004-PER-0003, JTBD-PAIN-0005-PER-0003 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0007 | function | In-chat checkout flow |
| CAP-0002-PROP-0007 | feature | Price transparency cards |
| CAP-0003-PROP-0007 | standard | Refund and reversal policy |
| CAP-0004-PROP-0007 | experience | Immediate purchase confirmation UX |
| CAP-0005-PROP-0007 | feature | Undo purchase window |
| CAP-0006-PROP-0007 | feature | Value comparison table |
| CAP-0007-PROP-0007 | standard | Secure payment badge system |
| CAP-0008-PROP-0007 | feature | Receipt archive |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```

- Packaging: show value statements before any checkout prompt.
- Risk: frictionless checkout can still feel pushy without clear opt-outs.
- Edge: refund policy must align with platform rules to avoid disputes.

