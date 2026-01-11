ID: PER-0001
Title: Idle Ingrid
Status: Draft
Updated: 2026-01-11
Dependencies: CPE-0001,RA-001,PITCH-0001
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/virric/product-marketing/SKILL.md)

## Snapshot summary

```text
[V-SCRIPT]:
update_persona_summary.sh
```

- Casual idle gamer who wants stress-free progress in short sessions.
- Sensitive to monetization pressure and pacing stalls.
- Values fair, optional spend and cute/quirky ant theme.
- Expects offline progress to feel meaningful without heavy cognitive load.

## Jobs

```text
[V-SCRIPT]:
add_persona_jtbd_item.sh
update_persona_jtbd_item.sh
```

Each item has:
- ID: `JTBD-<TYPE>-####-<PersonaID>` where `<TYPE>` is `JOB|PAIN|GAIN`
- Importance: 1–5 (5 = most important)

| JTBD-ID | Job | Importance |
|---|---|---:|
| JTBD-JOB-0001-PER-0001 | Fill short downtime with satisfying progress without mental effort. | 5 |
| JTBD-JOB-0002-PER-0001 | Check in quickly, make a few upgrades, and leave feeling it mattered. | 5 |
| JTBD-JOB-0003-PER-0001 | See clear short-term goals so I know what to do next. | 4 |
| JTBD-JOB-0004-PER-0001 | Enjoy a cute, low-stress theme that feels rewarding to watch. | 4 |
| JTBD-JOB-0005-PER-0001 | Feel steady progress even when I’m offline. | 5 |

## Pains

```text
[V-SCRIPT]:
add_persona_jtbd_item.sh
update_persona_jtbd_item.sh
```

| JTBD-ID | Pain | Importance |
|---|---|---:|
| JTBD-PAIN-0001-PER-0001 | Aggressive ads or paywalls make the game feel greedy. | 5 |
| JTBD-PAIN-0002-PER-0001 | Early onboarding feels overwhelming or confusing. | 4 |
| JTBD-PAIN-0003-PER-0001 | Progress stalls later and feels pointless. | 4 |
| JTBD-PAIN-0004-PER-0001 | Sessions become repetitive with no fresh surprises. | 3 |
| JTBD-PAIN-0005-PER-0001 | Offline gains feel too small or unclear to trust. | 3 |

## Gains

```text
[V-SCRIPT]:
add_persona_jtbd_item.sh
update_persona_jtbd_item.sh
```

| JTBD-ID | Gain | Importance |
|---|---|---:|
| JTBD-GAIN-0001-PER-0001 | Fair optional purchases that never block core progress. | 5 |
| JTBD-GAIN-0002-PER-0001 | Relaxing, low-pressure play that feels cozy. | 4 |
| JTBD-GAIN-0003-PER-0001 | Offline progress that feels meaningful when I return. | 5 |
| JTBD-GAIN-0004-PER-0001 | Clear next-step guidance that keeps sessions short. | 4 |
| JTBD-GAIN-0005-PER-0001 | Delightful visuals and theme that feel charming. | 4 |

## Evidence and links

```text
[V-SCRIPT]:
add_persona_evidence_link.sh
remove_persona_evidence_link.sh
add_persona_related_link.sh
remove_persona_related_link.sh
```

Store supporting IDs and pointers here (no prose argumentation—just traceability).

### EvidenceIDs
- E-0001
- E-0003
- E-0012




```text
[V-SCRIPT]:
add_persona_evidence_link.sh
remove_persona_evidence_link.sh
```

### CandidatePersonaIDs
- CPE-0001


```text
[V-SCRIPT]:
add_persona_evidence_link.sh
remove_persona_evidence_link.sh
```

### DocumentIDs
- PITCH-0001
- RA-001



```text
[V-SCRIPT]:
add_persona_evidence_link.sh
remove_persona_evidence_link.sh
```

### Links

```text
[V-SCRIPT]:
add_persona_related_link.sh
remove_persona_related_link.sh
```

## Notes

```text
[V-SCRIPT]:
add_persona_note.sh
overwrite_persona_notes.sh
```

- Inferred need for clear guidance and meaningful offline progress from SEG-0001 hypotheses in RA-001.
- Packaging risk: cozy framing must not feel childish for lapsed idle players.
- Objection to address: monetization fairness and pacing stalls remain the quickest churn triggers.

