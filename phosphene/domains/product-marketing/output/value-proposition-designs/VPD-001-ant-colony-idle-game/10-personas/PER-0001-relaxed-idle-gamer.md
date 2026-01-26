ID: PER-0001
Title: Relaxed Idle Gamer
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001,CPE-0001,RA-001,PITCH-0001
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Snapshot summary

```text
[V-SCRIPT]:
update_persona_summary.sh
```

Relaxed idle gamers are casual players who dip into an idle ant colony game in short downtime windows and want to feel meaningful progress without cognitive overhead. They care about low-friction onboarding, clear next steps, and satisfying visual feedback that makes a 3–5 minute session feel complete. They are sensitive to monetization pressure and pacing stalls, preferring optional spend that feels fair and does not block progress.

## Jobs

```text
[V-SCRIPT]:
add_persona_jtbd_item.sh
update_persona_jtbd_item.sh
```

Each item has:
- ID format: `JTBD-JOB-0001-PER-0001` (types: `JOB|PAIN|GAIN`)
- Importance: 1–5 (5 = most important)

| JTBD-ID | Job | Importance |
|---|---|---:|
| JTBD-JOB-0002-PER-0001 | Fill short downtime with a low-friction session that still feels like real progress. They want to open the game, see what happened while away, and make a couple of meaningful choices in under five minutes. The job is to feel momentum without committing to a long play session. | 5 |
| JTBD-JOB-0003-PER-0001 | Make quick upgrades without studying a complex system. They want the next-best action to be obvious, with a short explanation of why it matters. The job is to feel smart without feeling like they are doing homework. | 4 |
| JTBD-JOB-0004-PER-0001 | See the colony visibly grow and change to reinforce the sense of progress. They want upgrades to show up as new tunnels, ants, or behaviors rather than invisible numbers. The job is to feel delight and ownership over the colony. | 4 |
| JTBD-JOB-0005-PER-0001 | Re-engage after a few days away without feeling lost. They want a catch-up recap and a small set of choices that get them back on track quickly. The job is to re-enter the game without rereading tutorials. | 3 |
| JTBD-JOB-0006-PER-0001 | Decide whether to spend or watch ads without feeling manipulated. They want clarity on what is optional and what is core progression. The job is to enjoy the game while staying in control of their budget and time. | 3 |

## Pains

```text
[V-SCRIPT]:
add_persona_jtbd_item.sh
update_persona_jtbd_item.sh
```

| JTBD-ID | Pain | Importance |
|---|---|---:|
| JTBD-PAIN-0001-PER-0001 | Monetization feels coercive or pay-to-win, with popups that interrupt the flow. The player worries that progress will slow to a crawl unless they spend. This creates distrust and makes them quit before they form a habit. | 5 |
| JTBD-PAIN-0002-PER-0001 | The opening experience throws too many systems and currencies at once. They feel overwhelmed before they understand what matters, so early sessions feel like chores. The pain is mental load rather than difficulty. | 4 |
| JTBD-PAIN-0003-PER-0001 | Progression slows down after the novelty wears off, turning into repetitive tapping. They can’t see a new goal on the horizon and feel like the game is stalling. This makes them abandon the game during week two. | 4 |
| JTBD-PAIN-0004-PER-0001 | Sessions feel identical day after day, with no new surprises or variety. The game becomes background noise instead of a small delight. Without novelty, they stop checking in during downtime. | 3 |
| JTBD-PAIN-0005-PER-0001 | They worry that stepping away means missing limited-time rewards or falling behind. Guilt-based retention tactics make the game feel like a chore. This conflicts with their desire for a stress-free experience. | 3 |

## Gains

```text
[V-SCRIPT]:
add_persona_jtbd_item.sh
update_persona_jtbd_item.sh
```

| JTBD-ID | Gain | Importance |
|---|---|---:|
| JTBD-GAIN-0001-PER-0001 | Optional monetization that feels fair and transparent. They are happy to spend small amounts when it clearly boosts convenience or cosmetics without blocking core progress. The gain is trust that their time is respected. | 5 |
| JTBD-GAIN-0002-PER-0001 | A calm, relaxing loop that feels soothing rather than competitive. The game helps them decompress during short breaks. The gain is emotional relief alongside progress. | 4 |
| JTBD-GAIN-0003-PER-0001 | A satisfying sense of achievement in under five minutes. They want clear milestones and rewards that pop quickly after each check-in. The gain is a quick hit of accomplishment without long sessions. | 4 |
| JTBD-GAIN-0004-PER-0001 | Delightful visuals and quirky ant behaviors that make the colony feel alive. They enjoy small discoveries like new ant types or animations that keep the theme charming. The gain is light entertainment beyond pure optimization. | 3 |
| JTBD-GAIN-0005-PER-0001 | Offline progress with a clear catch-up summary. They want the game to reward time away rather than punish it. The gain is feeling that the colony kept working while they lived their life. | 3 |

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




- E-0001
- E-0003
- E-0012

### CandidatePersonaIDs

```text
[V-SCRIPT]:
add_persona_evidence_link.sh
remove_persona_evidence_link.sh
```


- CPE-0001

### DocumentIDs

```text
[V-SCRIPT]:
add_persona_evidence_link.sh
remove_persona_evidence_link.sh
```



- PITCH-0001
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



- 2026-01-26T10:41:21Z: Promoted from CPE-0001 (Idle Ingrid) with inferred emphasis on quick catch-up sessions and optional monetization clarity based on SEG-0001 hypotheses in RA-001. Inferences are extensions of evidence around stress-free idle play and monetization sensitivity.
