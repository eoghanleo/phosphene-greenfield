ID: PROP-0019
Title: Trusted in-chat upgrade kiosk
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0003, PER-0001
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Trusted in-chat upgrade kiosk lets explorers and relaxed idle gamers support the colony without leaving the conversation. It explains value, confirms purchases transparently, and keeps upgrades tied to the current thread. The result is a safe, quick decision flow that still feels playful.

## Target Persona(s)

```text
[V-SCRIPT]:
add_proposition_target_persona.sh
remove_proposition_target_persona.sh
```

- PER-0003

- PER-0001

## Related Segment(s)

```text
[V-SCRIPT]:
add_proposition_related_segment.sh
remove_proposition_related_segment.sh
```

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
| BOOST-0001-PROP-0019 | The kiosk surfaces two to three upgrades with concise value summaries and a visible trust badge for billing. That clarity makes in-chat purchases feel safe and keeps the conversation intact. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0004-PER-0003 |
| BOOST-0002-PROP-0019 | A transparent impact map shows how each optional boost changes progression speed or cosmetic flair. Relaxed players feel good about small purchases because the benefits are obvious and fair. | JTBD-GAIN-0001-PER-0001 |
| BOOST-0003-PROP-0019 | AI-guided explanations compare the upgrade to the player’s current goal, translating it into plain language. The guidance reduces doubt and increases confidence that the choice is smart. | JTBD-GAIN-0002-PER-0003 |
| BOOST-0004-PROP-0019 | The kiosk finishes purchases in a few taps and returns the player to the game state with a clear confirmation. That quick flow preserves the satisfaction of short sessions and avoids cognitive drag. | JTBD-GAIN-0003-PER-0001 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0019 | The purchase flow includes a clear summary of cost, value, and confirmation messaging in chat. The player no longer worries about what happens after payment. | JTBD-PAIN-0004-PER-0003 |
| REL-0002-PROP-0019 | Receipts and upgrade effects are logged in the chat thread with a short snapshot of the new state. This reduces anxiety about persistence because the player can see a durable record. | JTBD-PAIN-0003-PER-0003 |
| REL-0003-PROP-0019 | The kiosk keeps upgrades within chat so players don’t have to jump to a browser store. It removes the context-switching friction that often kills the moment. | JTBD-PAIN-0001-PER-0003 |
| REL-0004-PROP-0019 | Optional offers are framed as support rather than pressure and appear only after a positive milestone. This avoids the coercive popups that make relaxed players distrustful. | JTBD-PAIN-0001-PER-0001 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0019 | feature | In-chat upgrade kiosk panel with secure checkout and clear, step-by-step confirmation. It keeps purchase actions inside the conversation without losing the game state. |
| CAP-0002-PROP-0019 | function | Upgrade comparison card that summarizes value, duration, and expected impact. It makes the tradeoff legible so the player can decide quickly. |
| CAP-0003-PROP-0019 | experience | Trust badge and confirmation narrative that explains what changed in the colony after purchase. The message reassures the player that the upgrade applied correctly. |
| CAP-0004-PROP-0019 | standard | Billing transparency standard that discloses pricing, renewal status, and refund guidance in plain language. It keeps the monetization relationship honest and low-friction. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



- 2026-01-26T13:05:29Z: Keep the kiosk language empathetic and low-pressure so it feels like an optional tip jar, not a hard sell. The experience should reinforce the game’s trust-first tone while still making value explicit.
