ID: PM-BRIEF-0001
Title: Persona + Proposition Generation Brief
Status: Draft
Updated: YYYY-MM-DD
Dependencies: 
Owner: 

## What this is

This brief is the **minimum handover** for an autonomous agent to generate:

- candidate personas (`PER-*`)
- candidate propositions (`PROP-*`)

Inputs are typically a research assessment (`RA-*`) from `<research>` that contains evidence-backed hypotheses and candidate product pitches (`PITCH-*`).

## A) Coversheet (1–2 pages, must-have)

### 1) Mission, deliverables, formats, and sprint success criteria

Checklist:
- [ ] Mission (what decision this enables)
- [ ] Deliverables list with counts (avoid directory pointers here)
- [ ] Format constraints (max lengths, one-page canvases)
- [ ] Sprint success criteria

### 2) Concrete product definition + boundaries (what it is / is not)

Checklist:
- [ ] One-sentence product definition
- [ ] What it is not (non-goals)
- [ ] Maturity + delivery shape assumptions
- [ ] Non-goals that must not leak into messaging

### 3) ICP wedge + segmentation frame (ranked)

Checklist:
- [ ] Segmentation frame
- [ ] Ranked target segments (top 3–5) + rationale
- [ ] Out-of-scope segments (explicit)

### 4) Buyer and user map (buying center)

Checklist:
- [ ] Economic buyer, champion, end user, implementer, approver, blocker
- [ ] Procurement and security hurdles (explicit)

### 5) Decision rights + escalation rules

Checklist:
- [ ] Who resolves ambiguity
- [ ] Safe assumptions vs must-validate
- [ ] How to treat low-confidence claims

### 6) Positioning + claims constraints

Checklist:
- [ ] Legal/compliance/security/brand constraints
- [ ] No-go language list
- [ ] Taboo words + red-flag claims

### 7) Canonical glossary + naming conventions

Checklist:
- [ ] Canonical terms + disallowed synonyms
- [ ] Naming conventions for personas/segments/capabilities

### 8) Triggers and “why now” catalysts

Checklist:
- [ ] Triggers (events that cause urgency)
- [ ] “Why now” narrative anchors

### 9) Alternatives + competitive context

Checklist:
- [ ] Do-nothing, DIY, incumbents, adjacent tools, internal build
- [ ] Win-when / lose-when conditions

### 10) Proof points we truly have (+ what we cannot claim)

Checklist:
- [ ] Proof points (only verified)
- [ ] Claims we cannot make yet

### 11) Capability inventory framed as outcomes (Now/Next/Later)

Checklist:
- [ ] Outcome-framed capabilities
- [ ] Now/Next/Later tags
- [ ] Dependencies and limitations

### 12) Pricing, packaging, and adoption hypotheses

Checklist:
- [ ] Adoption friction + change management needs
- [ ] Time-to-value bands
- [ ] Expansion path hypothesis

### 13) Output contract (canvas schema + rubrics + examples)

Checklist:
- [ ] Exact canvas schema (required fields, max lengths)
- [ ] Required metadata (segment, role tags, objections/counters, confidence, evidence IDs)
- [ ] Summary sheet columns
- [ ] Fit scoring rubric (0–5)
- [ ] Evidence-strength rubric
- [ ] One completed example of each canvas

Persona canvas (max 1 page):
- `PersonaID`, `SegmentID`, `RoleTags`
- `JTBD` (top 3), `Pains` (ranked), `Gains` (ranked)
- `DecisionCriteria`, `Objections`, `Procurement/SecurityHurdles`
- `ResonantPhrases`, `TabooWords`
- `Confidence`, `EvidenceIDs[]`

Proposition canvas (max 1 page):
- `SegmentID`, `PersonaID`
- `ValueProposition` (one sentence)
- `KeyBenefits` (3–5), `ProofPoints` (only verified)
- `WinWhen`, `LoseWhen`, `NoGoClaims`
- `Confidence`, `EvidenceIDs[]`

Rubrics (starter):
- Evidence strength (E0–E4): assertion → quantified triangulation
- Confidence (C1–C3): low → high

### 14) Anti-personas

Checklist:
- [ ] Who not to target first and why
- [ ] Revisit trigger

---

## B) Evidence pack pointer (required)

Checklist:
- [ ] Link to the source `RA-*` and any underlying evidence bank (as identifiers / pointers)
- [ ] List the top EvidenceIDs that must be used for claims

RA link:
- <pointer to RA-* (repo path or external link)>

---

## C) Agent-friendly appendices (optional tables)

### 1) Capability table (stable IDs; maturity)

| CapID | Outcome | Now/Next/Later | Dependencies | Limitations | Proof available? | EvidenceIDs |
|---|---|---|---|---|---|---|
| CAP-0001 | <...> | Now | <...> | <...> | Yes/No | E-... |

### 2) Glossary + naming table

| Canonical term | Disallowed synonyms | Notes |
|---|---|---|
| <term> | <synonyms> | <...> |

### 3) Fit map scaffold

| CapID | Maps to job/pain/gain | Proof points | EvidenceIDs | Fit score (0–5) | Notes |
|---|---|---|---|---:|---|
| CAP-0001 | P-... | <...> | E-... | 4 | <...> |

