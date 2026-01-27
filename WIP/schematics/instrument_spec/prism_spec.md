## PRISM — spec

<table width="100%">
  <tr>
    <td width="340" valign="top">
      <img
        src="https://github.com/user-attachments/assets/dc51bd88-c5bb-4c50-a422-29e928d58230"
        alt="FLORA-Crystal Prism Rendering-75375f03"
        width="340"
      />
    </td>
    <td valign="top">
      The `PRISM` is the dispatcher: it splits and aims branch beams, fanning work out into an execution context without doing the work itself. In practice, that means it issues the minimal execution anchor inside the reactor (for example, a prism-owned branch beam reference and a prism-issued ID), and it issues the summons that starts the apparatus running. If the detector is the judge, the prism is the stage manager: it sets the scene, points the spotlight, and then gets out of the way.
    </td>
  </tr>
</table>

### Purpose

- Dispatch work by creating branch anchors and summoning apparatus.
- Provide a minimal execution context (phos_id + branch name + work_id).

### Responsibilities

- MUST emit `phosphene.prism.<domain>.branch_invoked.v1` to the bus.
- MUST generate `phos_id` using the standard format:
  - `PHOS-<12hex>` where `<12hex>` is the first 12 hex chars of `sha256("<issue_number>:<parent_signal_id>:<intent>")`.
- MUST generate branch name `issue-<number>-<slug>`.
- MUST post summon comment with instructions and required scripts.
- MUST validate lane and domain before dispatching.

### Inputs (expected)

- `phosphene.hopper.<domain>.start.v1` signals (bus).
- Issue metadata (title, labels, PHOSPHENE block).
- Manual `workflow_dispatch` inputs (issue_number, work_id, intent, parent_signal_id).
- `/phosphene <lane> <intent>` comment (global prism).

### Outputs (signals / side effects)

- Bus signals: `phosphene.prism.<domain>.branch_invoked.v1`.
- Issue comments containing `@codex` summons and work instructions.
- Explicit branch name (e.g., `issue-<number>-<slug>`) and phos_id.

### Trigger surface

- MUST trigger on `push` to `main` when bus changes.
- `workflow_dispatch` MAY be supported for manual runs.
- Issue/comment triggers are non-canonical and MUST NOT be relied on.

### Configuration

- MUST require `PHOSPHENE_HUMAN_TOKEN` for bus commits.
- MUST enforce write allowlist via `gantry_write_allowlist_guard.sh`.
- MUST enforce lane-to-domain mapping (beryl/product-marketing, cerulean/product-management).

### Constraints

- MUST write only to `phosphene/signals/**` and `phosphene/signals/indexes/**`.
- MUST NOT perform the work; only dispatches.
- MUST NOT open PRs; human opens PR after branch push.

### Idempotency

- MUST check for an existing `branch_invoked` signal with matching parent signal id.
- MUST no-op if a prior invocation already exists.

### Failure modes

- Missing required inputs (issue_number/work_id/parent_signal_id).
- Invalid lane for the domain (skip with notice).
- Missing `PHOSPHENE_HUMAN_TOKEN` (refuses to write).
- GitHub API errors when posting summon comments.

### Observability

- Issue comment (summon) includes branch name and phos_id.
- Bus commits record `branch_invoked` signals.
- GitHub Actions logs list invoked issues and signal ids.

### Open questions

- Should phos_id format be standardized across all lanes?
- Do we want a reusable library workflow for prism dispatch?

