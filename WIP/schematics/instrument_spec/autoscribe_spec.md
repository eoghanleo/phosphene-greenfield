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

- [Define the canonical intent of the autoscribe.]

### Responsibilities

- [Issue creation, canonical PHOSPHENE block, labels.]

### Inputs (expected)

- [Signals that request flimsie creation.]

### Outputs (signals / side effects)

- [Issue creation, issue_created signals.]

### Trigger surface

- [Which events trigger this instrument.]

### Configuration

- [Config keys used, defaults, and overrides.]

### Constraints

- [Only instrument that mutates issues.]

### Idempotency

- [How autoscribe avoids duplicate issues.]

### Failure modes

- [Known failures and remediation loop entry.]

### Observability

- [Logs, summaries, and artifacts to inspect.]

### Open questions

- [Outstanding decisions or required clarifications.]

