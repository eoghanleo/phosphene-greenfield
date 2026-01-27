## MODULATOR — spec

<table width="100%">
  <tr>
    <td width="340" valign="top">
      <img
        src="https://github.com/user-attachments/assets/29f372ee-efdc-481b-b6a6-74bbf240ccfb"
        alt="FLORA-Modular Machine Shot-8e5b940d"
        width="340"
      />
    </td>
    <td valign="top">
      The `MODULATOR` is the canonical apparatus shape: the work-configured executor that performs domain tasks under the constraints of the lane and the dossier. It is deliberately described as an instrument rather than a brand-name runtime: the runtime supplier is not hard-wired, and PHOSFLOW conventions explicitly avoid baking a specific supplier into diagrams. The expectation you should carry is simple: modulators shape phos from within; collectors import and refine phos from outside. In both cases, the apparatus emits a completion receipt signal; the receipt is the durable perturbation trace detectors use for verification.
    </td>
  </tr>
</table>

### Purpose

- [Define the canonical intent of the modulator.]

### Responsibilities

- [Produce domain artifacts and emit DONE receipts.]

### Inputs (expected)

- [Issue intent, lane, domain constraints, upstream artifacts.]

### Outputs (signals / side effects)

- [Artifacts, DONE receipts, commits on branch beams.]

### Trigger surface

- [How the modulator is summoned.]

### Configuration

- [Config keys used, defaults, and overrides.]

### Constraints

- [Script-first rules and allowed outputs.]

### Idempotency

- [How modulators avoid duplicate outputs or ensure safe re-runs.]

### Failure modes

- [Known failures and remediation loop entry.]

### Observability

- [Logs, summaries, and artifacts to inspect.]

### Open questions

- [Outstanding decisions or required clarifications.]

