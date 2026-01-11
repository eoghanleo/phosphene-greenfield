#!/usr/bin/env bash
set -euo pipefail

# create_new_proposition.sh
# Creates a Proposition (PROP-*) doc from the canonical template, allocating IDs via the global registry.
#
# Usage:
#   ./virric/domains/product-marketing/scripts/create_new_proposition.sh --title "..." [--id PROP-0001] [--owner "..."] [--status Draft] [--dependencies "PER-0001,RA-001"] [--output-dir <dir>]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../virric-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/virric_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./virric/domains/product-marketing/scripts/create_new_proposition.sh --title "..." [--id PROP-0001] [--owner "..."] [--status Draft] [--dependencies "..."] [--output-dir <dir>]
EOF
}

slugify() {
  echo "$1" \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//; s/-+/-/g'
}

ROOT="$(virric_find_project_root)"

TITLE=""
ID=""
OWNER=""
STATUS="Draft"
DEPENDENCIES=""
OUT_DIR="$ROOT/virric/domains/product-marketing/docs/propositions"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --title) TITLE="${2:-}"; shift 2 ;;
    --id) ID="${2:-}"; shift 2 ;;
    --owner) OWNER="${2:-}"; shift 2 ;;
    --status) STATUS="${2:-}"; shift 2 ;;
    --dependencies) DEPENDENCIES="${2:-}"; shift 2 ;;
    --output-dir) OUT_DIR="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$TITLE" ]] || { echo "Error: --title is required" >&2; usage; exit 2; }

if [[ "$OUT_DIR" != /* ]]; then OUT_DIR="$ROOT/$OUT_DIR"; fi
mkdir -p "$OUT_DIR"

if [[ -z "${ID}" ]]; then
  "$ROOT/virric/virric-core/bin/virric" id validate >/dev/null
  ID="$("$ROOT/virric/virric-core/bin/virric" id next --type proposition)"
fi

if ! [[ "$ID" =~ ^PROP-[0-9]{4}$ ]]; then
  echo "Error: --id must look like PROP-0001" >&2
  exit 2
fi

DATE="$(date +%F)"
SLUG="$(slugify "$TITLE")"
OUT="$OUT_DIR/${ID}-${SLUG}.md"

if [[ -e "$OUT" ]]; then
  echo "Error: already exists: $OUT" >&2
  exit 1
fi

TEMPLATE="$ROOT/virric/domains/product-marketing/templates/proposition.md"
[[ -f "$TEMPLATE" ]] || { echo "Error: missing template: $TEMPLATE" >&2; exit 1; }

cp "$TEMPLATE" "$OUT"

# Strip template sample rows from all markdown tables (keep header + separator only).
PROP_PATH="$OUT" python3 - <<'PY'
import os, re
from pathlib import Path

p = Path(os.environ["PROP_PATH"])
lines = p.read_text(encoding="utf-8").splitlines(True)

sep = re.compile(r"^\|\s*:?-{3,}.*\|\s*$")
out = []
i = 0
while i < len(lines):
  if lines[i].lstrip().startswith("|") and i + 1 < len(lines) and sep.match(lines[i + 1]):
    out.append(lines[i])
    out.append(lines[i + 1])
    i += 2
    # Drop all data rows for this table.
    while i < len(lines) and lines[i].lstrip().startswith("|"):
      i += 1
    continue
  out.append(lines[i])
  i += 1

p.write_text("".join(out), encoding="utf-8")
PY

# Update header + example suffixed IDs (python for portability)
PROP_ID="$ID" PROP_TITLE="$TITLE" PROP_STATUS="$STATUS" PROP_UPDATED="$DATE" PROP_DEPS="$DEPENDENCIES" PROP_OWNER="$OWNER" PROP_PATH="$OUT" python3 - <<'PY'
import os, re
from pathlib import Path

p = Path(os.environ["PROP_PATH"])
pid = os.environ["PROP_ID"]
title = os.environ.get("PROP_TITLE", "")
status = os.environ.get("PROP_STATUS", "Draft")
updated = os.environ.get("PROP_UPDATED", "")
deps = os.environ.get("PROP_DEPS", "")
owner = os.environ.get("PROP_OWNER", "")

txt = p.read_text(encoding="utf-8")

def repl_line(key: str, value: str, s: str) -> str:
  pat = re.compile(rf"^{re.escape(key)}:[ \t]*.*$", flags=re.M)
  return pat.sub(f"{key}: {value}", s)

txt = repl_line("ID", pid, txt)
txt = repl_line("Title", title, txt)
txt = repl_line("Status", status, txt)
txt = repl_line("Updated", updated, txt)
txt = repl_line("Dependencies", deps, txt)
txt = repl_line("Owner", owner, txt)

# Update example natural-key suffixes (template uses -PROP-0001)
txt = re.sub(r"-PROP-\d{4}\b", f"-{pid}", txt)

p.write_text(txt, encoding="utf-8")
PY

# Remove template placeholder bullet items in Target Persona(s) / Related Segment(s) (keep structure + [V-SCRIPT] blocks).
PROP_PATH="$OUT" python3 - <<'PY'
import re
from pathlib import Path
import os

p = Path(os.environ["PROP_PATH"])
lines = p.read_text(encoding="utf-8").splitlines(True)

targets = {
  "## Target Persona(s)": re.compile(r"^\-\s+PER-\d{4}\s*$"),
  "## Related Segment(s)": re.compile(r"^\-\s+SEG-\d{4}\s*$"),
}

def section_bounds(h: str):
  start = None
  for i, ln in enumerate(lines):
    if ln.rstrip("\n") == h:
      start = i
      break
  if start is None:
    return None, None
  end = len(lines)
  for j in range(start + 1, len(lines)):
    if lines[j].startswith("## "):
      end = j
      break
  return start, end

for h, pat in targets.items():
  start, end = section_bounds(h)
  if start is None:
    continue
  block = lines[start:end]
  new_block = []
  for ln in block:
    if pat.match(ln.rstrip("\n")):
      continue
    new_block.append(ln)
  lines[start:end] = new_block

p.write_text("".join(lines), encoding="utf-8")
PY

# Validate (strict: scripts must not create strict-invalid artifacts)
set +e
"$ROOT/virric/domains/product-marketing/scripts/validate_proposition.sh" --strict "$OUT" >/dev/null
rc=$?
set -e
if [[ $rc -ne 0 ]]; then
  rm -f "$OUT" || true
  exit $rc
fi
echo "Created proposition: $OUT"

