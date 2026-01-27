ID: PROP-0028
Title: Pheromone Strategy Compass
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0001, PER-0002, PER-0003, RA-001, PITCH-0002
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Pheromone Strategy Compass translates colony signals into a clear guidance system for players who want to steer complex behavior without micromanagement. It visualizes trails, pressure points, and tradeoffs so strategy feels tangible and teachable. This gives both strategists and chat-first explorers a deeper, more legible sim.

## Target Persona(s)

```text
[V-SCRIPT]:
add_proposition_target_persona.sh
remove_proposition_target_persona.sh
```

- PER-0002

- PER-0003

- PER-0001

## Related Segment(s)

```text
[V-SCRIPT]:
add_proposition_related_segment.sh
remove_proposition_related_segment.sh
```

- SEG-0002

- SEG-0003

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
| BOOST-0001-PROP-0028 | A pheromone trail overlay visualizes how ants are routing resources through the colony. Players can see the hidden logic behind their setup in a single glance. The clarity strengthens the feeling of strategic agency. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0003-PER-0002 |
| BOOST-0002-PROP-0028 | A signal heatmap highlights pressure points like food shortages or congestion. The heatmap makes emergent behavior visible instead of mysterious. It turns system complexity into readable insight. | JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0003-PER-0002 |
| BOOST-0003-PROP-0028 | In-chat compass tips translate complex signals into a short recommendation. The tips keep the guidance usable without leaving the conversation. It supports curiosity and momentum for chat-first players. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0002-PER-0003 |
| BOOST-0004-PROP-0028 | A quick pulse summary shows the top two colony signals and one small action to improve them. Casual players get a fast win without studying the full model. It keeps short sessions satisfying and vivid. | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0004-PER-0001 |
| BOOST-0005-PROP-0028 | Strategy purity rings show which gains came from play rather than paid boosts. The signal preserves trust in the underlying simulation. It encourages optional support without eroding legitimacy. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0005-PER-0002 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0028 | Trail overlays expose why the colony behaves the way it does, so outcomes stop feeling opaque. Players can see the logic instead of guessing. This eases frustration with hidden metrics and unclear cause-and-effect. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0004-PER-0002 |
| REL-0002-PROP-0028 | Signal heatmaps prove there is depth under the idle surface, not just decorative visuals. The layered view reduces the impression of a shallow reskin. It keeps strategy-minded players engaged. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0004-PER-0001 |
| REL-0003-PROP-0028 | Compass tips are grounded in actual colony signals instead of generic chat filler. Players can see the data that supports each suggestion. This reduces the feeling that AI help is a gimmick. | JTBD-PAIN-0002-PER-0003, JTBD-PAIN-0004-PER-0002 |
| REL-0004-PROP-0028 | Pulse summaries inject a quick decision into idle downtime so the loop does not feel like pure waiting. Players choose one adjustment and see fast feedback. This reduces frustration with passive progression. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0005-PER-0002 |
| REL-0005-PROP-0028 | Purity rings mark which outcomes are earned without paid boosts. The clarity reduces anxiety about pay-to-win distortions. It keeps trust in the strategic layer intact. | JTBD-PAIN-0001-PER-0001, JTBD-PAIN-0002-PER-0002 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0028 | feature | A pheromone overlay layer that renders trail strength, direction, and density. The overlay can be toggled to keep the view clean. It makes invisible signals visible on demand. |
| CAP-0002-PROP-0028 | function | A signal heatmap engine that highlights resource pressure and congestion hotspots. The engine updates quickly to reflect recent changes. It gives strategists a responsive diagnostic tool. |
| CAP-0003-PROP-0028 | experience | A compass tipper that surfaces one strategic cue and explains the underlying signal. Players can drill down for more detail if desired. It keeps guidance concise but trustworthy. |
| CAP-0004-PROP-0028 | function | A pulse summary module that condenses the top two signals into a quick action list. The module updates at return time to guide the next step. It keeps short sessions focused. |
| CAP-0005-PROP-0028 | standard | A purity marker standard that labels outcomes as earned without paid boosts. The marker keeps strategic credibility intact while allowing optional monetization. It protects trust in the system. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



- 2026-01-26T23:07:34Z: Extend the compass metaphor with trail cartography, pheromone gradients, and flow maps. Use scientific vocabulary sparingly so the interface stays approachable.

- 2026-01-26T23:07:52Z: Lean on cartographic terminology such as isochrones, gradient fields, and vector flows to differentiate the UI. Avoid jargon overload by pairing each term with a plain-language gloss.
