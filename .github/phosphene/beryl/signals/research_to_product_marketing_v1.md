# Signal spec (v1): research → product-marketing handoff

This is the **first canonical PHOSPHENE handoff signal**.

It is intended to be **generated as an output of a `<research>` domain run**, committed in the PR, and then **consumed only after PR approval + merge** to trigger the next stage.

## Where it lives

- `phosphene/domains/research/signals/**`

## When it is consumed

On **PR merge** (not PR open) that includes one or more matching signal files.

## Consumption (deactivation)

After the downstream work completes (typically by merging the PR that closes the handoff Issue), PHOSPHENE should **deactivate** the signal so it cannot be re-consumed.

Canonical mechanism:
- Move the signal file into: `phosphene/domains/research/signals/_consumed/**`
- Consumers must ignore anything under `_consumed/`.

## File type

- JSON (required)

## Required fields (v1)

```json
{
  "signal_version": 1,
  "signal_type": "phosphene.handoff.research_to_product_marketing.v1",
  "from_domain": "research",
  "to_domain": "product-marketing",
  "work_id": "RA-001",
  "intent": "proposition-development",
  "pointers": [
    "phosphene/domains/research/docs/research-assessments/RA-001-.../RA-001.md"
  ],
  "origin": {
    "source": "pull_request",
    "pull_number": 123,
    "pull_title": "Research: RA-001 — ..."
  },
  "created_utc": "2026-01-15T00:00:00Z"
}
```

## Optional fields (v1)

- `title`: override for the downstream issue title suffix
- `labels`: array of extra labels to apply to the downstream issue (in addition to PHOSPHENE-required labels)
- `notes`: short human-readable context intended to appear in the downstream issue body

