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

- Convert trap signals into explicit remediation prompts on the issue.
- Keep error-loop handling centralized and deterministic.

### Responsibilities

- MUST detect new `phosphene.detector.<domain>.trap.v1` signals in bus diffs.
- MUST post a remediation comment using the standard template (no domain-specific format drift).
- MUST require a fresh DONE receipt after fixes.
- MUST avoid duplicate remediation posts for the same trap signal.

### Inputs (expected)

- Bus diffs containing trap signals and `reason` fields.
- PR or push events that include `phosphene/signals/bus.jsonl` changes.
- Manual `workflow_dispatch` inputs (if invoked by hand).

### Outputs (signals / side effects)

- Issue comments containing remediation instructions and `@codex` summon.
- No bus signals emitted (read-only gantry).

### Trigger surface

- `pull_request` (opened/synchronize/reopened) with bus diffs.
- `push` to `main` with bus changes.
- `workflow_dispatch`.

### Configuration

- Domain-specific remediation steps are embedded in the workflow.
- Read-only permissions (no bus or artifact writes).

### Constraints

- MUST be comment-only (no issue edits or label changes).
- MUST only process trap signals for its domain.

### Idempotency

- MUST check for a comment marker `PHOSPHENE-TRAP:signal_id:<trap_signal_id>`.
- MUST no-op if a marker already exists.

### Failure modes

- Missing issue_number or trap_signal_id in the trap payload (skip).
- No trap signals found in diff (no-op).
- GitHub API error when posting a comment.

### Observability

- Issue comments include work_id, reason, trap_signal_id, and required actions.
- GitHub Actions logs indicate processed vs skipped signals.

### Open questions

- Should traps emit follow-on bus signals when remediation is posted?

