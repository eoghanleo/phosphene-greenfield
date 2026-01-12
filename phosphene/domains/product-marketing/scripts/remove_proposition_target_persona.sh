#!/usr/bin/env bash
set -euo pipefail

# remove_proposition_target_persona.sh
# Removes a PER-#### entry from "## Target Persona(s)" in a proposition.
#
# Usage:
#   ./phosphene/domains/product-marketing/scripts/remove_proposition_target_persona.sh --proposition <file> --persona PER-0001

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../phosphene-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/phosphene_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./phosphene/domains/product-marketing/scripts/remove_proposition_target_persona.sh --proposition <file> --persona PER-0001
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }

ROOT="$(phosphene_find_project_root)"

PROP=""
PER=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --proposition) PROP="${2:-}"; shift 2 ;;
    --persona) PER="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$PROP" ]] || { echo "Error: --proposition is required" >&2; usage; exit 2; }
[[ -n "$PER" ]] || { echo "Error: --persona is required" >&2; usage; exit 2; }
[[ "$PER" =~ ^PER-[0-9]{4}$ ]] || fail "--persona must look like PER-0001"

if [[ "$PROP" != /* ]]; then PROP="$ROOT/$PROP"; fi
[[ -f "$PROP" ]] || fail "Not a file: $PROP"

TMP_OUT="$(mktemp)"
set +e
PROP_PATH="$PROP" OUT_PATH="$TMP_OUT" ITEM="$PER" HEADING="## Target Persona(s)" python3 - <<'PY'
import os, re
from pathlib import Path

p = Path(os.environ["PROP_PATH"])
out_path = Path(os.environ["OUT_PATH"])
item = os.environ["ITEM"].strip()
heading = os.environ["HEADING"]

txt = p.read_text(encoding="utf-8")
lines = txt.splitlines(True)

def remove_from_dependencies(item_id: str):
  for i, ln in enumerate(lines[:60]):
    if ln.startswith("Dependencies:"):
      raw = ln.split(":", 1)[1]
      parts = [x.strip() for x in raw.split(",") if x.strip()]
      parts = [x for x in parts if x != item_id]
      new = ", ".join(parts)
      lines[i] = f"Dependencies: {new}\n"
      return
  # If missing Dependencies:, leave (validator will catch).

def find_line_exact(s):
  for i, ln in enumerate(lines):
    if ln.rstrip("\n") == s:
      return i
  return None

start = find_line_exact(heading)
end = len(lines)
for i in range(start + 1, len(lines)):
  if lines[i].startswith("## "):
    end = i
    break

block = lines[start:end]
new_block = []
removed = 0
for ln in block:
  if re.match(r"^\-\s+" + re.escape(item) + r"\s*$", ln.rstrip("\n")):
    removed += 1
    continue
  new_block.append(ln)

lines[start:end] = new_block
remove_from_dependencies(item)
out_path.write_text("".join(lines), encoding="utf-8")
print(f"Removed target persona {item} ({removed} occurrence(s)) -> {out_path}")
PY

py_rc=$?
if [[ $py_rc -ne 0 ]]; then
  rm -f "$TMP_OUT"
  exit $py_rc
fi

"$ROOT/phosphene/domains/product-marketing/scripts/validate_proposition.sh" --strict "$TMP_OUT" >/dev/null
val_rc=$?
if [[ $val_rc -ne 0 ]]; then
  rm -f "$TMP_OUT"
  exit $val_rc
fi

mv "$TMP_OUT" "$PROP"
set -e

echo "OK: strict-validated $PROP"

