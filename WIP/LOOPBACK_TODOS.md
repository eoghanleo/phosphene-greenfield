## Loopback TODOs (short-term)

These are **memory anchors** for near-term follow-ups. They are *not* an execution queue for agents.

### Items

- [x] **1) Canonical schematic: `beryl` flow for `<product-marketing>`**
  - **Goal**: one authoritative end-to-end schematic from *incoming upstream signal* → *issue lifecycle* → *completion registered on the issue*.
  - **Include**
    - **Trigger**: upstream signal types + required fields as they appear in `phosphene/signals/bus.jsonl`
    - **Routing**: which gantry reacts to which `signal_type` (bus-push driven; no `workflow_dispatch`)
    - **Issue contract**: required labels, required `[PHOSPHENE]` block keys, and idempotency markers
    - **Completion**: what “done” means, how it’s validated, and which final bus signal(s) register completion
  - **Output**: a single diagram + a short written sequence (stepwise) that matches repo reality.

- [ ] **2) Tighten + lock the signal system (bus-first)**
  - **Goal**: consolidate and finalize the “signal bus” contract now that **100% of orchestration propagates via `bus.jsonl`**.
  - **Focus areas**
    - **Schema minimalism**: required fields, optional fields, and stable naming (`signal_type`, `intent`, `trigger`, etc.)
    - **Idempotency**: canonical composite key rules; how duplicates are prevented/detected
    - **Tamper hash**: normalized hashing rules and enforcement points
    - **Consumption semantics**: what it means to “consume” a signal, and how that is represented in the bus
    - **Detector responsibilities**: validation-only vs routing (and how routing is achieved purely via bus emissions)
  - **Output**: a single canonical spec doc + updated scripts/validators aligned to it.

- [x] **3) README tip: VS Code Markdown Preview editor association**
  - **Goal**: add a short note to the public `README.md` recommending setting VS Code’s Markdown “Preview” editor association for `*.md` so navigation/reading is smoother.

