#!/usr/bin/env bash
set -euo pipefail

# Back-compat wrapper.
#
# The VIRRIC ID registry is global and lives in:
#   ./virric/virric-core/bin/id_registry.sh
#   ./virric/virric-core/bin/virric id ...
#
# This wrapper exists so older docs/scripts keep working.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../virric-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/virric_env.sh"

ROOT="$(virric_find_project_root)"
exec "$ROOT/virric/virric-core/bin/virric" id "$@"

