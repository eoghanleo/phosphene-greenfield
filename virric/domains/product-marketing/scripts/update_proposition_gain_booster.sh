#!/usr/bin/env bash
set -euo pipefail

# update_proposition_gain_booster.sh
# Updates an existing Gain Booster row in the "## Gain Boosters" table.
#
# Usage:
#   ./virric/domains/product-marketing/scripts/update_proposition_gain_booster.sh --proposition <file> --booster-id BOOST-0001-PROP-0001 [--booster "..."] [--mapped-gains "..."]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../virric-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/virric_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./virric/domains/product-marketing/scripts/update_proposition_gain_booster.sh --proposition <file> --booster-id BOOST-0001-PROP-0001 [--booster "..."] [--mapped-gains "..."]
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }

ROOT="$(virric_find_project_root)"

PROP=""
BID=""
BOOSTER=""
MAPPED=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --proposition) PROP="${2:-}"; shift 2 ;;
    --booster-id) BID="${2:-}"; shift 2 ;;
    --booster) BOOSTER="${2:-}"; shift 2 ;;
    --mapped-gains) MAPPED="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$PROP" ]] || { echo "Error: --proposition is required" >&2; usage; exit 2; }
[[ -n "$BID" ]] || { echo "Error: --booster-id is required" >&2; usage; exit 2; }
[[ -n "$BOOSTER" || -n "$MAPPED" ]] || fail "Provide at least one of --booster or --mapped-gains"

if [[ "$PROP" != /* ]]; then PROP="$ROOT/$PROP"; fi
[[ -f "$PROP" ]] || fail "Not a file: $PROP"

if [[ -n "$BOOSTER" && "$BOOSTER" == *"|"* ]]; then fail "--booster must not contain '|'"; fi

PROP_PATH="$PROP" BOOSTER_ID="$BID" NEW_TEXT="$BOOSTER" NEW_MAPPED="$MAPPED" python3 - <<'PY'
import os, re, sys
from pathlib import Path

p = Path(os.environ["PROP_PATH"])
bid = os.environ["BOOSTER_ID"].strip()
new_text = os.environ.get("NEW_TEXT", "").strip()
new_mapped_in = os.environ.get("NEW_MAPPED", "").strip()

content = p.read_text(encoding="utf-8")
m = re.search(r"^ID:\s*(PROP-\d{4})\s*$", content, flags=re.M)
if not m:
  print(f"FAIL: {p.name}: missing/invalid 'ID: PROP-####'", file=sys.stderr)
  sys.exit(1)
prop_id = m.group(1)

if not re.fullmatch(rf"BOOST-\d{{4}}-{re.escape(prop_id)}", bid):
  print(f"FAIL: booster-id must match proposition ID suffix ({prop_id}): {bid}", file=sys.stderr)
  sys.exit(1)

def normalize_jtbd_list(s: str):
  if not s or s == "<...>":
    return ""
  parts = [x.strip() for x in s.split(",") if x.strip()]
  for x in parts:
    if not re.fullmatch(r"JTBD-GAIN-\d{4}-PER-\d{4}", x):
      print(f"FAIL: invalid mapped gain id: {x}", file=sys.stderr)
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

start, end = find_section_bounds("## Gain Boosters")
if start is None:
  print(f"FAIL: {p.name}: missing '## Gain Boosters'", file=sys.stderr)
  sys.exit(1)

row_re = re.compile(r"^\|\s*" + re.escape(bid) + r"\s*\|")
for i in range(start, end):
  ln = lines[i]
  if row_re.match(ln):
    parts = [x.strip() for x in ln.strip("\n").split("|")]
    # ["", id, booster, mapped, ""]
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
  print(f"FAIL: {p.name}: BoosterID row not found: {bid}", file=sys.stderr)
  sys.exit(1)

p.write_text("".join(lines), encoding="utf-8")
print(f"Updated gain booster {bid} -> {p}")
PY

"$ROOT/virric/domains/product-marketing/scripts/validate_proposition.sh" "$PROP" >/dev/null
echo "OK: validated $PROP"

