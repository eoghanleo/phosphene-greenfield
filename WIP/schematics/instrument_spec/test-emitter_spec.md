## TEST.EMITTER — spec

`TEST.EMITTER` is a gantry that exists to make the signal pathways observable and regression-testable. It is not part of the “business loop,” but it behaves like a real instrument in miniature: it emits a probe signal so you can prove the bus-triggered orchestration is still alive.

### Purpose

- Emit probe changes to validate workflow triggering and signal paths.
- Provide a regression harness independent of business flows.

### Responsibilities

- MUST update the probe file to trigger the listener workflow.
- MUST commit and push the probe update under controlled write boundaries.
- MUST use the exact commit message: `chore(test): workflow trigger probe`.

### Inputs (expected)

- `workflow_dispatch` with optional auth mode (`github_token` or `human_token`).

### Outputs (signals / side effects)

- Updates `phosphene/signals/indexes/workflow_trigger_probe.txt` with UTC timestamp.
- Git commit labeled `chore(test): workflow trigger probe`.

### Trigger surface

- MUST be `workflow_dispatch` only (manual).

### Configuration

- MUST require `PHOSPHENE_HUMAN_TOKEN` when using `human_token` auth.
- MUST enforce write allowlist via `gantry_write_allowlist_guard.sh`.

### Constraints

- MUST limit write boundary to `phosphene/signals/indexes/workflow_trigger_probe.txt`.
- MUST remain outside the domain bus (file-based probe only).

### Idempotency

- Not idempotent by design (each run writes a new timestamp).

### Failure modes

- Missing `PHOSPHENE_HUMAN_TOKEN` when `human_token` is selected.
- Write allowlist violation.
- Git push failures.

### Observability

- Workflow logs and commit history.
- Probe file contents (latest timestamp).

### Open questions

- Do we want a JSONL probe signal in the bus instead of file-based probes?

