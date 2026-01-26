ID: PROP-0014
Title: Fair Economy Ledger
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0001, PER-0002, RA-001, PITCH-0002
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Fair economy ledger makes the monetization model transparent for casual and strategic players. It shows how progress works with and without spending, keeping trust high. The proposition reinforces legitimacy and fairness.

## Target Persona(s)

```text
[V-SCRIPT]:
add_proposition_target_persona.sh
remove_proposition_target_persona.sh
```

- PER-0001

- PER-0002

## Related Segment(s)

```text
[V-SCRIPT]:
add_proposition_related_segment.sh
remove_proposition_related_segment.sh
```

- SEG-0001

- SEG-0002

## Gain Boosters

```text
[V-SCRIPT]:
add_proposition_gain_booster.sh
update_proposition_gain_booster.sh
```

MappedGainIDs is an array encoded as a comma-separated list of JTBD IDs.

| BoosterID | Booster | MappedGainIDs[] |
|---|---|---|
| BOOST-0001-PROP-0014 | A ledger view shows how resources accrue over time without spending. It reassures casual players that progress is viable. This boosts trust and calm pacing. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0003-PER-0001 |
| BOOST-0002-PROP-0014 | Strategy reports show how optional boosts affect outcomes without breaking balance. Strategists can evaluate tradeoffs transparently. This boosts legitimacy and agency. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0003-PER-0002 |
| BOOST-0003-PROP-0014 | Ledger badges show which upgrades are purely cosmetic. It clarifies that spending can stay optional. This boosts trust for both personas. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0005-PER-0002 |
| BOOST-0004-PROP-0014 | Historical pacing charts compare expected progress with and without purchases. They show that the game remains fair. This boosts confidence in the economy. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0003-PER-0002 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0014 | Ledger transparency reduces fear of pay-to-win pressure. Players can see that progress is not locked behind spending. This relieves monetization anxiety. | JTBD-PAIN-0001-PER-0001, JTBD-PAIN-0002-PER-0002 |
| REL-0002-PROP-0014 | The ledger clarifies why outcomes happened even with optional boosts. It keeps the system legitimate and explainable. This relieves skepticism about manipulation. | JTBD-PAIN-0002-PER-0002, JTBD-PAIN-0005-PER-0002 |
| REL-0003-PROP-0014 | Clear economy records reduce confusion about which upgrades matter. They make choices feel less random. This relieves decision anxiety. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0007-PER-0001 |
| REL-0004-PROP-0014 | Ledger pacing guards against sudden stalls that feel forced. It shows expected progress curves so players don't feel trapped. This relieves pacing frustration. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0004-PER-0001 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0014 | feature | A fair economy ledger panel that tracks earned vs boosted gains. It keeps transparency visible to players. This supports trust. |
| CAP-0002-PROP-0014 | function | A pacing chart that compares expected progress with and without optional boosts. It makes fairness measurable. This supports confidence. |
| CAP-0003-PROP-0014 | experience | An economy walkthrough that explains how optional boosts interact with core loops. It keeps the system legitimate and understandable. This supports strategic trust. |
| CAP-0004-PROP-0014 | standard | A fairness disclosure standard that labels optional boosts and their limits. It sets clear expectations for monetization. This supports calm play. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



