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

- [Define the canonical intent of the hopper.]

### Responsibilities

- [Eligibility checks and start signals.]

### Inputs (expected)

- [Issue updates + PHOSPHENE block.]

### Outputs (signals / side effects)

- [start signals and issue comments.]

### Trigger surface

- [Which events trigger this instrument.]

### Configuration

- [Config keys used, defaults, and overrides.]

### Constraints

- [Comment-only policy, no issue mutation.]

### Idempotency

- [How hopper avoids duplicate starts.]

### Failure modes

- [Known failures and remediation loop entry.]

### Observability

- [Logs, summaries, and artifacts to inspect.]

### Open questions

- [Outstanding decisions or required clarifications.]

