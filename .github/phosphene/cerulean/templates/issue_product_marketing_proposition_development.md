<!--
Template: product-marketing proposition development issue (hard-coded for this signal type).
Placeholders are replaced by GitHub Actions.
-->

@codex take issue.

PHOSPHENE handoff detected: **`<research>` → `<product-marketing>`**

## Context

- **Upstream PR**: #{{UPSTREAM_PR_NUMBER}} — {{UPSTREAM_PR_TITLE}}
- **Upstream PR URL**: {{UPSTREAM_PR_URL}}
- **Research work_id**: {{RESEARCH_WORK_ID}}
- **Signal**: `{{SIGNAL_PATH}}`

{{NOTES_BLOCK}}

## Inputs (from research)

{{POINTERS_BULLETS}}

## What to do (product-marketing)

Create proposition development outputs that are continuous with the upstream research.

Constraints:
- Single primary domain: `<product-marketing>`
- Read `phosphene/phosphene/AGENTS.md`
- Prefer PHOSPHENE control scripts under `phosphene/domains/product-marketing/scripts/` when applicable
- Validate + update IDs as appropriate (`./phosphene/phosphene-core/bin/phosphene id validate`)
- Write receipt: `phosphene/domains/product-marketing/DONE.json` (domain root; not under `docs/**`)

## Definition of done

- Outputs committed in a PR linked to this issue
- Receipt exists (`DONE.json`) and is honest about what was/wasn’t validated

<!-- {{PHOSPHENE_DEDUPE_MARKER}} -->

