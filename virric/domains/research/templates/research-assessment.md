This template has moved to a **bundle** format to keep deep research output format-compliant and linkable.

Use the bundle templates:
- `virric/domains/research/templates/research-assessment-bundle/`

Use the bundle scripts (run from repo root):
- `./virric/domains/research/scripts/create_ra_bundle.sh`
- `./virric/domains/research/scripts/validate_ra_bundle.sh`
- `./virric/domains/research/scripts/assemble_ra_bundle.sh`

High-level: an RA is a folder containing a short coversheet plus structured annexes (reference solutions, competition, hypotheses, evidence, methods) and optional pitch files.

---

(Deprecated: monolithic template retained below for reference; prefer bundle.)

ID: RA-0001
Title: <short title>
Status: Draft
Priority: Medium
Updated: YYYY-MM-DD
Dependencies: 
Owner: 

## Purpose + constraints (read first)

This document is a **web-research-only research assessment**. It is a *cover letter* that distills key findings and **hypotheses** for downstream work in `<product-marketing>`, `<product-strategy>`, and `<product-management>`.

Hard constraints for the research agent:
- No interviews; assume **only public web sources**.
- Primary outputs are **reference solutions**, **competitive landscape**, and **candidate product pitches** grounded in public evidence.
- Outputs are **candidate segments/personas/pains/gains** (theories) with evidence pointers and confidence grades.
- Product definition and scope should remain **light** here; capture only what is necessary to frame pitches and hypotheses.

## Research coversheet (1–2 pages, must-have)

### 1) Mission + deliverables + sprint success criteria

Checklist:
- [ ] Mission statement: what decision this enables
- [ ] Deliverables list (counts + where they live)
- [ ] “Sprint success” definition (what must be true at the end)
- [ ] Downstream consumers (domains/agents) and what they need next

Deliverables (expected):
- Reference solutions scan (market + academic) with stable IDs and pointers
- Competitive landscape summary (categories + key players + positioning)
- 3–7 candidate product pitches (PITCH-*) with EvidenceIDs + confidence
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

### 5) Candidate product pitches (stepping stones)

Checklist:
- [ ] 3–7 pitches only (keep sharp)
- [ ] Each pitch ties to a segment/persona hypothesis and a concrete pain→gain loop
- [ ] Each pitch includes differentiation and “we lose when…” conditions
- [ ] Each pitch includes EvidenceIDs + confidence (C1–C3)

Pitch format:
- PitchID: PITCH-0001
- Name:
- One-line pitch:
- Target segment(s) (SEG-*):
- Target persona(s) (PER-*):
- Trigger / why-now:
- Core pain → promised gain:
- “So it works because…” (mechanism, not scope):
- Differentiation vs reference solutions:
- Likely objections + counters:
- EvidenceIDs:
- Confidence (C1–C3):
- “We lose when…”:
- Unknowns to validate next:

### 6) Downstream handoff (do not finalize here)

Checklist:
- [ ] `<product-marketing>` consumes: candidate segments/personas + pitches + evidence bank
- [ ] `<product-strategy>` consumes: competitive landscape + pitch set + key constraints/risks
- [ ] `<product-management>` consumes: the top pitch(es) + evidence + assumptions/unknowns

---

## Full research-assessment (multi-page, must-have)

### A) Reference solution scan (market + academic) — first objective

Checklist:
- [ ] Scan for similar ideas in-market (products, startups, OSS)
- [ ] Scan for similar ideas academically (papers, preprints, labs)
- [ ] Capture each as a ReferenceSolution with a stable ID + pointer
- [ ] Extract what to borrow vs avoid (patterns, claims, pitfalls)

Table:
| RefSolID | Type (Market/Academic) | Name | 1–2 line summary | What to borrow | What to avoid | Pointer |
|---|---|---|---|---|---|---|
| RS-0001 | Market | <...> | <...> | <...> | <...> | <link> |

### B) Competitive landscape + relative competition — second objective

Checklist:
- [ ] Identify direct/adjacent competitors and category substitutes
- [ ] Summarize positioning and differentiation axes
- [ ] Capture win/lose patterns (“we lose when…”) as hypotheses
- [ ] Note switching costs and inertia drivers

Table:
| Competitor | Category | ICP/segment | Positioning claim | Key strengths | Key weaknesses | “We lose when…” | Pointer |
|---|---|---|---|---|---|---|---|
| <...> | <...> | <...> | <...> | <...> | <...> | <...> | <link> |

### C) Research intent + method (web) + source profile + bias notes

Checklist:
- [ ] Research intent (what decision(s) this supports)
- [ ] Method(s) used (web search, competitive scan, doc triangulation, desk research)
- [ ] Source profile (types + counts): docs, blogs, analyst notes, forums, reviews, filings, OSS repos
- [ ] Date range and freshness
- [ ] Bias notes (selection bias, survivorship, availability)
- [ ] Confidence grading per key claim (C1–C3) + evidence strength (E0–E4)

### C.1) Research log (queries + source trail)

Checklist:
- [ ] Search queries used (and why)
- [ ] “Source trail” notes (how you followed references)
- [ ] What you deliberately ignored (and why)

Table (optional):
| Timestamp | Query / path | What you were testing | Sources opened |
|---|---|---|---|
| YYYY-MM-DD | <...> | <...> | <...> |

### D) Segmentation prioritization logic (incl. deprioritized segments)

Checklist:
- [ ] Prioritization logic (scoring or narrative)
- [ ] Buying-center dynamics by segment
- [ ] Deprioritized segments + rationale
- [ ] Explicit out-of-scope segments (repeat from coversheet if needed)

### E) Core workflows (3–7)

Checklist:
- [ ] 3–7 workflows only (keep sharp)
- [ ] Each workflow written as: trigger → steps → outcome
- [ ] Identify who performs each step (role tags)
- [ ] Identify integration/data prerequisites where relevant

### F) Ranked jobs / pains / gains per segment (with metrics + inertia)

Checklist:
- [ ] Per segment: ranked JTBD, pains, gains
- [ ] Severity + frequency per pain (1–5)
- [ ] Success metrics (how they measure “done”)
- [ ] Inertia sources (why they don’t change)

### G) Candidate persona dossiers (hypotheses; with evidence pointers)

Checklist:
- [ ] Persona stable ID (PER-XXXX) and segment stable ID (SEG-XXXX)
- [ ] Objections, decision criteria, terminology/lexicon
- [ ] Quotes + incident stories + workarounds
- [ ] Evidence IDs attached to each major claim

### H) Evidence pack (references + rubrics)

Checklist:
- [ ] Evidence bank includes quotes + incidents tagged to jobs/pains/gains
- [ ] Each evidence item has a stable EvidenceID (E-0001…)
- [ ] Evidence pointer (link/path) + context (who/when)
- [ ] Evidence strength (E0–E4) + confidence (C1–C3)

### I) Quantification anchors (value ranges)

Checklist:
- [ ] Unit of value (time saved, risk reduced, revenue, compliance)
- [ ] Measurable vs not measurable
- [ ] Time-to-value bands (ranges)
- [ ] Any quantified anchors (even rough ranges) + what would firm them up

### J) Alternatives, switching costs, win/lose patterns

Checklist:
- [ ] Do-nothing baseline and inertia
- [ ] Switching costs (technical, org, procurement)
- [ ] Competitor comparisons (if any)
- [ ] Explicit “we lose when…” conditions

### K) Messaging ingredients (candidate; usable by `<product-marketing>`)

Checklist:
- [ ] Resonant phrases (quotes preferred)
- [ ] Taboo words / red-flag claims
- [ ] Narrative frames that worked
- [ ] Claim constraints (must/must-not)

### L) Prioritized use-case catalog (mapped)

Checklist:
- [ ] Use cases mapped to personas + triggers
- [ ] Integration/data prerequisites
- [ ] Dependencies and constraints per use case

### M) Capability constraints + non-negotiables

Checklist:
- [ ] Latency / performance requirements
- [ ] Auditability / compliance requirements
- [ ] Data residency / security posture
- [ ] Support model expectations (if relevant)

### N) Assumption register + gaps + validation plan

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

