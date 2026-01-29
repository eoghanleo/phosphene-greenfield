## Loopback TODOs (short-term)

These are **memory anchors** for near-term follow-ups. They are *not* an execution queue for agents.

### Items

- [ ] **2) Tighten + lock the signal system (bus-first)**
  - **Goal**: consolidate and finalize the “signal bus” contract now that **100% of orchestration propagates via `bus.jsonl`**.
  - **Focus areas**
    - **Schema minimalism**: required fields, optional fields, and stable naming (`signal_type`, `intent`, `trigger`, etc.)
    - **Idempotency**: canonical composite key rules; how duplicates are prevented/detected
    - **Tamper hash**: normalized hashing rules and enforcement points
    - **Consumption semantics**: what it means to “consume” a signal, and how that is represented in the bus
    - **Detector responsibilities**: validation-only vs routing (and how routing is achieved purely via bus emissions)
  - **Output**: a single canonical spec doc + updated scripts/validators aligned to it.

- [ ] **3) Done-score: add a deterministic “Novelty” component (LexNov\(_n\))**
  - **Idea**: compute **novel \(n\)-grams** in a candidate artifact/bundle relative to a **reference corpus \(R\)** (e.g., “all other outputs under the same context/beam”).
  - **Constraint**: keep it **completely deterministic + bash-only** by making \(R\) an explicit, stable, repo-derived set (sorted file discovery; pinned cleaning rules; no embeddings).
  - **Implementation note**: consider **\(n>1\)** (bigrams/trigrams) to catch **templated phrasing** that can slip past unigram-only diversity.

