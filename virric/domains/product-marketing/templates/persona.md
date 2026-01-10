ID: PER-0001
Title: <persona name>
Status: Draft
Updated: YYYY-MM-DD
Dependencies: 
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/virric/product-marketing/SKILL.md)

## Snapshot summary

Scripts: update_persona_summary.sh

<2–6 bullet snapshot. Keep it crisp.>

## Jobs

Scripts: add_persona_jtbd_item.sh, update_persona_jtbd_item.sh

Each item has:
- ID: `JTBD-<TYPE>-####-<PersonaID>` where `<TYPE>` is `JOB|PAIN|GAIN`
- Importance: 1–5 (5 = most important)

| JTBD-ID | Job | Importance |
|---|---|---:|
| JTBD-JOB-0001-PER-0001 | <job> | 3 |

## Pains

Scripts: add_persona_jtbd_item.sh, update_persona_jtbd_item.sh

| JTBD-ID | Pain | Importance |
|---|---|---:|
| JTBD-PAIN-0001-PER-0001 | <pain> | 4 |

## Gains

Scripts: add_persona_jtbd_item.sh, update_persona_jtbd_item.sh

| JTBD-ID | Gain | Importance |
|---|---|---:|
| JTBD-GAIN-0001-PER-0001 | <gain> | 4 |

## Evidence and links

Scripts: add_persona_evidence_link.sh, remove_persona_evidence_link.sh, add_persona_related_link.sh, remove_persona_related_link.sh

Store supporting IDs and pointers here (no prose argumentation—just traceability).

### EvidenceIDs

Scripts: add_persona_evidence_link.sh, remove_persona_evidence_link.sh
- E-0001

### CandidatePersonaIDs

Scripts: add_persona_evidence_link.sh, remove_persona_evidence_link.sh
- CPE-0001

### DocumentIDs

Scripts: add_persona_evidence_link.sh, remove_persona_evidence_link.sh
- RA-001
- PITCH-0001
- RS-0001

### Links

Scripts: add_persona_related_link.sh, remove_persona_related_link.sh
- <url or repo path>

## Notes

Scripts: add_persona_note.sh, overwrite_persona_notes.sh

<free-form notes>

