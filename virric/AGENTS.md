## VIRRIC — Agent entrypoint (canonical)

This file is the **first thing an agent should read** when operating inside VIRRIC.

VIRRIC is a lightweight agentic harness built on a simple premise:
- **GitHub Actions is the scheduler**
- **Agents are workers**
- **The repo is shared memory**
- **PR merge is the officialization point**

If you need the deeper model (state machine + contracts), read:
- `VIRRIC_STATE_MACHINE_WORKING.md`


### How to work (agent checklist)

- **Know your primary domain** (exactly one): `<research>`, `<product-marketing>`, etc.
- Read the domain skill (mandatory): `.codex/skills/virric/<domain>/SKILL.md`
- Use **control scripts** (don’t hand-edit script-managed artifacts).
- Run the domain validator(s).
- Write a **receipt** (`DONE.json`) next to the artifact you produced.
- Open a PR. Nothing is canonical until merged.

### Repo layout (canonical)

- Domains live under: `virric/domains/<domain>/{docs,templates,scripts,signals}/`
- Skills live under: `.codex/skills/virric/<domain>/`
- Templates are authoritative under: `virric/domains/<domain>/templates/`

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
- Signals are optional add-ons for routing automation:
  - `virric/domains/<domain>/signals/**`

### Identity and uniqueness (central tenet)

VIRRIC prefers **long, stable natural keys**.

- Top-level artifacts must have stable IDs (e.g. `ID: PER-0003`, `ID: RA-001`).
- Nested objects achieve global uniqueness by concatenating with parent IDs.

Example:
- `JTBD-PAIN-0001-PER-0003`

### Global ID index (repo-wide)

VIRRIC maintains a repo-wide ID index at:
- `virric/id_index.tsv`

Build / validate / query:

```bash
./virric/domains/research/scripts/research_id_registry.sh build
./virric/domains/research/scripts/research_id_registry.sh validate
./virric/domains/research/scripts/research_id_registry.sh where PER-0003
```

### In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with:

```text
[V-SCRIPT]:
<script_name.sh>
```

Search for `[V-SCRIPT]` inside an artifact to discover the correct control scripts quickly.


