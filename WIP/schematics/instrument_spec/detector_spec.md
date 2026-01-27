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

- [Define the canonical intent of the detector.]

### Responsibilities

- [List the required checks and rulings.]

### Inputs (expected)

- [Signals, refs, and required metadata.]

### Outputs (signals / side effects)

- [Approve / trap signals; any comments or metadata.]

### Trigger surface

- [Which events trigger this instrument.]

### Configuration

- [Config keys used, defaults, and overrides.]

### Constraints

- [Write boundaries, scope, and safety limits.]

### Idempotency

- [How detector avoids duplicate approvals/traps.]

### Failure modes

- [Known failures and remediation loop entry.]

### Observability

- [Logs, summaries, and artifacts to inspect.]

### Open questions

- [Outstanding decisions or required clarifications.]

