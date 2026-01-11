ID: PER-0003
Title: AI Alex
Status: Draft
Updated: 2026-01-11
Dependencies: CPE-0003,RA-001,PITCH-0002
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/virric/product-marketing/SKILL.md)

## Snapshot summary

```text
[V-SCRIPT]:
update_persona_summary.sh
```

- ChatGPT power user seeking seamless in-chat entertainment.
- Values zero context switching and AI explanations that add real utility.
- Open to low-friction in-chat purchases when trust is high.
- Sensitive to gimmicks, state loss, and privacy concerns.

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
| JTBD-JOB-0001-PER-0003 | Launch and play without leaving the chat context. | 5 |
| JTBD-JOB-0002-PER-0003 | Ask the AI to explain outcomes or suggest moves. | 5 |
| JTBD-JOB-0003-PER-0003 | Get quick entertainment bursts during work or study breaks. | 4 |
| JTBD-JOB-0004-PER-0003 | Experiment with novel in-chat apps and share discoveries. | 4 |
| JTBD-JOB-0005-PER-0003 | Make quick, trusted purchases without leaving the chat. | 3 |

## Pains

```text
[V-SCRIPT]:
add_persona_jtbd_item.sh
update_persona_jtbd_item.sh
```

| JTBD-ID | Pain | Importance |
|---|---|---:|
| JTBD-PAIN-0001-PER-0003 | Having to switch tabs breaks the flow. | 5 |
| JTBD-PAIN-0002-PER-0003 | AI features feel gimmicky and add no real value. | 4 |
| JTBD-PAIN-0003-PER-0003 | Unclear data privacy or safety makes me hesitate. | 4 |
| JTBD-PAIN-0004-PER-0003 | Progress disappears between sessions or devices. | 3 |
| JTBD-PAIN-0005-PER-0003 | In-chat games feel clunky or slow to load. | 3 |

## Gains

```text
[V-SCRIPT]:
add_persona_jtbd_item.sh
update_persona_jtbd_item.sh
```

| JTBD-ID | Gain | Importance |
|---|---|---:|
| JTBD-GAIN-0001-PER-0003 | Instant in-chat launch with no context switching. | 5 |
| JTBD-GAIN-0002-PER-0003 | AI explanations that make the sim feel smarter. | 5 |
| JTBD-GAIN-0003-PER-0003 | Smooth session persistence across devices. | 4 |
| JTBD-GAIN-0004-PER-0003 | Low-friction, trusted in-chat purchases when ready. | 3 |
| JTBD-GAIN-0005-PER-0003 | Fast onboarding that starts in seconds. | 4 |

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
- E-0009
- E-0010



```text
[V-SCRIPT]:
add_persona_evidence_link.sh
remove_persona_evidence_link.sh
```

### CandidatePersonaIDs
- CPE-0003


```text
[V-SCRIPT]:
add_persona_evidence_link.sh
remove_persona_evidence_link.sh
```

### DocumentIDs
- PITCH-0002
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

- Inferred expectations for persistence and rapid onboarding from SEG-0003 hypotheses in RA-001.
- Channel risk: ChatGPT app discovery and policy shifts could impact adoption.
- Objection to address: trust/privacy concerns need explicit handling.

