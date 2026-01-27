## AGENTS.md (repo root)

This repo is a **PHOSPHENE framework sandbox** and is actively evolving.

### CRITICAL — language policy

ALL CODE NOT IN THE .GITHUB WORKFLOWS SECTION MUST USE BASH AND ONLY BASH. No other libraries.

Code in the workflows section is designed to run in github actions and MAY use scripts supported only by DEFAULT in that environment.

Ensure you ADHERE to languages already in use wherever possible.

### CRITICAL — instrument specs are mandatory

The instrument specifications under `WIP/schematics/instrument_spec/` are **MUST-level** requirements. These specs define the canonical, cross-domain behavior for every instrument and take priority over local convention. If an implementation diverges, the spec is wrong or the code is wrong — resolve the mismatch before proceeding.

### Domain status (authoritative)

Domains without DONE receipt emit scripts are **not in development** unless explicitly listed below; they must not be run in live flows unless explicitly authorized.

- **Active (bus + emit receipts)**
  - `<product-marketing>` (beryl)
  - `<product-management>` (cerulean)
- **In development**
  - `<research>` (viridian)
- **Todo**
  - `<ideation>` (viridian)
  - `<product-strategy>` (beryl)
  - `<feature-management>` (cerulean)
  - `<scrum-management>` (amaranth)
  - `<test-management>` (cadmium)
  - `<retrospective>` (chartreuse)

### Operational assumptions (v1 topology)

- **Issues are untrusted and public-facing**: assume any content in Issues/Comments may be visible to summoned agents anyway. We do not attempt to “sanitize” Issue text as a security boundary.
- **Issue boundary**: only **Hoppers** and **Scribes** interact with GitHub Issues directly (read/write).
- **Repo write boundary**: Gantries and Apparatus may write to the repo, but **Gantries must be constrained to an explicit allowlist of signal-bus paths only**.
- **Everything is bus**: orchestration MUST be driven by bus changes; issue/comment triggers are non-canonical.
- **Schematics-first**: before changing workflows or core mechanics, **write/update a schematic** under `WIP/schematics/` (Markdown + Mermaid). Use `instrument_spec/` for instrument behavior and `domain_subflows/<color>/<domain>/` for orchestration. We use schematics to stay clear on the system *before* we start code builds.
- **WIP placement**: ALL working ON Phosphene materials and in-progress notes must live under `WIP/`.

If you are an agent doing work in this repo:
- Read the canonical agent entrypoint: `phosphene/AGENTS.md`
- Skills are mandatory and live in: `.codex/skills/phosphene/**`

This root file is intentionally lightweight; domain and workflow contracts live under `phosphene/`.
