## AGENTS.md (repo root)

This repo is a **PHOSPHENE framework sandbox** and is actively evolving.

### CRITICAL — language policy

ALL CODE NOT IN THE .GITHUB WORKFLOWS SECTION MUST USE BASH AND ONLY BASH. No other libraries.

Code in the workflows section is designed to run in github actions and MAY use scripts supported only by DEFAULT in that environment.

Ensure you ADHERE to languages already in use wherever possible.

If you are an agent doing work in this repo:
- Read the canonical agent entrypoint: `phosphene/AGENTS.md`
- Skills are mandatory and live in: `.codex/skills/phosphene/**`

This root file is intentionally lightweight; domain and workflow contracts live under `phosphene/`.
