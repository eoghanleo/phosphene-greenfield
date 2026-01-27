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

- [Define the canonical intent of the condenser.]

### Responsibilities

- [Approve coupling when checks and approvals are satisfied.]

### Inputs (expected)

- [Approve signals, PR state, checks context.]

### Outputs (signals / side effects)

- [PR reviews, optional rejection comments.]

### Trigger surface

- [Which events trigger this instrument.]

### Configuration

- [Config keys used, defaults, and overrides.]

### Constraints

- [No PR creation/merge; no repo writes.]

### Idempotency

- [How condenser avoids duplicate approvals.]

### Failure modes

- [Known failures and remediation loop entry.]

### Observability

- [Logs, summaries, and artifacts to inspect.]

### Open questions

- [Outstanding decisions or required clarifications.]

