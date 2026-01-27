## HOPPER — spec

<table width="100%">
  <tr>
    <td width="340" valign="top">
      <img
        src="https://github.com/user-attachments/assets/9da052b1-6590-45dd-a7aa-f9b3e0742204"
        alt="FLORA-Studio Hero Shot-119972a7"
        width="340"
      />
    </td>
    <td valign="top">
      The `HOPPER` is the gate at the flimsie boundary. It watches flimsie updates, checks whether a flimsie is eligible to start (domain label, lane, ready/not-blocked, and whether it can parse the canonical PHOSPHENE block), and then emits the “start” signal that wakes a prism. The hopper’s personality is intentionally strict and boring: if it can’t parse, it asks autoscribe to fix; if it’s not eligible, it says why; if it is eligible, it starts the machine and gets out of the way.
    </td>
  </tr>
</table>

### Purpose

- Gate flimsies at the issue boundary and decide when work is eligible to start.
- Emit start signals that wake the prism for the correct lane/domain.

### Responsibilities

- MUST parse a strict `[PHOSPHENE]` block schema and reject any deviations.
- MUST validate eligibility: domain label, lane, ready label, not blocked/hold.
- MUST verify dependencies (must be closed or done-labeled).
- MUST emit `phosphene.hopper.<domain>.start.v1` to the bus when eligible.
- MUST comment on issues with status reports or autoscribe fix requests.

### Inputs (expected)

- Issue events (opened/edited/reopened/labeled/unlabeled).
- Issue body with `[PHOSPHENE]` block (`lane`, `work_type`, `work_id`, `intent`).
- Bus `issue_created` signals (domain hoppers on `main`).
- `/hopper` or `/phosphene` commands (global workflows).

### Outputs (signals / side effects)

- Bus signals: `phosphene.hopper.<domain>.start.v1`.
- Issue comments with eligibility reports and start confirmations.
- Autoscribe fix requests when the PHOSPHENE block is malformed.

### Trigger surface

- MUST trigger from bus changes for domain hoppers (`push` to `main` when `bus.jsonl` changes).
- `workflow_dispatch` MAY be supported for manual runs.
- Issue/comment triggers are non-canonical and MUST NOT be relied on.

### Configuration

- MUST require `PHOSPHENE_HUMAN_TOKEN` for bus commits.
- MUST enforce write allowlist via `gantry_write_allowlist_guard.sh`.
- MUST enforce domain lane correctness (e.g., product-management = cerulean, product-marketing = beryl).

### Constraints

- MUST be comment-only (no issue edits or relabels).
- MUST NOT start closed issues.
- MUST require `phosphene:ready` and absence of `phosphene:blocked` or `phosphene:hold`.

### Idempotency

- MUST check bus for an existing `start` signal for the issue.
- MUST avoid duplicate start comments if already emitted.

### Failure modes

- Missing or INFORMAL PHOSPHENE block (requests autoscribe fix or no-op).
- Missing domain label or wrong lane (reports and skips).
- Dependencies not satisfied (reports and skips).
- Missing `PHOSPHENE_HUMAN_TOKEN` (refuses to write).

### Observability

- Issue comments with structured status markers.
- Bus commits for `start` signals.
- GitHub Actions logs detailing eligibility decisions.

### Open questions

- Do we want a standardized eligibility report format across domains?

