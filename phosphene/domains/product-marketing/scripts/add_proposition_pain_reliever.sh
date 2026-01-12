#!/usr/bin/env bash
set -euo pipefail

# add_proposition_pain_reliever.sh
# Adds a Pain Reliever row to the "## Pain Relievers" table.
#
# Usage:
#   ./phosphene/domains/product-marketing/scripts/add_proposition_pain_reliever.sh --proposition <file> --reliever "..." [--mapped-pains "JTBD-PAIN-0001-PER-0001,JTBD-PAIN-0002-PER-0001"]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../phosphene-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/phosphene_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./phosphene/domains/product-marketing/scripts/add_proposition_pain_reliever.sh --proposition <file> --reliever "..." [--mapped-pains "..."]
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }

ROOT="$(phosphene_find_project_root)"

PROP=""
RELIEVER=""
MAPPED=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --proposition) PROP="${2:-}"; shift 2 ;;
    --reliever) RELIEVER="${2:-}"; shift 2 ;;
    --mapped-pains) MAPPED="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$PROP" ]] || { echo "Error: --proposition is required" >&2; usage; exit 2; }
[[ -n "$RELIEVER" ]] || { echo "Error: --reliever is required" >&2; usage; exit 2; }
if [[ "$RELIEVER" == *"|"* ]]; then fail "--reliever must not contain '|'"; fi

if [[ "$PROP" != /* ]]; then PROP="$ROOT/$PROP"; fi
[[ -f "$PROP" ]] || fail "Not a file: $PROP"

PROP_PATH="$PROP" RELIEVER_TEXT="$RELIEVER" MAPPED_INPUT="$MAPPED" python3 - <<'PY'
import os, re, sys
from pathlib import Path

p = Path(os.environ["PROP_PATH"])
reliever = os.environ["RELIEVER_TEXT"].strip()
mapped_in = os.environ.get("MAPPED_INPUT", "").strip()

content = p.read_text(encoding="utf-8")
m = re.search(r"^ID:\s*(PROP-\d{4})\s*$", content, flags=re.M)
if not m:
  print(f"FAIL: {p.name}: missing/invalid 'ID: PROP-####'", file=sys.stderr)
  sys.exit(1)
prop_id = m.group(1)

def normalize_jtbd_list(s: str):
  if not s or s == "<...>":
    return ""
  parts = [x.strip() for x in s.split(",") if x.strip()]
  for x in parts:
    if not re.fullmatch(r"JTBD-PAIN-\d{4}-PER-\d{4}", x):
      print(f"FAIL: invalid mapped pain id: {x}", file=sys.stderr); sys.exit(1)
  return ", ".join(sorted(set(parts)))

mapped = normalize_jtbd_list(mapped_in)

nums = [int(mm.group(1)) for mm in re.finditer(rf"REL-(\d{{4}})-{re.escape(prop_id)}", content)]
next_num = (max(nums) + 1) if nums else 1
rid = f"REL-{next_num:04d}-{prop_id}"

lines = content.splitlines(True)

def find_line_exact(s):
  for i, ln in enumerate(lines):
    if ln.rstrip("\n") == s:
      return i
  return None

start = find_line_exact("## Pain Relievers")
if start is None:
  print(f"FAIL: {p.name}: missing '## Pain Relievers'", file=sys.stderr)
  sys.exit(1)
end = len(lines)
for i in range(start + 1, len(lines)):
  if lines[i].startswith("## "):
    end = i
    break

insert_at = None
for i in range(end - 1, start, -1):
  if re.match(r"^\|\s*REL-\d{4}-PROP-\d{4}\s*\|", lines[i]):
    insert_at = i + 1
    break
if insert_at is None:
  for i in range(start, end):
    if re.match(r"^\|\s*---", lines[i]):
      insert_at = i + 1
      break
if insert_at is None:
  print(f"FAIL: {p.name}: could not find relievers table to insert into", file=sys.stderr)
  sys.exit(1)

row = f"| {rid} | {reliever} | {mapped if mapped else '<...>'} |\n"
lines.insert(insert_at, row)
p.write_text("".join(lines), encoding="utf-8")
print(f"Added pain reliever {rid} -> {p}")
PY

"$ROOT/phosphene/domains/product-marketing/scripts/validate_proposition.sh" "$PROP" >/dev/null
echo "OK: validated $PROP"

