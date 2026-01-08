ID: RA-0001
Title: <short title>
Status: Draft
Priority: Medium
Updated: YYYY-MM-DD
Dependencies: 
Owner: 

## Purpose + constraints (read first)

This document is a **web-research-only research assessment**. It is a *cover letter* that distills key findings and **hypotheses** that downstream agents will refine in:

- Product marketing (personas + propositions): `virric/domains/product-marketing/templates/`
- Product strategy (roadmap): `virric/domains/product-strategy/templates/`
- Product management (spec): `virric/domains/product-management/templates/`

Hard constraints for the research agent:
- No interviews; assume **only public web sources**.
- Outputs are **candidate segments/personas/pains/gains** (theories) with evidence pointers and confidence grades.
- Product definition detail should remain **light** here; capture only what is necessary to ground hypotheses.

## Research coversheet (1–2 pages, must-have)

### 1) Mission + deliverables + sprint success criteria

Checklist:
- [ ] Mission statement: what decision this enables
- [ ] Deliverables list (counts + where they live)
- [ ] “Sprint success” definition (what must be true at the end)
- [ ] Downstream consumers (domains/agents) and what they need next

Deliverables (expected):
- Candidate segments (SEG-*) ranked, with rationale + out-of-scope list
- Candidate personas (PER-*) per top segment (hypotheses)
- Candidate jobs/pains/gains (IDs) per segment with severity/frequency (hypotheses)
- Evidence bank (EvidenceID + excerpt + pointer + strength/confidence)
- 5–15 “Key claims” with confidence grades (what seems true from web sources)

### 2) Scope, grounding, and what we *don’t* know

Checklist:
- [ ] Minimal product grounding: what it might be (1 sentence) + what it likely isn’t
- [ ] Research scope boundaries (industries, geos, buyer types) and why
- [ ] Unknowns that cannot be resolved via web research (explicit)
- [ ] Assumptions you made to proceed (explicit)

### 3) Top hypotheses snapshot (theories)

Checklist:
- [ ] Top 3–5 candidate segments (ranked) and the wedge hypothesis
- [ ] For each: top 3 pains + top 3 gains (IDs)
- [ ] Candidate buying-center map (if inferable): buyer/champion/user/implementer
- [ ] Triggers / “why now” candidates

### 4) Key findings (evidence-backed)

Format for each finding:
- Claim:
- Why it matters:
- EvidenceIDs:
- Confidence (C1–C3):
- Notes / caveats:

### 5) Handoff pointers (do not finalize here)

Checklist:
- [ ] For personas + propositions: create a brief using `virric/domains/product-marketing/templates/persona-proposition-generation-brief.md`
- [ ] For strategy: seed bets in `virric/domains/product-strategy/templates/product-roadmap.md`
- [ ] For product definition/spec: seed `virric/domains/product-management/templates/product-spec.md`

---

## Full research-assessment (multi-page, must-have)

### A) Research intent + method (web) + source profile + bias notes

Checklist:
- [ ] Research intent (what decision(s) this supports)
- [ ] Method(s) used (web search, competitive scan, doc triangulation, desk research)
- [ ] Source profile (types + counts): docs, blogs, analyst notes, forums, reviews, filings, OSS repos
- [ ] Date range and freshness
- [ ] Bias notes (selection bias, survivorship, availability)
- [ ] Confidence grading per key claim (C1–C3) + evidence strength (E0–E4)

### A.1) Research log (queries + source trail)

Checklist:
- [ ] Search queries used (and why)
- [ ] “Source trail” notes (how you followed references)
- [ ] What you deliberately ignored (and why)

Table (optional):
| Timestamp | Query / path | What you were testing | Sources opened |
|---|---|---|---|
| YYYY-MM-DD | <...> | <...> | <...> |

### B) Segmentation prioritization logic (incl. deprioritized segments)

Checklist:
- [ ] Prioritization logic (scoring or narrative)
- [ ] Buying-center dynamics by segment
- [ ] Deprioritized segments + rationale
- [ ] Explicit out-of-scope segments (repeat from coversheet if needed)

### C) Core workflows (3–7)

Checklist:
- [ ] 3–7 workflows only (keep sharp)
- [ ] Each workflow written as: trigger → steps → outcome
- [ ] Identify who performs each step (role tags)
- [ ] Identify integration/data prerequisites where relevant

### D) Ranked jobs / pains / gains per segment (with metrics + inertia)

Checklist:
- [ ] Per segment: ranked JTBD, pains, gains
- [ ] Severity + frequency per pain (1–5)
- [ ] Success metrics (how they measure “done”)
- [ ] Inertia sources (why they don’t change)

### E) Candidate persona dossiers (hypotheses; with evidence pointers)

Checklist:
- [ ] Persona stable ID (PER-XXXX) and segment stable ID (SEG-XXXX)
- [ ] Objections, decision criteria, terminology/lexicon
- [ ] Quotes + incident stories + workarounds
- [ ] Evidence IDs attached to each major claim

### F) Evidence pack (references + rubrics)

Checklist:
- [ ] Evidence bank includes quotes + incidents tagged to jobs/pains/gains
- [ ] Each evidence item has a stable EvidenceID (E-0001…)
- [ ] Evidence pointer (link/path) + context (who/when)
- [ ] Evidence strength (E0–E4) + confidence (C1–C3)

### G) Quantification anchors (value ranges)

Checklist:
- [ ] Unit of value (time saved, risk reduced, revenue, compliance)
- [ ] Measurable vs not measurable
- [ ] Time-to-value bands (ranges)
- [ ] Any quantified anchors (even rough ranges) + what would firm them up

### H) Alternatives, switching costs, win/lose patterns

Checklist:
- [ ] Do-nothing baseline and inertia
- [ ] Switching costs (technical, org, procurement)
- [ ] Competitor comparisons (if any)
- [ ] Explicit “we lose when…” conditions

### I) Messaging ingredients (candidate; usable by product-marketing)

Checklist:
- [ ] Resonant phrases (quotes preferred)
- [ ] Taboo words / red-flag claims
- [ ] Narrative frames that worked
- [ ] Claim constraints (must/must-not)

### J) Prioritized use-case catalog (mapped)

Checklist:
- [ ] Use cases mapped to personas + triggers
- [ ] Integration/data prerequisites
- [ ] Dependencies and constraints per use case

### K) Capability constraints + non-negotiables

Checklist:
- [ ] Latency / performance requirements
- [ ] Auditability / compliance requirements
- [ ] Data residency / security posture
- [ ] Support model expectations (if relevant)

### L) Assumption register + gaps + validation plan

Checklist:
- [ ] Assumptions (explicit)
- [ ] Research gaps and unknowns
- [ ] Validation plan (next experiments)
- [ ] “Do not sell here” edge cases (explicit)

---

## Agent-friendly appendices (tables; high leverage)

### 1) Canonical segment table (stable IDs)

| SegmentID | Segment name | Rank | In-scope? | Buyer map notes | Top pains (IDs) | Top gains (IDs) |
|---|---|---:|---|---|---|---|
| SEG-0001 | <...> | 1 | Yes | <...> | P-... | G-... |

### 2) Canonical persona table (stable IDs)

| PersonaID | Persona name | SegmentID | Role tags | Rank pains | Rank gains | Objections (top) |
|---|---|---|---|---|---|---|
| PER-0001 | <...> | SEG-0001 | <...> | P-... | G-... | <...> |

### 3) Glossary + naming table

| Canonical term | Disallowed synonyms | Notes |
|---|---|---|
| <term> | <synonyms> | <...> |

### 4) Quote + incident evidence bank

| EvidenceID | Type | PersonaID | SegmentID | Tag (job/pain/gain) | Excerpt | Pointer | E-strength | Confidence |
|---|---|---|---|---|---|---|---|---|
| E-0001 | Quote | PER-0001 | SEG-0001 | P-... | "<...>" | <link/path> | E2 | C2 |

