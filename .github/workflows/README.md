# `.github/workflows/` (PHOSPHENE)

GitHub Actions requires workflow YAML files to live **directly** in `.github/workflows/` (no subdirectories).

## Taxonomy (filename is the contract)

### Gantry instruments (no repo writes)

- **Detectors**: `instrument.gantry.detector.<domain>.<action>.yml`
  - Deterministic ruling corridors: evaluate a ref/branch (PR branches and/or `main`) against a set of **predicates**.
  - Predicates may be:
    - **Static** (baked into the workflow; e.g. run tests, validate schema), or
    - **Runtime-supplied** (e.g. `workflow_dispatch` inputs providing additional predicates/commands).
  - A detector emits a ruling (pass/fail) and **may** trigger follow-on instruments/apparatus, e.g.:
    - Call a **Condenser** to authorize coupling when green.
    - Trigger **rework** by summoning a **Modulator** with defect context, then re-evaluate.
- **Prisms**: `instrument.gantry.prism.<domain>.<action>.yml`
  - Dispatch/fanout into apparatus runs (summons agents; does not do work itself).
- **Condensers**: `instrument.gantry.condenser.<domain>.<action>.yml`
  - Coupling authorization / rejection decisions (approve/label/auto-merge enable); still **no commits**.

### Apparatus (agent-run; summoned only)

`instrument.apparatus.{collector|modulator|trap}.<domain>.<action>.yml`

These workflows **only summon** the worker (Codex agent) with the right constraints and pointers.

### Spooling / safety

- **Spooling**: `spool.tangle.<action>.yml`
- **Safety**: `safety.<action>.yml`

### Library (reusable building blocks)

`lib.*.yml` are reusable `workflow_call` wrappers to keep implementation consistent across instruments/apparatus.

## Editing rules

- Prefer adding new behaviors by creating a new workflow file that matches the taxonomy.
- Prefer shared logic in `lib.*.yml`.

