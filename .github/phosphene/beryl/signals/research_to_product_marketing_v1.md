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

## File type

- JSON (required)

## Required fields (v1)

```json
{
  "signal_version": 1,
  "signal_id": "SIG-RA-001-research_to_product_marketing-v1",
  "signal_type": "phosphene.handoff.research_to_product_marketing.v1",
  "from_domain": "research",
  "to_domain": "product-marketing",
  "work_id": "RA-001",
  "intent": "proposition-development",
  "parents": [],
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

