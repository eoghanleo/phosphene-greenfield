## AUTOSCRIBE — spec

<table width="100%">
  <tr>
    <td width="340" valign="top">
      <img
        src="https://github.com/user-attachments/assets/b45948d2-dc60-4241-b535-633bac23863c"
        alt="FLORA-Mechanized Scribe Console-088097e6"
        width="340"
      />
    </td>
    <td valign="top">
      The `AUTOSCRIBE` is the cleric that creates the public record. It turns explicit triggers into flimsies (GitHub Issues) with a canonical, machine-readable `[PHOSPHENE] ... [/PHOSPHENE]` block that other instruments can safely interpret. Operationally, autoscribe is special because it is the only instrument allowed to create or mutate flimsies (title/body/labels/assignees/state); that strictness keeps the “case file” coherent even when many other instruments are active and beams are splitting and recombining.
    </td>
  </tr>
</table>

### Purpose

- Create the authoritative public record (flimsie / GitHub Issue) from bus triggers.
- Ensure each issue carries a canonical `[PHOSPHENE] ... [/PHOSPHENE]` block for downstream parsing.

### Responsibilities

- MUST create issues with canonical title/body/labels/assignees/state.
- MUST embed a strict `[PHOSPHENE]` block with required keys and order:
  - `lane`, `work_type`, `work_id`, `intent`, `depends_on`, `sequence`, `upstream_signal_id`.
- MUST apply labels: `phosphene`, `phosphene:<color>`, `phosphene:domain:<domain>`, `phosphene:instrument:autoscribe`, `phosphene:ready`.
- MUST emit `phosphene.autoscribe.<domain>.issue_created.v1` to the bus.
- MUST inject done-score thresholds into the issue prompt.

### Label taxonomy (issue-facing)

Issue labels are intended to be intersected for quick provenance checks:

- Core: `phosphene`
- Color: `phosphene:<color>` (e.g., `phosphene:beryl`)
- Domain: `phosphene:domain:<domain>`
- Instrument: `phosphene:instrument:<instrument>`
- Readiness: `phosphene:ready`

Valid instrument label values:

- `phosphene:instrument:autoscribe`
- `phosphene:instrument:collector`
- `phosphene:instrument:condenser`
- `phosphene:instrument:detector`
- `phosphene:instrument:hopper`
- `phosphene:instrument:modulator`
- `phosphene:instrument:prism`
- `phosphene:instrument:trap`
- `phosphene:instrument:test-emitter`
- `phosphene:instrument:test-listener`

### Inputs (expected)

- Bus lines on `main` that match upstream trigger signals (e.g., `phosphene.merge.research.v1`).
- `workflow_dispatch` inputs (work_id, lane, intent, parent_signal_id) MAY be supported for manual runs.
- Issue prompt template: `.github/prompts/domain_delegation_prompt.md`.

### Outputs (signals / side effects)

- GitHub Issue (flimsie) with canonical `[PHOSPHENE]` block and labels.
- Bus signal: `phosphene.autoscribe.<domain>.issue_created.v1`.
- Dedupe markers in the issue body for idempotency (e.g., `phosphene-signal-id:<parent>`).

### Trigger surface

- MUST trigger on `push` to `main` when `phosphene/signals/bus.jsonl` changes.
- `workflow_dispatch` MAY be supported for manual creation.
- Issue/comment triggers are non-canonical and MUST NOT be relied on.

### Configuration

- MUST read `phosphene/config/<color>.yml` keys: `<domain>.done_score_min` (default 80).
- MUST require `PHOSPHENE_HUMAN_TOKEN` for bus commits.
- MUST enforce write allowlist via `gantry_write_allowlist_guard.sh`.

### Constraints

- MUST be the only instrument permitted to create or mutate issues.
- MUST restrict writes to `phosphene/signals/**` and `phosphene/signals/indexes/**`.
- MUST enforce lane correctness per domain (e.g., product-management = cerulean, product-marketing = beryl).
- MUST emit only the strict `[PHOSPHENE]` schema (no extra keys or reordering).

### Idempotency

- MUST check the bus for an existing `issue_created` signal with `parents` containing the trigger signal id.
- MUST search existing issues for dedupe markers tied to the trigger signal or work_id.
- MUST no-op if a prior issue already exists for the same upstream trigger.

### Failure modes

- Missing `PHOSPHENE_HUMAN_TOKEN` (cannot push bus updates).
- Invalid lane or missing template file.
- Bus tamper hash validation failure.
- GitHub API errors when creating or labeling issues.

### Observability

- GitHub Actions logs and outputs (`issues`, `did_append`).
- Bus commits announcing issue creation.
- Issue contents show the canonical `[PHOSPHENE]` block and dedupe markers.

### Open questions

- Which upstream trigger signals are canonical per domain beyond current use cases?

