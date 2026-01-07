# VIRRIC Migration Payload (bash-only)

This folder is a **self-contained migration payload** for the “new build” of VIRRIC.

## What’s inside

- `virric/`: the bash-only VIRRIC drop-in folder (scripts + neon CLI)
- `AGENTS.md`: root shim (points agents at `virric/AGENTS.md`)
- `skill.md`: root shim (points to `virric/skill.md`)
- `VIRRIC_STATE_MACHINE_WORKING.md`: living design note (typed Issues, labels contract, repo mirroring)
- Domain scaffold (repo-native artifacts + templates):
  - `ideation/`
  - `research/`
  - `product-marketing/`
  - `product-strategy/`
  - `product-management/`
  - `feature-management/`
  - `scrum-management/`
  - `test-management/`
  - `retrospective/`

## How to adopt into a target repo

From the target repo root, copy in:

- `virric_migration/virric/` → `./virric/`
- `virric_migration/AGENTS.md` → `./AGENTS.md`
- `virric_migration/skill.md` → `./skill.md`
- `virric_migration/VIRRIC_STATE_MACHINE_WORKING.md` → `./VIRRIC_STATE_MACHINE_WORKING.md`
- Domain scaffold folders (recommended):
  - `virric_migration/ideation/` → `./ideation/`
  - `virric_migration/research/` → `./research/`
  - `virric_migration/product-marketing/` → `./product-marketing/`
  - `virric_migration/product-strategy/` → `./product-strategy/`
  - `virric_migration/product-management/` → `./product-management/`
  - `virric_migration/feature-management/` → `./feature-management/`
  - `virric_migration/scrum-management/` → `./scrum-management/`
  - `virric_migration/test-management/` → `./test-management/`
  - `virric_migration/retrospective/` → `./retrospective/`

Then run:

```bash
./virric/bin/virric banner
./virric/install.sh --project-dir .
./virric/scripts/fr/create_fr.sh --title "..." --description "..." --priority "High"
```

## Notes

- This payload intentionally excludes legacy folders like `virric-sdlc-framework/`.
- This build assumes **bash-only** + baseline Unix tools (`awk`, `sed`, `grep`, `find`, `date`).


