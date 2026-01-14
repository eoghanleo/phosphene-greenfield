# PHOSPHENE GitHub automation (no API keys)

This repo’s goal is to work with the **consumer Codex GitHub integration** (cloud agent) by generating **`@codex` mentions** from deterministic repo events.

Key idea:
- GitHub Actions = scheduler
- `@codex` GitHub integration = worker (cloud agent)
- Repo = shared memory

No `OPENAI_API_KEY` is used here.

## Color → domain mapping

- **Beryl** → `phosphene/domains/research/`
- **Cerulean** → `phosphene/domains/product-marketing/`

## How to trigger work

### 1) Signals (recommended)

Add/modify a signal file under:
- `phosphene/domains/research/signals/**` (Beryl)
- `phosphene/domains/product-marketing/signals/**` (Cerulean)

On PRs that change these paths, the relevant workflow will post a comment that mentions `@codex` and points it at the signals.

### 2) Manual summon via comment

On an issue or PR, comment one of:
- `/phosphene beryl <intent>`
- `/phosphene cerulean <intent>`

The workflow will reply with an `@codex` mention containing the intent and relevant conventions.

