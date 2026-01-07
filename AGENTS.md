# AGENTS.md (root shim)

This repo uses a **single drop-in folder**: `virric/`.

Read the canonical agent handoff here:

- `virric/AGENTS.md`

Working design note (state machine + contracts):

- `VIRRIC_STATE_MACHINE_WORKING.md`

Optional skills inventory (not all agents support `skill.md`):

- `virric/skill.md`

Quick start (run from repo root):

```bash
./virric/bin/virric banner
./virric/install.sh --project-dir .
./virric/scripts/fr/create_fr.sh --title "..." --description "..." --priority "High"
```


