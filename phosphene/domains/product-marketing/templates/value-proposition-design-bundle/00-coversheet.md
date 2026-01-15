ID: {{ID}}
Title: {{TITLE}}
Status: Draft
Priority: {{PRIORITY}}
Updated: {{UPDATED}}
Dependencies:
Owner: {{OWNER}}
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/product-marketing/SKILL.md)

## Purpose (read first)

This is a **Value Proposition Design (VPD)** bundle: the WTBD parent for `<product-marketing>`.

It exists to make persona + proposition work:
- scoped (what are we working on right now?)
- traceable (what did this depend on?)
- composable (downstream domains can consume a VPD as a coherent unit)

## Inputs

List upstream context that seeded this VPD:
- Research IDs (RA / PITCH / E / CPE / etc)
- Prior VPDs (if this is a refinement)
- Any other relevant IDs

## Outputs (children of this VPD)

This VPD should produce:
- Personas: `PER-####` (must list `Dependencies: {{ID}}` in the persona header)
- Propositions: `PROP-####` (must list `Dependencies: {{ID}}` in the proposition header)

## Notes

- Use scripts. Avoid hand-editing artifacts.
- When in doubt, create more propositions than you think you need.

