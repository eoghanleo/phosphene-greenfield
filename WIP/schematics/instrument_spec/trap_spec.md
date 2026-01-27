## TRAP — spec

<table width="100%">
  <tr>
    <td width="340" valign="top">
      <img
        src="https://github.com/user-attachments/assets/28ee172d-7967-4bea-b85e-a8460c901a86"
        alt="FLORA-Containment Snare Design-66a7e5a1"
        width="340"
      />
    </td>
    <td valign="top">
      The `TRAP` is the error-loop switchboard. It listens for trap signals (for example, “verification failed” or “checks failed”) and converts them into a targeted remediation prompt attached to the work’s public record (typically as a flimsie comment that includes the worker summon). The trap’s value is that it keeps failure handling dynamic without smearing ad-hoc error logic across every other instrument: detectors and condensers simply emit reasons; trap turns those reasons into a next action that routes the loop back toward stable containment, and a clear instruction to re-emit a fresh completion receipt when fixed.
    </td>
  </tr>
</table>

### Purpose

- [Define the canonical intent of the trap.]

### Responsibilities

- [Remediation loop creation and guidance.]

### Inputs (expected)

- [trap signals + reasons.]

### Outputs (signals / side effects)

- [Issue comments; optional rework summons.]

### Trigger surface

- [Which events trigger this instrument.]

### Configuration

- [Config keys used, defaults, and overrides.]

### Constraints

- [Comment-only policy, no issue mutation.]

### Idempotency

- [How trap avoids duplicate remediation posts.]

### Failure modes

- [Known failures and remediation loop entry.]

### Observability

- [Logs, summaries, and artifacts to inspect.]

### Open questions

- [Outstanding decisions or required clarifications.]

