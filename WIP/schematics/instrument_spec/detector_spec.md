## DETECTOR — spec

<table width="100%">
  <tr>
    <td width="340" valign="top">
      <img
        src="https://github.com/user-attachments/assets/c8f1a4d7-098a-47cf-be2e-496cf7313ec6"
        alt="FLORA-Obsidian Detector Render-fce2117b"
        width="340"
      />
    </td>
    <td valign="top">
      The `DETECTOR` is the ruling corridor: you hand it a ref (a branch beam or the main beam) and it deterministically evaluates predicates against what it finds there. A detector is how PHOSPHENE turns “someone says it’s done” into “the system agrees it’s done,” because it can validate IDs, run domain validators, and compute “done scores” in a consistent way. Detectors treat receipts as invitations to verify, and treat verification as beam physics, not social trust. When it finishes, it emits a ruling signal (approve or trap) that downstream gantries can treat as a reliable gate rather than a conversation.
    </td>
  </tr>
</table>

### Purpose

- Provide deterministic verification against a ref (branch beam or main beam).
- Convert DONE receipts into authoritative rulings (approve or trap).

### Responsibilities

- MUST validate the signal bus (tamper hashes, append-only).
- MUST extract DONE receipts from PR diffs and validate IDs.
- MUST run domain validators (PRD bundles, personas, propositions).
- MUST compute done scores and enforce domain thresholds.
- MUST emit approve or trap signals to the bus.

### Inputs (expected)

- PR events containing DONE receipts in the diff.
- `phosphene/signals/bus.jsonl` on `main` (for validation and signal appends).
- `workflow_dispatch` inputs for manual verification.
- Domain artifacts referenced by the receipt (PRD bundles, PER/PROP).

### Outputs (signals / side effects)

- Bus signals: `phosphene.detector.<domain>.approve.v1` or `phosphene.detector.<domain>.trap.v1`.
- Optional PR comments (manual dispatch mode).
- GitHub Actions summaries reporting validator results.

### Trigger surface

- MUST trigger on `pull_request` (opened, synchronize, reopened).
- `push` to `main` MAY be supported for bus validation.
- `workflow_dispatch` MAY be supported for manual runs.

### Configuration

- MUST read done score thresholds via `phosphene/config/<color>.yml` keys:
  - `product-marketing.done_score_min` (beryl, default 80)
  - `product-management.done_score_min` (cerulean, default 80)
- MUST require `PHOSPHENE_HUMAN_TOKEN` to push bus signals.
- MUST enforce write allowlist via `gantry_write_allowlist_guard.sh`.

### Constraints

- MUST write only to `phosphene/signals/**` and `phosphene/signals/indexes/**`.
- MUST enforce append-only bus with valid tamper hashes.
- MUST NOT mutate artifacts directly.

### Idempotency

- MUST use deterministic signal IDs (`signal_hash.sh`) for approve/trap events.
- MUST check for existing `signal_id` in `bus.jsonl` before appending.

### Failure modes

- DONE receipt missing or malformed (no-op or trap).
- Validator failure or done score below threshold (trap with `reason: verification_failed`).
- Bus validation failure (tamper hash mismatch).
- Missing `PHOSPHENE_HUMAN_TOKEN` (refuses to write).

### Observability

- GitHub Actions logs and step summaries.
- Bus commits announcing approve/trap signals.
- PR comments in manual dispatch mode.

### Open questions

- Should detectors emit richer failure metadata beyond `reason`?
- Do we need standardized validator output schemas across domains?

