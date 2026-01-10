#!/usr/bin/env bash
set -euo pipefail

# update_proposition_pain_reliever.sh
# Updates an existing Pain Reliever row in the "## Pain Relievers" table.
#
# Usage:
#   ./virric/domains/product-marketing/scripts/update_proposition_pain_reliever.sh --proposition <file> --reliever-id REL-0001-PROP-0001 [--reliever "..."] [--mapped-pains "..."]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../virric-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/virric_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./virric/domains/product-marketing/scripts/update_proposition_pain_reliever.sh --proposition <file> --reliever-id REL-0001-PROP-0001 [--reliever "..."] [--mapped-pains "..."]
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }

ROOT="$(virric_find_project_root)"

PROP=""
RID=""
RELIEVER=""
MAPPED=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --proposition) PROP="${2:-}"; shift 2 ;;
    --reliever-id) RID="${2:-}"; shift 2 ;;
    --reliever) RELIEVER="${2:-}"; shift 2 ;;
    --mapped-pains) MAPPED="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$PROP" ]] || { echo "Error: --proposition is required" >&2; usage; exit 2; }
[[ -n "$RID" ]] || { echo "Error: --reliever-id is required" >&2; usage; exit 2; }
[[ -n "$RELIEVER" || -n "$MAPPED" ]] || fail "Provide at least one of --reliever or --mapped-pains"

if [[ "$PROP" != /* ]]; then PROP="$ROOT/$PROP"; fi
[[ -f "$PROP" ]] || fail "Not a file: $PROP"

if [[ -n "$RELIEVER" && "$RELIEVER" == *"|"* ]]; then fail "--reliever must not contain '|'"; fi

PROP_PATH="$PROP" RELIEVER_ID="$RID" NEW_TEXT="$RELIEVER" NEW_MAPPED="$MAPPED" python3 - <<'PY'
import os, re, sys
from pathlib import Path

p = Path(os.environ["PROP_PATH"])
rid = os.environ["RELIEVER_ID"].strip()
new_text = os.environ.get("NEW_TEXT", "").strip()
new_mapped_in = os.environ.get("NEW_MAPPED", "").strip()

content = p.read_text(encoding="utf-8")
m = re.search(r"^ID:\s*(PROP-\d{4})\s*$", content, flags=re.M)
if not m:
  print(f"FAIL: {p.name}: missing/invalid 'ID: PROP-####'", file=sys.stderr)
  sys.exit(1)
prop_id = m.group(1)

if not re.fullmatch(rf"REL-\d{{4}}-{re.escape(prop_id)}", rid):
  print(f"FAIL: reliever-id must match proposition ID suffix ({prop_id}): {rid}", file=sys.stderr)
  sys.exit(1)

def normalize_jtbd_list(s: str):
  if not s or s == "<...>":
    return ""
  parts = [x.strip() for x in s.split(",") if x.strip()]
  for x in parts:
    if not re.fullmatch(r"JTBD-PAIN-\d{4}-PER-\d{4}", x):
      print(f"FAIL: invalid mapped pain id: {x}", file=sys.stderr)
      sys.exit(1)
  return ", ".join(sorted(set(parts)))

new_mapped = normalize_jtbd_list(new_mapped_in) if new_mapped_in else None

lines = content.splitlines(True)

def find_section_bounds(h):
  start = None
  for i, ln in enumerate(lines):
    if ln.rstrip("\n") == h:
      start = i
      break
  if start is None:
    return None, None
  end = len(lines)
  for i in range(start + 1, len(lines)):
    if lines[i].startswith("## "):
      end = i
      break
  return start, end

start, end = find_section_bounds("## Pain Relievers")
if start is None:
  print(f"FAIL: {p.name}: missing '## Pain Relievers'", file=sys.stderr)
  sys.exit(1)

row_re = re.compile(r"^\|\s*" + re.escape(rid) + r"\s*\|")
for i in range(start, end):
  ln = lines[i]
  if row_re.match(ln):
    parts = [x.strip() for x in ln.strip("\n").split("|")]
    if len(parts) < 5:
      print(f"FAIL: malformed table row: {ln.rstrip()}", file=sys.stderr)
      sys.exit(1)
    if new_text:
      parts[2] = new_text
    if new_mapped is not None:
      parts[3] = new_mapped if new_mapped else "<...>"
    lines[i] = f"| {parts[1]} | {parts[2]} | {parts[3]} |\n"
    break
else:
  print(f"FAIL: {p.name}: RelieverID row not found: {rid}", file=sys.stderr)
  sys.exit(1)

p.write_text("".join(lines), encoding="utf-8")
print(f"Updated pain reliever {rid} -> {p}")
PY

"$ROOT/virric/domains/product-marketing/scripts/validate_proposition.sh" "$PROP" >/dev/null
echo "OK: validated $PROP"

