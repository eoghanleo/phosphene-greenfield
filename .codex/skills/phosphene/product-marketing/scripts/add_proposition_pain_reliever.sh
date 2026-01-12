#!/usr/bin/env bash
set -euo pipefail

# Skill wrapper: delegates to the canonical PHOSPHENE domain script in this repo.

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../../../" && pwd)"
ASSETS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../assets" && pwd)"

export PHOSPHENE_SKILL_ASSETS_DIR="$ASSETS_DIR"

cd "$ROOT"

exec "$ROOT/phosphene/domains/product-marketing/scripts/add_proposition_pain_reliever.sh" "$@"

