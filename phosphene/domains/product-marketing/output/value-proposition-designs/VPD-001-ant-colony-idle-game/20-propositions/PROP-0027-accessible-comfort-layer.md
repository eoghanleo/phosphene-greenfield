ID: PROP-0027
Title: Accessible Comfort Layer
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0001, PER-0002, PER-0003, RA-001, PITCH-0001
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Accessible Comfort Layer ensures the colony experience stays readable, calm, and low-friction across devices and chat. It offers adjustable visuals, motion, and audio so short sessions feel relaxing and premium. This helps casuals and in-chat users stay engaged without fatigue.

## Target Persona(s)

```text
[V-SCRIPT]:
add_proposition_target_persona.sh
remove_proposition_target_persona.sh
```

- PER-0001

- PER-0003

- PER-0002

## Related Segment(s)

```text
[V-SCRIPT]:
add_proposition_related_segment.sh
remove_proposition_related_segment.sh
```

- SEG-0001

- SEG-0003

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
| BOOST-0001-PROP-0027 | Calming visual presets soften colors and reduce contrast spikes during play. The scene feels soothing instead of intense, supporting short relaxing sessions. It also reinforces a premium, intentional presentation. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0004-PER-0002 |
| BOOST-0002-PROP-0027 | Readable text sizing keeps key actions and summaries legible on small screens or inside chat. Players can scan the state quickly without squinting or zooming. It makes the in-chat experience feel seamless and reliable. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0002-PER-0001 |
| BOOST-0003-PROP-0027 | Reduced motion mode limits rapid animations while keeping key feedback visible. The calmer motion supports longer viewing without fatigue. It keeps the experience soothing without losing clarity. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0004-PER-0002 |
| BOOST-0004-PROP-0027 | Ambient audio sliders let players dial in a soft soundscape or mute entirely. The control makes the game feel considerate rather than demanding attention. It supports relaxing, low-pressure play. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0005-PER-0003 |
| BOOST-0005-PROP-0027 | Comfort presets save player preferences so every session feels familiar. The saved setup reduces friction when returning in chat or on web. It reinforces a trustworthy, premium feel. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0004-PER-0002 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0027 | Clear typography and spacing reduce the cognitive load of the interface. Players can focus on a few obvious actions instead of scanning dense menus. This eases the early overwhelm that drives casual churn. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0003-PER-0002 |
| REL-0002-PROP-0027 | Reduced motion options keep the web experience smooth on lower-end devices. Players no longer feel the sim is sluggish or cheap. This protects trust in the platform. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0003-PER-0002 |
| REL-0003-PROP-0027 | Lightweight chat layouts keep the game usable without switching to a full browser view. The in-chat experience stays intact and focused. This removes a major source of friction for chat-first users. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0003-PER-0002 |
| REL-0004-PROP-0027 | Comfort presets keep the experience consistent, so sessions do not feel jarring or repetitive in a negative way. The steadier feel reduces burnout and keeps novelty moments enjoyable. It supports longer-term engagement without pressure. | JTBD-PAIN-0004-PER-0001, JTBD-PAIN-0005-PER-0003 |
| REL-0005-PROP-0027 | Audio control prevents the soundscape from becoming intrusive during short breaks. Players can keep the experience calm without muting the whole game or quitting. This reduces stress during casual sessions. | JTBD-PAIN-0004-PER-0001, JTBD-PAIN-0005-PER-0001 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0027 | feature | A comfort settings panel that centralizes visual, motion, and audio preferences. Players can save presets for quick switching. It makes the experience feel considerate and polished. |
| CAP-0002-PROP-0027 | standard | A reduced motion standard that limits animation intensity while keeping key feedback cues. The standard ensures clarity even when motion is minimized. It protects comfort without sacrificing usability. |
| CAP-0003-PROP-0027 | function | Dynamic typography scaling that adjusts summaries and buttons based on device and context. The scaling keeps critical actions readable in chat or on mobile. It reduces friction during quick check-ins. |
| CAP-0004-PROP-0027 | experience | A chat-first layout mode that keeps key controls visible without leaving the conversation. The layout preserves context while still showing the colony state. It reduces the need to jump to a full browser view. |
| CAP-0005-PROP-0027 | function | An ambient audio mixer that lets players adjust sound layers independently. The mixer keeps the mood calming rather than intrusive. It supports relaxed, low-pressure sessions. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



- 2026-01-26T23:07:33Z: Comfort framing should include reduced-motion, low-glare palettes, and focus-friendly spacing. Keep the tone inclusive and avoid medicalized claims while still signaling accessibility intent.
