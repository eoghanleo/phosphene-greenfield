ID: PROP-0003
Title: Delightful Ant Discoveries
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0001, RA-001, PITCH-0001
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Delightful ant discoveries give relaxed idle gamers a steady stream of charming surprises that make the colony feel alive. It turns progress into visible, playful moments—new ant roles, behaviors, and habitats—without increasing complexity. The proposition keeps the loop fresh while preserving the calm idle rhythm.

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
| BOOST-0001-PROP-0003 | New ant roles unlock with small celebrations that show how the colony changes. Each discovery feels like a mini-reward that punctuates short sessions. This boosts delight while keeping progress tangible. | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0004-PER-0001 |
| BOOST-0002-PROP-0003 | Visible colony transformations show new tunnels, chambers, and behaviors as you upgrade. The visual change makes progress feel concrete and worth returning to. This reinforces quick accomplishment alongside thematic charm. | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0004-PER-0001 |
| BOOST-0003-PROP-0003 | A discovery journal tracks unlocked ant types, habitats, and quirks with short, fun descriptions. It gives players a relaxing reason to browse and appreciate progress. This adds calming satisfaction and visual delight. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0004-PER-0001 |
| BOOST-0004-PROP-0003 | Surprise loot drops tie to new discoveries rather than grind, rewarding curiosity in short bursts. The surprises make each check-in feel fresh without requiring long sessions. This boosts quick wins and makes offline returns exciting. | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0005-PER-0001 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0003 | Regular discovery beats give players something new to look forward to in each session. These surprises break the monotony without adding grind. The loop feels fresh instead of repetitive. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0004-PER-0001 |
| REL-0002-PROP-0003 | Unlocks are paced so only one new concept appears at a time, keeping the system approachable. Short explanations are optional, so curious players can learn without forcing everyone else. This reduces early overwhelm while still adding variety. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0004-PER-0001 |
| REL-0003-PROP-0003 | A return recap highlights any new discoveries made while away and suggests one simple action to continue. This makes re-entry feel welcoming instead of confusing. It avoids the sense of being behind after time off. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0005-PER-0001 |
| REL-0004-PROP-0003 | Discoveries are earned through normal play rather than paywalls or time gates. The player never feels forced to spend to access the fun parts. This relieves monetization pressure and reduces guilt. | JTBD-PAIN-0001-PER-0001, JTBD-PAIN-0005-PER-0001 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0003 | feature | A discovery journal catalogs unlocked ants, habitats, and quirky behaviors with short descriptions. It provides a lightweight collection layer that players can browse at any time. This keeps the theme delightful without adding pressure. |
| CAP-0002-PROP-0003 | function | A visual evolution system swaps in new colony art as upgrades land. The colony looks different as you progress, making growth obvious at a glance. This turns progress into visible, charming change. |
| CAP-0003-PROP-0003 | feature | Ant role unlock cards introduce new behaviors with a single, friendly description and a small visual cue. The cards keep discovery lightweight and avoid overwhelming the player. This supports novelty without complexity. |
| CAP-0004-PROP-0003 | experience | A surprise discovery moment appears at the end of a session or after idle time. The reveal is short and playful, adding a burst of delight without requiring extra effort. This keeps check-ins feeling fresh. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



