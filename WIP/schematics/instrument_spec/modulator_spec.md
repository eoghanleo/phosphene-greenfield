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

- Execute domain work inside the reactor and produce canonical artifacts.
- Emit a DONE receipt to register completion and enable verification.

### Responsibilities

- MUST produce domain artifacts using domain control scripts (script-first).
- MUST maintain traceability across upstream IDs and dependencies.
- MUST run domain validators before declaring done.
- MUST emit `phosphene.done.<domain>.receipt.v1` to the JSONL bus (no JSON file DONE receipts).
- MUST commit and push work on the issue-named branch.
- MUST provide CRUD scripts for each output section unless explicitly allowed to hand-write code.

### Inputs (expected)

- Issue intent and `[PHOSPHENE]` block (lane, work_id, work_type).
- Prism summon comment containing branch name, phos_id, and scripts.
- Domain constraints and upstream artifacts (RA, PER/PROP, ROADMAP).
- Parent signal id from `branch_invoked` for DONE receipt linkage.

### Outputs (signals / side effects)

- Domain artifacts under `phosphene/domains/<domain>/output/`.
- DONE receipt signals in `phosphene/signals/bus.jsonl` (JSONL bus only).
- Git commits on the prism-issued branch.

### Trigger surface

- Summoned via prism issue comments (`@codex`).
- Reads domain skill at `.codex/skills/phosphene/<color>/<domain>/modulator/SKILL.md`.

### Configuration

- MUST use script paths under `.codex/skills/phosphene/<color>/<domain>/modulator/scripts/`.
- MUST use shared validators under `.github/scripts/` when available.
- MUST use signal bus append/validate tools (`signal_bus.sh`, `signal_hash.sh`).

### Constraints

- MUST be bash-only for scripts and generated artifacts (no other languages).
- MUST NOT hand-edit script-managed artifacts.
- MUST NOT open PRs; a human opens the PR after branch push.
- MUST emit a valid DONE receipt with tamper hash in `bus.jsonl`.

### Idempotency

- MUST check for existing signal_id before appending DONE receipts.
- Re-runs MUST be safe and produce deterministic IDs.

### Failure modes

- Validator failures MUST block DONE receipt and route to trap remediation.
- Missing parent `branch_invoked` signal MUST block DONE receipt.
- ID resolution failures for upstream dependencies MUST be treated as hard failures.

### Observability

- Signal bus entries for DONE receipts.
- Git commit history on the branch.
- Validator output logs from `.github/scripts/`.

### Open questions

- Should modulators record a summary report in the issue upon completion?

