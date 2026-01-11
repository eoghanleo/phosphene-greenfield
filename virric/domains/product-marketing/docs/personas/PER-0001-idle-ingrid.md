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

- Casual idle gamer seeking stress-free progress in short check-in sessions.
- Wants cute, low-cognitive-load colony growth with meaningful offline gains.
- Highly sensitive to monetization pressure and pacing slowdowns.
- Success is fair optional spending and a relaxing, satisfying loop.

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
| JTBD-JOB-0001-PER-0001 | Get satisfying progress during a short check-in session. | 5 |
| JTBD-JOB-0002-PER-0001 | Collect offline rewards and choose quick upgrades without thinking hard. | 4 |
| JTBD-JOB-0003-PER-0001 | Feel a sense of ownership by growing a cute colony over time. | 3 |
| JTBD-JOB-0004-PER-0001 | Fill small downtime moments with low-friction entertainment. | 4 |
| JTBD-JOB-0005-PER-0001 | Know the next best action quickly without reading long tutorials. | 4 |

## Pains

```text
[V-SCRIPT]:
add_persona_jtbd_item.sh
update_persona_jtbd_item.sh
```

| JTBD-ID | Pain | Importance |
|---|---|---:|
| JTBD-PAIN-0001-PER-0001 | Feeling pressured by aggressive monetization or whale-bait pricing. | 5 |
| JTBD-PAIN-0002-PER-0001 | Overwhelmed by complex systems or too much UI on first session. | 4 |
| JTBD-PAIN-0003-PER-0001 | Progress slows down later, making check-ins feel unrewarding. | 4 |
| JTBD-PAIN-0004-PER-0001 | Repetitive actions without new surprises or variety. | 3 |
| JTBD-PAIN-0005-PER-0001 | Frequent ads or grind that interrupts the relaxing loop. | 3 |

## Gains

```text
[V-SCRIPT]:
add_persona_jtbd_item.sh
update_persona_jtbd_item.sh
```

| JTBD-ID | Gain | Importance |
|---|---|---:|
| JTBD-GAIN-0001-PER-0001 | Stress-free play that feels relaxing and low-stakes. | 5 |
| JTBD-GAIN-0002-PER-0001 | Fair optional monetization that never blocks progress. | 5 |
| JTBD-GAIN-0003-PER-0001 | Meaningful offline progress that shows up as visible growth. | 4 |
| JTBD-GAIN-0004-PER-0001 | Cute, charming visuals that feel delightful rather than gross. | 3 |
| JTBD-GAIN-0005-PER-0001 | Clear short-term goals and feedback that keep check-ins rewarding. | 4 |

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
- E-0004
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

<free-form notes>

- 2026-01-11T05:21:43Z: Inferred JTBDs around ad fatigue, cute presentation, and rapid next-step guidance are extensions of SEG-0001 hypotheses in RA-001; keep them as hypotheses until validated.
