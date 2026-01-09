## Skills (human index)

Agent Skills are folders of instructions, scripts, and resources that AI agents can discover and use to perform specific tasks.
Write once, use everywhere.

This repo follows the Codex skills standard:

- A skill is a folder containing a required `SKILL.md` (with YAML front matter) plus optional `scripts/`, `references/`, and `assets/`.
- In a working repo, Codex loads repo-scoped skills from `.codex/skills/**`.

References:
- Codex skills standard: [`https://developers.openai.com/codex/skills/`](https://developers.openai.com/codex/skills/)
- Example skills library repo: [`https://github.com/openai/skills/tree/main/skills`](https://github.com/openai/skills/tree/main/skills)

### Canonical location in this repo

**Canonical (Codex-loaded) skills live under**:

- `.codex/skills/**`

We keep this `skills/` folder as a **human-friendly index** (similar to the public skills library layout) without duplicating the canonical skill definitions.

### How Codex discovers and uses skills (quick notes)

- Codex can use skills by explicit invocation (e.g. selecting a skill) or implicit invocation (matching the skill description).
- Codex includes some built-in “system” skills, and supports installing additional skills.
- In this repo, the skills are already checked in under `.codex/skills/**`, so “install” is not required when working inside this repo.

See the Codex docs for details: [`https://developers.openai.com/codex/skills/`](https://developers.openai.com/codex/skills/).

### Installing skills (when you want to import skills into another environment)

Codex supports installing skills via `$skill-installer` (curated and experimental) and by providing a GitHub directory URL.

The public library repo is a good reference for how skills are packaged and cataloged:
[`https://github.com/openai/skills/tree/main/skills`](https://github.com/openai/skills/tree/main/skills).

### Licensing convention (optional)

The public skills library documents a per-skill license convention: a skill may include a `LICENSE.txt` inside its directory.

In this repo, we treat per-skill licensing as **optional** unless/until we introduce a specific licensing policy.

### VIRRIC skills

- **Core harness**: `.codex/skills/virric-core/SKILL.md`
- **<ideation>**: `.codex/skills/virric-ideation/SKILL.md`
- **<research>**: `.codex/skills/virric-research/SKILL.md`
- **<product-marketing>**: `.codex/skills/virric-product-marketing/SKILL.md`
- **<product-strategy>**: `.codex/skills/virric-product-strategy/SKILL.md`
- **<product-management>**: `.codex/skills/virric-product-management/SKILL.md`
- **<feature-management>**: `.codex/skills/virric-feature-management/SKILL.md`
- **<scrum-management>**: `.codex/skills/virric-scrum-management/SKILL.md`
- **<test-management>**: `.codex/skills/virric-test-management/SKILL.md`
- **<retrospective>**: `.codex/skills/virric-retrospective/SKILL.md`

