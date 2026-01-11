ID: PROP-0010
Title: In-Chat Discovery Spotlight
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

Our in-chat discovery spotlight helps ChatGPT power users who want quick, novel entertainment by reducing discovery friction and stale content while boosting instant play, AI highlights, and shareable moments. We achieve this with curated entry points, personalized prompts, and lightweight social proof inside chat.

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
| BOOST-0001-PROP-0010 | Curated prompts that start play instantly. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0005-PER-0003 |
| BOOST-0002-PROP-0010 | Personalized highlights that feel novel. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0002-PER-0003 |
| BOOST-0003-PROP-0010 | Shareable moments that keep the experience fresh. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0002-PER-0003 |
| BOOST-0004-PROP-0010 | Instant play cards surfaced in chat. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0005-PER-0003 |
| BOOST-0005-PROP-0010 | AI recap clips that explain progress. | JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0003-PER-0003 |
| BOOST-0006-PROP-0010 | AI-curated daily picks that refresh content. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0005-PER-0003 |
| BOOST-0007-PROP-0010 | Social proof snippets that build confidence. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0004-PER-0003 |
| BOOST-0008-PROP-0010 | Personalized discovery streaks. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0003-PER-0003, JTBD-GAIN-0004-PER-0003, JTBD-GAIN-0005-PER-0003 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0010 | In-chat discovery shortcuts to remove friction. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0002-PROP-0010 | Fresh content cues that avoid the gimmick feel. | JTBD-PAIN-0002-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0003-PROP-0010 | Keep discovery and play inside chat. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0004-PROP-0010 | Trust signals and persistence guarantees for new content. | JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0004-PER-0003 |
| REL-0005-PROP-0010 | Fast-loading previews to avoid clunky starts. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0006-PROP-0010 | Spam controls to keep discovery trustworthy. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0002-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0007-PROP-0010 | Privacy guardrails for sharing and discovery. | JTBD-PAIN-0002-PER-0003, JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0004-PER-0003 |
| REL-0008-PROP-0010 | Opt-out and mute controls for discovery noise. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0002-PER-0003, JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0004-PER-0003, JTBD-PAIN-0005-PER-0003 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0010 | feature | In-chat discovery feed |
| CAP-0002-PROP-0010 | function | Personalized prompt generator |
| CAP-0003-PROP-0010 | feature | Shareable highlight cards |
| CAP-0004-PROP-0010 | standard | Trust badges for featured content |
| CAP-0005-PROP-0010 | experience | Instant preview cards |
| CAP-0006-PROP-0010 | feature | Daily pick rotation |
| CAP-0007-PROP-0010 | standard | Sharing privacy guardrails |
| CAP-0008-PROP-0010 | feature | Discovery mute controls |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```

- Packaging: discovery feed should prioritize quick-start experiences over deep menus.
- Risk: spotlighting too much content can dilute focus; keep a tight rotation.
- Edge: sharing prompts must respect platform privacy expectations.

