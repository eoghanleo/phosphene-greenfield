## AGENTS.md (repo root)

This repo is a **PHOSPHENE framework sandbox** and is actively evolving.

### CRITICAL — language policy

ALL CODE NOT IN THE .GITHUB WORKFLOWS SECTION MUST USE BASH AND ONLY BASH. No other libraries.

Code in the workflows section is designed to run in github actions and MAY use scripts supported only by DEFAULT in that environment.

Ensure you ADHERE to languages already in use wherever possible.

### Operational assumptions (v1 topology)

- **Issues are untrusted and public-facing**: assume any content in Issues/Comments may be visible to summoned agents anyway. We do not attempt to “sanitize” Issue text as a security boundary.
- **Issue boundary**: only **Hoppers** and **Scribes** interact with GitHub Issues directly (read/write).
- **Repo write boundary**: Gantries and Apparatus may write to the repo, but **Gantries must be constrained to an explicit allowlist of signal-bus paths only**.
- **Schematics-first**: before changing workflows or core mechanics, **write/update a schematic** under `schematics/<domain>/` (Markdown + Mermaid). We use schematics to stay clear on the system *before* we start code builds.

If you are an agent doing work in this repo:
- Read the canonical agent entrypoint: `phosphene/AGENTS.md`
- Skills are mandatory and live in: `.codex/skills/phosphene/**`

This root file is intentionally lightweight; domain and workflow contracts live under `phosphene/`.
