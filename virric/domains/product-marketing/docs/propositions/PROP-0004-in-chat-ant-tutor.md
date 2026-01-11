ID: PROP-0004
Title: In-Chat Ant Tutor
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

Our in-chat ant tutor helps ChatGPT power users who want quick entertainment and learning without leaving chat by reducing gimmick risk and confusion while boosting AI-guided explanations and trust. We achieve this by pairing the sim with conversational coaching, causal breakdowns, and suggested actions.

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
| BOOST-0001-PROP-0004 | AI explanations that make outcomes clear. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0002-PER-0003 |
| BOOST-0002-PROP-0004 | Suggested next actions in plain language. | JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0005-PER-0003 |
| BOOST-0003-PROP-0004 | Interactive Q&A about colony behaviors. | JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0003-PER-0003 |
| BOOST-0004-PROP-0004 | Learning moments that feel novel in-chat. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0002-PER-0003 |
| BOOST-0005-PROP-0004 | Explainable insights that build confidence. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0002-PER-0003 |
| BOOST-0006-PROP-0004 | Ask-why explanations that reinforce learning. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0003-PER-0003 |
| BOOST-0007-PROP-0004 | Confidence scoring for AI tips. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0004-PER-0003 |
| BOOST-0008-PROP-0004 | AI-generated 'what changed' summaries. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0003-PER-0003, JTBD-GAIN-0004-PER-0003, JTBD-GAIN-0005-PER-0003 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0004 | Demonstrate real AI utility to avoid gimmicks. | JTBD-PAIN-0002-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0002-PROP-0004 | Keep interactions inside chat to avoid context switches. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0003-PROP-0004 | Explicit trust cues and data handling clarity. | JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0004-PER-0003 |
| REL-0004-PROP-0004 | Reliable session persistence to avoid lost progress. | JTBD-PAIN-0004-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0005-PROP-0004 | Latency controls to keep chat responses snappy. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0006-PROP-0004 | Fallback manual hints when AI is uncertain. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0002-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0007-PROP-0004 | Privacy control panel to address data concerns. | JTBD-PAIN-0002-PER-0003, JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0004-PER-0003 |
| REL-0008-PROP-0004 | Session guardrails for privacy and trust. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0002-PER-0003, JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0004-PER-0003, JTBD-PAIN-0005-PER-0003 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0004 | function | AI explanation and coaching layer |
| CAP-0002-PROP-0004 | feature | Conversational control shortcuts |
| CAP-0003-PROP-0004 | experience | In-chat tutoring moments and prompts |
| CAP-0004-PROP-0004 | standard | Trust and data-handling disclosures |
| CAP-0005-PROP-0004 | feature | Insight highlight overlays |
| CAP-0006-PROP-0004 | feature | Confidence meter for AI tips |
| CAP-0007-PROP-0004 | feature | Privacy controls panel |
| CAP-0008-PROP-0004 | feature | Session summary thread |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```

- Packaging: tutor prompts should appear after key moments, not continuously.
- Risk: AI explanations must be accurate to avoid trust erosion.
- Edge: latency spikes could undermine the chat-first experience.

