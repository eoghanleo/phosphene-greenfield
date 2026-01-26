## PHOSPHENE config

This directory stores **owner-adjustable** settings used by gantries. Each
color has a dedicated YAML file with **flat** `key: value` pairs.

### Files

- `beryl.yml`
- `cerulean.yml`
- `viridian.yml`
- `amaranth.yml`
- `cadmium.yml`
- `chartreuse.yml`

### Format rules (bash-friendly)

- One setting per line: `key: value`
- No nesting
- Comments start with `#`
- Keys are dot-scoped, e.g. `product-marketing.done_score_min`

### Example

```text
product-marketing.done_score_min: 80
```

