# AGENTS.md (root shim)

This repo uses a **single drop-in folder**: `virric/`.

Read the canonical agent handoff here:

- `virric/AGENTS.md`

Working design note (state machine + contracts):

- `VIRRIC_STATE_MACHINE_WORKING.md`

Optional skills inventory (not all agents support `skill.md`):

- `virric/skill.md`

Execution model (high-level):

- VIRRIC assumes **nine domains of product execution** (see `virric/AGENTS.md` → “Domain assignment”)
- Agents should be assigned exactly one **primary domain** on entry.

Quick start (run from repo root):

```bash
./virric/bin/virric banner
./virric/domains/feature-management/scripts/create_fr.sh --title "..." --description "..." --priority "High"
```


