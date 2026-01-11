ID: PROP-0005
Title: Seamless In-Chat Launch
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

Our seamless in-chat launch experience helps ChatGPT power users who want instant, low-friction play by reducing context switching and slow load times while boosting quick-start satisfaction and persistent progress. We achieve this by optimizing launch flow, keeping controls lightweight, and syncing state across sessions.

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
| BOOST-0001-PROP-0005 | Instant launch inside the chat thread. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0005-PER-0003 |
| BOOST-0002-PROP-0005 | Fast onboarding that starts play in seconds. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0005-PER-0003 |
| BOOST-0003-PROP-0005 | Persistent progress across sessions. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0003-PER-0003 |
| BOOST-0004-PROP-0005 | Lightweight controls that keep it smooth. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0002-PER-0003 |
| BOOST-0005-PROP-0005 | Smart resume cues that bring you back instantly. | JTBD-GAIN-0003-PER-0003, JTBD-GAIN-0005-PER-0003 |
| BOOST-0006-PROP-0005 | Resume snapshot of last actions. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0003-PER-0003, JTBD-GAIN-0005-PER-0003 |
| BOOST-0007-PROP-0005 | Background asset prefetch for instant play. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0003-PER-0003, JTBD-GAIN-0005-PER-0003 |
| BOOST-0008-PROP-0005 | Zero-click resume from chat history. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0003-PER-0003, JTBD-GAIN-0004-PER-0003, JTBD-GAIN-0005-PER-0003 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0005 | Keep everything in-chat to remove context switching. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0002-PROP-0005 | Optimize load times to avoid clunky starts. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0003-PROP-0005 | Reliable state sync to avoid lost progress. | JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0004-PER-0003 |
| REL-0004-PROP-0005 | Show immediate value to avoid the gimmick feel. | JTBD-PAIN-0002-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0005-PROP-0005 | Asset caching to prevent slow loads. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0006-PROP-0005 | Minimize context-switch friction for repeat visits. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0002-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0007-PROP-0005 | Graceful degradation for slower devices. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0008-PROP-0005 | Cached states to avoid reload friction. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0002-PER-0003, JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0004-PER-0003, JTBD-PAIN-0005-PER-0003 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0005 | function | One-tap in-chat launch flow |
| CAP-0002-PROP-0005 | feature | Minimal UI control layer |
| CAP-0003-PROP-0005 | function | Session persistence and resume |
| CAP-0004-PROP-0005 | feature | Cross-device state sync |
| CAP-0005-PROP-0005 | function | Asset preloading cache |
| CAP-0006-PROP-0005 | feature | Resume snapshot card |
| CAP-0007-PROP-0005 | standard | Performance fallback mode |
| CAP-0008-PROP-0005 | function | Chat history resume hook |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```

- Packaging: launch flow should support one-tap resume and new session equally.
- Risk: if load times vary across devices, perception of quality drops fast.
- Edge: session persistence must respect platform privacy expectations.

