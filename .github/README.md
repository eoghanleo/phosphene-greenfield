# `.github/` (PHOSPHENE)

This folder contains **automation + delegation surfaces** for the PHOSPHENE repo.

## Structure

- **`workflows/`**: GitHub Actions workflows (must live directly under `.github/workflows/`).
- **`prompts/`**: Parameterized prompt templates used by workflows when delegating work to agents.

## Naming conventions

Workflows are organized by a taxonomy encoded in the filename:

- **`instrument.gantry.detector.<domain>.<action>.yml`**: deterministic checks (no repo writes)
- **`instrument.gantry.prism.<domain>.<action>.yml`**: dispatch/fanout/summon (no repo writes)
- **`instrument.gantry.condenser.<domain>.<action>.yml`**: coupling authorization / rulings (no repo writes)
- **`instrument.apparatus.<type>.<domain>.<action>.yml`**: summons an agent-run apparatus (never “does the work” itself)
- **`spool.tangle.<action>.yml`**: spooling/release actions
- **`safety.<action>.yml`**: emergency venting / eject paths
- **`lib.*.yml`**: reusable workflow_call building blocks

See `.github/workflows/README.md` for details.

