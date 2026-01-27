ID: PROP-0023
Title: Persistence Trust Vault
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

Persistence Trust Vault reassures players that progress, purchases, and data are safe across web and chat sessions. It makes continuity visible and gives explicit control over payments and recovery. This builds trust so upgrades feel optional and low risk.

## Target Persona(s)

```text
[V-SCRIPT]:
add_proposition_target_persona.sh
remove_proposition_target_persona.sh
```

- PER-0001

- PER-0002

- PER-0003

## Related Segment(s)

```text
[V-SCRIPT]:
add_proposition_related_segment.sh
remove_proposition_related_segment.sh
```

- SEG-0001

- SEG-0002

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
| BOOST-0001-PROP-0023 | A visible save timeline shows the last synced moment and what changed since then. Players see proof of continuity instead of hoping it worked. The clarity makes returning sessions feel safe and reliable. | JTBD-GAIN-0003-PER-0003, JTBD-GAIN-0005-PER-0001 |
| BOOST-0002-PROP-0023 | A purchase receipt panel explains what each upgrade unlocked, how long it lasts, and how to reverse it if needed. This transparency makes spending feel deliberate rather than risky. It increases confidence in in-chat purchases. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0004-PER-0003 |
| BOOST-0003-PROP-0023 | Integrity seals highlight which achievements are earned without pay shortcuts. Strategists can trust that progress reflects real play. The signal keeps the economy legitimate while still allowing optional support. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0005-PER-0002 |
| BOOST-0004-PROP-0023 | A cross-device handshake confirms that chat and web sessions share the same colony state. Players can move between contexts without worrying about divergence. The continuity reinforces a premium, trustworthy experience. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0004-PER-0002 |
| BOOST-0005-PROP-0023 | Optional support nudges clearly separate convenience perks from core progress. Players can decide when to spend without feeling pressured. It reinforces the sense that the economy is fair and player-controlled. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0005-PER-0002 |
| BOOST-0006-PROP-0023 | A recovery guarantee explains how progress can be restored if a session fails or a device changes. Knowing there is a safety net lowers anxiety about trying new features. It makes long-term investment feel safer. | JTBD-GAIN-0003-PER-0003, JTBD-GAIN-0004-PER-0003 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0023 | A persistent-state indicator confirms when progress is saved and synced. Players do not worry about losing days of work after stepping away. It reduces anxiety about returning after a break. | JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0005-PER-0001 |
| REL-0002-PROP-0023 | Purchase checkpoints show what will happen before any confirmation and summarize outcomes afterward. The flow feels predictable instead of clunky or unclear. This lowers hesitation about upgrading inside chat. | JTBD-PAIN-0001-PER-0001, JTBD-PAIN-0004-PER-0003 |
| REL-0003-PROP-0023 | Fair-play tags flag any purchases that would affect power balance and keep them separated from strategy systems. Strategists can trust that outcomes still reflect decisions, not payment. This relieves concern that monetization invalidates mastery. | JTBD-PAIN-0001-PER-0001, JTBD-PAIN-0002-PER-0002 |
| REL-0004-PROP-0023 | An audit log explains which decisions changed colony metrics, so players do not feel lost about why progress shifted. The record turns hidden changes into transparent feedback. This reduces the sense of guesswork and hidden systems. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0004-PER-0002 |
| REL-0005-PROP-0023 | State recovery options make it clear how to restore progress after a crash or disconnect. Players no longer fear losing a colony because a session failed. This reduces the anxiety that keeps them from investing time. | JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0005-PER-0001 |
| REL-0006-PROP-0023 | Clear opt-out and privacy reminders explain what data is stored and why. When players know what is collected, the in-chat experience feels safer. This lowers hesitation around persistent play. | JTBD-PAIN-0002-PER-0003, JTBD-PAIN-0003-PER-0003 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0023 | function | A save-state dashboard that lists last sync time, device, and a short change log. The dashboard gives players a visible anchor for continuity. It makes persistence feel deliberate rather than invisible. |
| CAP-0002-PROP-0023 | feature | A purchase receipt vault that summarizes upgrades, durations, and reversal options. The vault is searchable so players can quickly confirm what they bought. It reinforces confidence in optional spending. |
| CAP-0003-PROP-0023 | standard | An integrity seal system that labels competitive or strategic outcomes as earned through play. The standard clarifies what purchases do and do not affect. It protects the sense of legitimacy for strategy-minded players. |
| CAP-0004-PROP-0023 | experience | A recovery flow that walks players through restoring their colony after a device change or failed session. The flow confirms what will be restored before applying it. It makes recovery feel safe and predictable. |
| CAP-0005-PROP-0023 | standard | A privacy control center that lists stored data, retention windows, and opt-out toggles. The center explains why each item is kept in plain language. It makes the in-chat experience feel trustworthy and transparent. |
| CAP-0006-PROP-0023 | feature | A payment sandbox that previews the outcome of an upgrade without applying it yet. Players can see the expected changes before committing. This reduces buyer anxiety and keeps spending optional. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



- 2026-01-26T23:07:29Z: Position the trust vault around recovery pathways, audit trails, and explicit consent cues. Avoid implying regulated compliance; keep claims scoped to transparency, reversibility, and player control.
