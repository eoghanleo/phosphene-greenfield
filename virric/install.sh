#!/usr/bin/env bash
# VIRRIC install/init script (drop-in, bash-only).
# Creates FR_management + .virric/config.env for deterministic, agent-friendly operation.
#
set -euo pipefail

if [[ -t 1 ]]; then
  GREEN='\033[0;32m'
  YELLOW='\033[0;33m'
  RED='\033[0;31m'
  CYAN='\033[0;36m'
  RESET='\033[0m'
else
  GREEN='' YELLOW='' RED='' CYAN='' RESET=''
fi

print_usage() {
  cat <<'EOF'
Usage:
  ./virric/install.sh --project-dir <path>

Notes:
  - VIRRIC is now **single-dir only** (movement-based status folders are deprecated).
  - FRs are stored as **bash-parseable Markdown** with a strict header block.
EOF
}

require_cmd() { command -v "$1" >/dev/null 2>&1; }

PROJECT_DIR=""
FR_LAYOUT="single_dir"

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      print_usage
      exit 0
      ;;
    --project-dir)
      PROJECT_DIR="$2"
      shift 2
      ;;
    --fr-layout)
      FR_LAYOUT="$2"
      shift 2
      ;;
    *)
      echo -e "${RED}Error:${RESET} unknown parameter: $1" 1>&2
      print_usage
      exit 1
      ;;
  esac
done

if [[ -z "$PROJECT_DIR" ]]; then
  echo -e "${RED}Error:${RESET} --project-dir is required" 1>&2
  print_usage
  exit 1
fi

if [[ "$FR_LAYOUT" != "single_dir" ]]; then
  echo -e "${YELLOW}VIRRIC:${RESET} --fr-layout is deprecated; forcing single_dir."
  FR_LAYOUT="single_dir"
fi

if ! require_cmd bash; then
  echo -e "${RED}Error:${RESET} bash is required." 1>&2
  exit 1
fi
for c in awk sed grep find date; do
  if ! require_cmd "$c"; then
    echo -e "${RED}Error:${RESET} missing required command: ${CYAN}$c${RESET}" 1>&2
    exit 1
  fi
done

VIRRIC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$PROJECT_DIR" 2>/dev/null && pwd || true)"

if [[ -z "$PROJECT_DIR" || ! -d "$PROJECT_DIR" ]]; then
  echo -e "${RED}Error:${RESET} project dir not found: $PROJECT_DIR" 1>&2
  exit 1
fi

echo -e "${GREEN}VIRRIC:${RESET} initializing project at ${CYAN}$PROJECT_DIR${RESET}"

mkdir -p "$PROJECT_DIR/.virric"
mkdir -p "$PROJECT_DIR/FR_management"

mkdir -p "$PROJECT_DIR/FR_management/frs"

touch "$PROJECT_DIR/FR_management/backlog_tree.md"
touch "$PROJECT_DIR/FR_management/fr_dependencies.md"

cat > "$PROJECT_DIR/.virric/config.env" <<EOF
# VIRRIC project configuration (bash-sourced)
export virric_version="0.2.0"
export framework_path="$VIRRIC_DIR"
export project_root="$PROJECT_DIR"
export fr_management_path="$PROJECT_DIR/FR_management"
export scripts_path="$VIRRIC_DIR/scripts"
export fr_layout="$FR_LAYOUT"
export fr_format="md"
EOF

chmod +x "$VIRRIC_DIR/scripts/fr/"*.sh 2>/dev/null || true
chmod +x "$VIRRIC_DIR/scripts/reporting/"*.sh 2>/dev/null || true
chmod +x "$VIRRIC_DIR/scripts/utils/"*.sh 2>/dev/null || true
chmod +x "$VIRRIC_DIR/scripts/ci/"*.sh 2>/dev/null || true
chmod +x "$VIRRIC_DIR/scripts/gh/"*.sh 2>/dev/null || true

echo -e "${GREEN}VIRRIC:${RESET} installed."
echo -e "${GREEN}VIRRIC:${RESET} layout = ${CYAN}$FR_LAYOUT${RESET}"
echo -e "${GREEN}Next:${RESET} create an FR with:"
echo -e "  ${CYAN}./virric/scripts/fr/create_fr.sh --title \"...\" --description \"...\" --priority \"High\"${RESET}"


