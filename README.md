# VIRRIC (bash-only)

VIRRIC is a **bash-first SDLC control plane**: a repo-native, multi-domain product execution scaffold (docs + contracts) plus deterministic tooling for the **feature-management** domain.

## What’s inside

- `virric/`: the canonical VIRRIC folder (hard requirement: must live at repo root)
- `AGENTS.md`: root shim (points agents at `virric/AGENTS.md`)
- `skill.md`: root shim (points to `virric/skill.md`)
- `VIRRIC_STATE_MACHINE_WORKING.md`: living design note (contracts, PR gating, automation model)

Domain scaffold (canonical):
- `virric/domains/<domain>/{docs,templates,scripts,signals}/`

## Notes

- This build assumes **bash-only** + baseline Unix tools (`awk`, `sed`, `grep`, `find`, `date`).


