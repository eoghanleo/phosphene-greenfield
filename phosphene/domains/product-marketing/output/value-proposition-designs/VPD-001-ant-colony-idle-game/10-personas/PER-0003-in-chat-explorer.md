ID: PER-0003
Title: In-Chat Explorer
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001,CPE-0003,RA-001,PITCH-0003
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Snapshot summary

```text
[V-SCRIPT]:
update_persona_summary.sh
```

In-chat explorers are early adopters who want to play the ant colony game inside ChatGPT without breaking the conversation. They value seamless access, AI guidance, and novelty that feels shareable in chat. They will consider upgrades if trust and persistence feel solid.

## Jobs

```text
[V-SCRIPT]:
add_persona_jtbd_item.sh
update_persona_jtbd_item.sh
```

Each item has:
- ID format: `JTBD-JOB-0001-PER-0003` (types: `JOB|PAIN|GAIN`)
- Importance: 1–5 (5 = most important)

| JTBD-ID | Job | Importance |
|---|---|---:|
| JTBD-JOB-0002-PER-0003 | Launch the game inside ChatGPT without leaving the conversation. They want instant access that keeps the thread intact. The job is frictionless entry. | 5 |
| JTBD-JOB-0003-PER-0003 | Ask the AI to explain outcomes and suggest what to do next. They want guidance that makes the idle system legible in chat. The job is supported play without context switching. | 4 |
| JTBD-JOB-0004-PER-0003 | Get quick novelty and shareable moments without long sessions. They want small discoveries that feel fun to mention in chat. The job is to keep play lively and social. | 4 |
| JTBD-JOB-0005-PER-0003 | Keep progress persistent across sessions without manual saving. They want to return to the same colony state inside the chat. The job is effortless continuity. | 3 |
| JTBD-JOB-0006-PER-0003 | Decide whether to upgrade or spend without leaving chat. They need purchase flows that feel trustworthy and simple. The job is to support the experience confidently. | 3 |

## Pains

```text
[V-SCRIPT]:
add_persona_jtbd_item.sh
update_persona_jtbd_item.sh
```

| JTBD-ID | Pain | Importance |
|---|---|---:|
| JTBD-PAIN-0001-PER-0003 | Context switching to a browser breaks immersion and derails the conversation. They often abandon the experience when forced to leave chat. This friction undermines in-chat appeal. | 5 |
| JTBD-PAIN-0002-PER-0003 | The AI feels like a gimmick when it can’t explain or influence gameplay. They want assistance that changes decisions, not just flavor text. This pain makes the experience feel hollow. | 4 |
| JTBD-PAIN-0003-PER-0003 | Unclear persistence or data handling erodes trust in the in-chat experience. They worry progress could reset without warning. This pain blocks willingness to spend. | 4 |
| JTBD-PAIN-0004-PER-0003 | Purchasing inside chat feels uncertain or clunky. They are unsure what happens after payment. This hesitation slows upgrades. | 3 |
| JTBD-PAIN-0005-PER-0003 | Novelty fades quickly if the experience feels repetitive. They expect frequent new hooks to justify in-chat play. This pain leads to churn. | 3 |

## Gains

```text
[V-SCRIPT]:
add_persona_jtbd_item.sh
update_persona_jtbd_item.sh
```

| JTBD-ID | Gain | Importance |
|---|---|---:|
| JTBD-GAIN-0001-PER-0003 | Seamless in-chat launch that feels native to the conversation. They can start playing instantly without losing context. The gain is frictionless access. | 5 |
| JTBD-GAIN-0002-PER-0003 | AI-guided explanations that clarify what happened and why. They can ask questions and get useful summaries. The gain is feeling supported and curious. | 4 |
| JTBD-GAIN-0003-PER-0003 | Persistent state that reliably saves progress across sessions. They trust that the colony will be there next time. The gain is continuity confidence. | 4 |
| JTBD-GAIN-0004-PER-0003 | Trustworthy, low-friction upgrades that can be bought in chat. They want clarity on value and billing. The gain is safe support of the experience. | 3 |
| JTBD-GAIN-0005-PER-0003 | Frequent novelty moments that feel shareable and surprising. They want quick discoveries to keep the experience lively. The gain is sustained curiosity. | 3 |

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

```text
[V-SCRIPT]:
add_persona_evidence_link.sh
remove_persona_evidence_link.sh
```



- E-0009
- E-0010

### CandidatePersonaIDs

```text
[V-SCRIPT]:
add_persona_evidence_link.sh
remove_persona_evidence_link.sh
```


- CPE-0003

### DocumentIDs

```text
[V-SCRIPT]:
add_persona_evidence_link.sh
remove_persona_evidence_link.sh
```



- PITCH-0003
- RA-001

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



- 2026-01-26T12:01:52Z: Promoted from CPE-0003 (AI Alex) with emphasis on in-chat continuity, AI guidance, and trust signals for persistence and purchases. These extensions align with SEG-0003 evidence in RA-001.
