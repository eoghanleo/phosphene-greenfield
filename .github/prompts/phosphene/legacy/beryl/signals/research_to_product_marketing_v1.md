# Signal spec (v1): research → product-marketing handoff

This is the **first canonical PHOSPHENE handoff signal**.

It is intended to be **generated as an output of a `<research>` domain run**, committed in the PR, and then **consumed only after PR approval + merge** to trigger the next stage.

## Where it lives

- `phosphene/domains/research/signals/**`

## When it is consumed

On **PR merge** (not PR open) that includes one or more matching signal files.

## Monotonic consumption rule (no mutation)

Signals are **append-only**. PHOSPHENE does not “retire” a signal by editing or moving it.

Instead, a signal is considered **consumed** when it has one or more **child signals** (i.e., any other signal declares it in `parents[]`).

This keeps the state machine monotonic: GitHub Actions can decide what to do next by looking only at the signals present in the repo.

## ID scheme (hash-DAG)

We’re tightening the system by making signal identifiers **hash-derived**.

### Why not MD5?

Even if this isn’t “security,” we still need practical collision resistance for a DAG key. Use **SHA‑256**.

### Required extra fields

- `parents[]`: array of parent `signal_id`s (often 0 or 1)
- `run_marker`: a stable marker from the run that emitted the signal (e.g. `RA-001`, `FR-012`, or a run slug)
- `output_key`: a per-signal discriminator unique within the run (required once a run can emit multiple signals)

### Computation (v1)

Compute a deterministic `parents_root` from the set of parents:

- Sort `parents` lexicographically
- Hash a domain-separated preimage:

\[
\texttt{parents\_root} = \texttt{sha256}("phosphene/parents/v1\\n" + join(sorted(parents), "\\n"))
\]

Then compute the signal ID:

\[
\texttt{signal\_id} = \texttt{sha256}("phosphene/signal/v1\\n" + parents\_root + "\\n" + run\_marker + "\\n" + output\_key)
\]

Represent IDs as:
- `sha256:<hex>`

### Multi-output runs (important)

If a run emits multiple signals, **do not reuse `output_key`**. Common patterns:
- `handoff:research->product-marketing`
- `handoff:research->product-marketing:persona:CPE-0002`
- `handoff:research->product-marketing:prop:PROP-0007`

## File type

- JSON (required)

## Required fields (v1)

```json
{
  "signal_version": 1,
  "signal_id": "sha256:<hex>",
  "signal_type": "phosphene.handoff.research_to_product_marketing.v1",
  "from_domain": "research",
  "to_domain": "product-marketing",
  "work_id": "RA-001",
  "intent": "proposition-development",
  "parents": [],
  "run_marker": "RA-001",
  "output_key": "handoff:research->product-marketing",
  "pointers": [
    "phosphene/domains/research/docs/research-assessments/RA-001-.../RA-001.md"
  ],
  "created_utc": "2026-01-15T00:00:00Z"
}
```

## Optional fields (v1)

- `origin`: provenance metadata (recommended if known; often unavailable at creation time)
- `title`: override for the downstream issue title suffix
- `labels`: array of extra labels to apply to the downstream issue (in addition to PHOSPHENE-required labels)
- `notes`: short human-readable context intended to appear in the downstream issue body

