#!/usr/bin/env bash
set -euo pipefail

# Skill wrapper: delegates to the canonical VIRRIC domain script in this repo.
# This keeps the skill self-contained (predictable entrypoints) while preserving
# a single source of truth for the implementation.

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../../../" && pwd)"
ASSETS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../assets" && pwd)"

export VIRRIC_SKILL_ASSETS_DIR="$ASSETS_DIR"

cd "$ROOT"

exec "$ROOT/virric/domains/feature-management/scripts/validate_feature_request.sh" "$@"
