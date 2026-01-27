## PHOSPHENE config surface (core)

This schematic defines the **configuration surface** used by gantries to read
owner-adjustable thresholds (e.g., done score minimums). Config is read at
runtime by bash-only helpers and never hard-coded inside workflows.

### Files

- `phosphene/config/global.yml` (posture toggles, e.g., prism.create_branch)
- `phosphene/config/<color>.yml` (flat `key: value` pairs)
- `phosphene/phosphene-core/bin/phosphene_config.sh` (bash-only getter)

### Flow (Mermaid)

```mermaid
flowchart LR
  CFG[(phosphene/config/*.yml)]
  AUTOSCRIBE((AUTOSCRIBE))
  DETECTOR((DETECTOR))
  ISSUE[Issue template]
  VALIDATE[Validator commands]

  CFG -->|read done_score_min| AUTOSCRIBE
  CFG -->|read done_score_min| DETECTOR
  CFG -->|read prism.create_branch| PRISM
  AUTOSCRIBE -->|DONE_SCORE_MIN injected| ISSUE
  DETECTOR -->|--min-score <value>| VALIDATE
```

