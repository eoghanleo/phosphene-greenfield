#!/usr/bin/env bash
set -euo pipefail

# Skill wrapper: delegates to the canonical VIRRIC domain script in this repo.

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../../../" && pwd)"
ASSETS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../assets" && pwd)"

export VIRRIC_SKILL_ASSETS_DIR="$ASSETS_DIR"

cd "$ROOT"

exec "$ROOT/virric/domains/product-marketing/scripts/create_new_persona.sh" "$@"

