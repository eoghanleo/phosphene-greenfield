## TEST.EMITTER — spec

`TEST.EMITTER` is a gantry that exists to make the signal pathways observable and regression-testable. It is not part of the “business loop,” but it behaves like a real instrument in miniature: it emits a probe signal so you can prove the bus-triggered orchestration is still alive.

### Purpose

- [Define the canonical intent of test emitter.]

### Responsibilities

- [Emit probe signals for regression tests.]

### Inputs (expected)

- [Manual dispatch or scheduled trigger.]

### Outputs (signals / side effects)

- [Probe signal(s) on the bus.]

### Trigger surface

- [Which events trigger this instrument.]

### Configuration

- [Config keys used, defaults, and overrides.]

### Constraints

- [Write boundaries, scope, and safety limits.]

### Idempotency

- [How emitter avoids duplicate probes.]

### Failure modes

- [Known failures and remediation loop entry.]

### Observability

- [Logs, summaries, and artifacts to inspect.]

### Open questions

- [Outstanding decisions or required clarifications.]

