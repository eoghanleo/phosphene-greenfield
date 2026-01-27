## CONDENSER — spec

<table width="100%">
  <tr>
    <td width="340" valign="top">
      <img
        src="https://github.com/user-attachments/assets/356f020b-6605-4387-ac2c-bc56ac1da650"
        alt="FLORA-3D Engine Design-ab46daf9"
        width="340"
      />
    </td>
    <td valign="top">
      The `CONDENSER` is the coupler: it turns a green ruling into a coupling approval, confirming checks are green and approving the PR. Condensers do **not** open PRs or merge them; a human opens the PR and merges after approval. The point remains the same: if the work is verified, the condenser issues a deterministic approval so coupling can proceed; if it isn’t, the loop routes back into remediation rather than silently failing.
    </td>
  </tr>
</table>

### Purpose

- Convert verified work into coupling approval by issuing a PR review after checks pass.
- Emit a condenser approval signal to the bus to make coupling explicit.

### Responsibilities

- MUST verify PR state (open, not draft, mergeable_state clean).
- MUST confirm presence of detector APPROVE signals in PR diff.
- MUST emit `phosphene.condenser.<domain>.approve.v1` to the bus (parented to the detector approve signal).
- MUST approve PR via review (`event: APPROVE`) once checks are green and the condenser signal exists.
- MAY request changes for manual trap handling when dispatched.

### Inputs (expected)

- `check_suite.completed` events (success conclusion).
- PR metadata (open/draft/mergeable state).
- Detector approve signals in PR diff (`phosphene.detector.<domain>.approve.v1`).
- `workflow_dispatch` input `pr_number` (manual approval run).

### Outputs (signals / side effects)

- Bus signal: `phosphene.condenser.<domain>.approve.v1`.
- PR review approval by `github-actions[bot]`.
- Optional PR review request changes (global workflow).

### Trigger surface

- MUST trigger on `check_suite.completed` (success) on PRs.
- `workflow_dispatch` MAY be supported for manual approval.
- Reusable `workflow_call` MAY be supported for shared logic.

### Configuration

- MUST be able to write `phosphene/signals/bus.jsonl` (bus signal emit).
- MUST require `PHOSPHENE_HUMAN_TOKEN` for bus commits.
- `pull-requests: write` for reviews.

### Constraints

- MUST NOT open or merge PRs.
- MUST only write to `phosphene/signals/**` and `phosphene/signals/indexes/**`.
- MUST only approve when checks are green and detector APPROVE signal is present.

### Idempotency

- MUST use deterministic signal IDs and skip if the condenser signal already exists in the bus.
- MUST skip if an approval by `github-actions[bot]` already exists.

### Failure modes

- No approve signal present in PR diff (no-op).
- PR is draft/closed or mergeable_state not clean (skip approval).
- Missing PR context in check suite (no-op with notice).
- Missing `PHOSPHENE_HUMAN_TOKEN` (cannot emit bus signal).
- GitHub API error when creating review.

### Observability

- PR review body: `PHOSPHENE: condenser approval (checks green).`
- GitHub Actions logs record skip reasons and approval status.

### Open questions

- Do we need explicit handling for check failures beyond skip/no-op?

