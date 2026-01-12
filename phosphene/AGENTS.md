## PHOSPHENE — Agent entrypoint (canonical)

This file is the **first thing an agent should read** when operating inside PHOSPHENE.

PHOSPHENE is a lightweight agentic harness built on a simple premise:
- **GitHub Actions is the scheduler**
- **Agents are workers**
- **The repo is shared memory**
- **PR merge is the officialization point**

If you need the deeper model (state machine + contracts), read:
- `PHOSPHENE_STATE_MACHINE_WORKING.md`


### How to work (agent checklist)

- **Know your primary domain** (exactly one): `<research>`, `<product-marketing>`, etc.
- Read the domain skill (mandatory): `.codex/skills/phosphene/<domain>/SKILL.md`
- Use **control scripts** (don’t hand-edit script-managed artifacts).
- Run the domain validator(s).
- Write a **receipt** at `phosphene/domains/<domain>/DONE.json` (domain root; **not** in subdirectories like `docs/**`).
- Open a PR. Nothing is canonical until merged.

### Repo layout (canonical)

- Domains live under: `phosphene/domains/<domain>/{docs,templates,scripts,signals}/`
- Skills live under: `.codex/skills/phosphene/<domain>/`
- Templates are authoritative under: `phosphene/domains/<domain>/templates/`

### Domains (nine-domain execution model)

Refer to domains using angle brackets:
- `<ideation>` → IDEA
- `<research>` → research-assessment (RA bundles)
- `<product-marketing>` → personas (PER) + propositions (PROP)
- `<product-strategy>` → roadmaps (ROADMAP)
- `<product-management>` → specs (SPEC)
- `<feature-management>` → feature requests (FR)
- `<scrum-management>` → issue mirrors (ISSUE) (optional)
- `<test-management>` → test plans (TP)
- `<retrospective>` → postmortems (PM) + playbooks (PB)

### Receipts vs signals (important)

- `DONE.json` is a **receipt** (completion manifest + hallucination check). It is **not** a signal.
- Receipt location (standard): `phosphene/domains/<domain>/DONE.json` (one per domain run; do not scatter receipts into subfolders).
- Signals are optional add-ons for routing automation:
  - `phosphene/domains/<domain>/signals/**`

### Identity and uniqueness (central tenet)

PHOSPHENE prefers **long, stable natural keys**.

- Top-level artifacts must have stable IDs (e.g. `ID: PER-0003`, `ID: RA-001`).
- Nested objects achieve global uniqueness by concatenating with parent IDs.

Example:
- `JTBD-PAIN-0001-PER-0003`

### Global ID index (repo-wide)

PHOSPHENE maintains a repo-wide ID index at:
- `phosphene/id_index.tsv`

Build / validate / query:

```bash
./phosphene/phosphene-core/bin/phosphene id build
./phosphene/phosphene-core/bin/phosphene id validate
./phosphene/phosphene-core/bin/phosphene id where PER-0003
```

### In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with:

```text
[V-SCRIPT]:
<script_name.sh>
```

Search for `[V-SCRIPT]` inside an artifact to discover the correct control scripts quickly.


