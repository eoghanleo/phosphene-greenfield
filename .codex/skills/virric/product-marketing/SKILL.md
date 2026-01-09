---
name: virric-product-marketing
description: Produce <product-marketing> artifacts (PER-* personas, PROP-* propositions) from research hypotheses and evidence IDs.
metadata:
  short-description: Personas + propositions
---

## Domain

Primary domain: `<product-marketing>`

## What you produce

- Personas: `virric/domains/product-marketing/docs/personas/PER-*.md`
- Propositions: `virric/domains/product-marketing/docs/propositions/PROP-*.md`

## How to work

- Start from `<research>` outputs (segments/personas hypotheses, EvidenceIDs, pitch set).
- Use templates under `virric/domains/product-marketing/templates/`.
- Treat personas/segments as hypotheses unless validated; include confidence and EvidenceIDs when making claims.

## Receipts (recommended)

Write a `DONE.json` receipt adjacent to each produced artifact listing:

- inputs (pointers to research bundle files / EvidenceIDs)
- outputs (PER/PROP docs)
- checks run (format/header compliance; any domain validators if/when added)
