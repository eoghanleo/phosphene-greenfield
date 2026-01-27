## TEST.LISTENER — spec

`TEST.LISTENER` is a gantry that exists to make the signal pathways observable and regression-testable. It is not part of the “business loop,” but it behaves like a real instrument in miniature: it listens for probe signals and reacts so you can prove the bus-triggered orchestration is still alive.

### Purpose

- Confirm workflow triggers by reacting to probe file changes.
- Provide a read-only regression observer for the orchestration substrate.

### Responsibilities

- MUST listen for probe file updates and log trigger context.
- MUST avoid any repo writes (read-only observer).

### Inputs (expected)

- `push` events to `main` that modify `phosphene/signals/indexes/workflow_trigger_probe.txt`.

### Outputs (signals / side effects)

- Console logs with trigger metadata (`actor`, `ref`, `sha`).
- No bus signals or file changes.

### Trigger surface

- MUST trigger on `push` to `main` with path filter on the probe file.

### Configuration

- No configuration required.

### Constraints

- MUST be read-only: no repo writes or issue mutations.

### Idempotency

- Idempotent by design (logs only, no state mutation).

### Failure modes

- Workflow execution failure (no side effects).
- Missing context variables (unlikely).

### Observability

- GitHub Actions logs with trigger context.
- Workflow run history.

### Open questions

- Should the listener emit a lightweight bus acknowledgment signal?

