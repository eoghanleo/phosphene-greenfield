# VIRRIC Migration Payload (bash-only)

This folder is a **self-contained migration payload** for the “new build” of VIRRIC.

## What’s inside

- `virric/`: the bash-only VIRRIC drop-in folder (scripts + neon CLI)
- `AGENTS.md`: root shim (points agents at `virric/AGENTS.md`)
- `skill.md`: root shim (points to `virric/skill.md`)
- `VIRRIC_STATE_MACHINE_WORKING.md`: living design note (typed Issues, labels contract, repo mirroring)
- Domain scaffold (repo-native artifacts + templates):
  - `virric/domains/ideation/`
  - `virric/domains/research/`
  - `virric/domains/product-marketing/`
  - `virric/domains/product-strategy/`
  - `virric/domains/product-management/`
  - `virric/domains/feature-management/`
  - `virric/domains/scrum-management/`
  - `virric/domains/test-management/`
  - `virric/domains/retrospective/`

## How to adopt into a target repo

From the target repo root, copy in:

- `virric_migration/virric/` → `./virric/`
- `virric_migration/AGENTS.md` → `./AGENTS.md`
- `virric_migration/skill.md` → `./skill.md`
- `virric_migration/VIRRIC_STATE_MACHINE_WORKING.md` → `./VIRRIC_STATE_MACHINE_WORKING.md`
- Domain scaffold folders are included under `virric/domains/` inside the drop-in.

Then run:

```bash
./virric/bin/virric banner
./virric/install.sh --project-dir .
./virric/scripts/fr/create_fr.sh --title "..." --description "..." --priority "High"
```

## Notes

- This payload intentionally excludes legacy folders like `virric-sdlc-framework/`.
- This build assumes **bash-only** + baseline Unix tools (`awk`, `sed`, `grep`, `find`, `date`).


