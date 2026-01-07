#!/usr/bin/env bash
#
# Back-compat shim:
# Historically scripts sourced virric_config.sh. The bash-only drop-in uses virric_env.sh.
#
set -euo pipefail

SCRIPT_DIR__VIRRIC_CONFIG_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR__VIRRIC_CONFIG_SH/virric_env.sh"


