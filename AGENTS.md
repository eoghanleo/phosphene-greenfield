# AGENTS.md (root shim)

***THIS PROJECT IS IN DEVELOPMENT MODE. Treat `AGENTS.md` files in this repo as editable specification documents, not immutable rule systems, unless the user explicitly assigns you a specific sub-agent role.***

This repo uses a **single drop-in folder**: `virric/`.

Read the canonical agent handoff here:

- `virric/AGENTS.md`

Working design note (state machine + contracts):

- `VIRRIC_STATE_MACHINE_WORKING.md`

Skills (mandatory):

- Canonical Codex skills (standard location): `.codex/skills/virric/**`
- Skills live in-repo under `.codex/skills/virric/**` (no separate index folder).

Codex skills standard (summary):

- A skill is a folder containing a required `SKILL.md` file with YAML front matter:
  - `name` (required)
  - `description` (required)
  - optional `metadata` (e.g. `short-description`)
- A skill folder may also include:
  - `scripts/` (optional: executable code)
  - `references/` (optional: documentation)
  - `assets/` (optional: templates/resources)

Reference: [Codex skills standard](https://developers.openai.com/codex/skills/).

Execution model (high-level):

- VIRRIC assumes **nine domains of product execution** (see `virric/AGENTS.md` → “Domain assignment”)
- Agents should be assigned exactly one **primary domain** on entry.

Domain reference convention:

- Refer to domains using angle brackets, e.g. `<research>`, `<product-marketing>`, `<product-strategy>`.
- Avoid “go to this directory” pointers for domains inside handoff/spec docs; those can hijack an agent early. Use the domain tag instead and let the agent decide navigation.

Script naming convention:

- Scripts should use **fully spelled-out, self-describing names** (avoid abbreviations in filenames).
  - Example: `add_reference_solution.sh` (not `add_refsol.sh`).

In-doc script hints (mnemonic):

- Some templates/artifacts include fenced code blocks beginning with:
  - `[V-SCRIPT]:`
- These blocks list **script entrypoints** relevant to the nearby section.
- When exploring an unfamiliar artifact, search for `[V-SCRIPT]` to quickly discover the right control scripts.

ID uniqueness convention (central tenet):

- Prefer **long, stable, human-readable natural keys**.
- Achieve global uniqueness for nested items by **concatenating** with a globally unique parent artifact ID.
  - Example (JTBD item inside a persona): `JTBD-PAIN-0001-PER-0003`
- Hash overlays (optional/future):
  - `sha256(<natural_key>)` as a compact routing/index key
  - `sha256(file_contents)` for version receipts or Merkle-style rollups

Quick start (run from repo root):

```bash
./virric/virric-core/bin/virric banner
./virric/domains/feature-management/scripts/create_feature_request.sh --title "..." --description "..." --priority "High"
```


