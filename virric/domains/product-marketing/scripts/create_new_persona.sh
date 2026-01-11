#!/usr/bin/env bash
set -euo pipefail

# create_new_persona.sh
# Creates a Persona (PER-*) doc from the canonical template, allocating IDs via the global registry.
#
# Usage:
#   ./virric/domains/product-marketing/scripts/create_new_persona.sh --title "Idle Ingrid" [--id PER-0003] [--owner "..."] [--status Draft] [--dependencies "CPE-0001,RA-001"] [--output-dir <dir>]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../virric-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/virric_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./virric/domains/product-marketing/scripts/create_new_persona.sh --title "..." [--id PER-0001] [--owner "..."] [--status Draft] [--dependencies "..."] [--output-dir <dir>]
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
OUT_DIR="$ROOT/virric/domains/product-marketing/docs/personas"

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
  ID="$("$ROOT/virric/virric-core/bin/virric" id next --type persona)"
fi

if ! [[ "$ID" =~ ^PER-[0-9]{4}$ ]]; then
  echo "Error: --id must look like PER-0001" >&2
  exit 2
fi

DATE="$(date +%F)"
SLUG="$(slugify "$TITLE")"
OUT="$OUT_DIR/${ID}-${SLUG}.md"

if [[ -e "$OUT" ]]; then
  echo "Error: already exists: $OUT" >&2
  exit 1
fi

TEMPLATE="$ROOT/virric/domains/product-marketing/templates/persona.md"
[[ -f "$TEMPLATE" ]] || { echo "Error: missing template: $TEMPLATE" >&2; exit 1; }

cp "$TEMPLATE" "$OUT"

# Strip template sample rows from all markdown tables (keep header + separator only).
PERSONA_PATH="$OUT" python3 - <<'PY'
import os, re
from pathlib import Path

p = Path(os.environ["PERSONA_PATH"])
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

# Update header + example JTBD suffixes (python for portability)
PER_ID="$ID" PER_TITLE="$TITLE" PER_STATUS="$STATUS" PER_UPDATED="$DATE" PER_DEPS="$DEPENDENCIES" PER_OWNER="$OWNER" PERSONA_PATH="$OUT" python3 - <<'PY'
import os, re
from pathlib import Path

p = Path(os.environ["PERSONA_PATH"])
pid = os.environ["PER_ID"]
title = os.environ.get("PER_TITLE", "")
status = os.environ.get("PER_STATUS", "Draft")
updated = os.environ.get("PER_UPDATED", "")
deps = os.environ.get("PER_DEPS", "")
owner = os.environ.get("PER_OWNER", "")

txt = p.read_text(encoding="utf-8")

def repl_line(key: str, value: str, s: str) -> str:
  # Match within a single line only (avoid \s which can span newlines).
  pattern = re.compile(rf"^{re.escape(key)}:[ \t]*.*$", flags=re.M)
  return pattern.sub(f"{key}: {value}", s)

txt = repl_line("ID", pid, txt)
txt = repl_line("Title", title, txt)
txt = repl_line("Status", status, txt)
txt = repl_line("Updated", updated, txt)
txt = repl_line("Dependencies", deps, txt)
txt = repl_line("Owner", owner, txt)

# Update example JTBD suffixes (template uses -PER-0001)
txt = re.sub(r"-PER-\d{4}\b", f"-{pid}", txt)

p.write_text(txt, encoding="utf-8")
PY

# Remove template placeholder bullet items in Evidence and links subsections (keep structure + [V-SCRIPT] blocks).
PERSONA_PATH="$OUT" python3 - <<'PY'
import re
from pathlib import Path
import os

p = Path(os.environ["PERSONA_PATH"])
lines = p.read_text(encoding="utf-8").splitlines(True)

targets = {
  "### EvidenceIDs",
  "### CandidatePersonaIDs",
  "### DocumentIDs",
  "### Links",
}

out = []
i = 0
while i < len(lines):
  ln = lines[i]
  out.append(ln)
  if ln.rstrip("\n") in targets:
    i += 1
    # Copy through any [V-SCRIPT] fenced block(s) and blank lines; remove bullet lines until next heading.
    while i < len(lines):
      cur = lines[i]
      if cur.startswith("### ") or cur.startswith("## "):
        break
      if re.match(r"^\-\s+", cur):
        i += 1
        continue
      out.append(cur)
      i += 1
    continue
  i += 1

p.write_text("".join(out), encoding="utf-8")
PY

# Validate (strict: scripts must not create strict-invalid artifacts)
set +e
"$ROOT/virric/domains/product-marketing/scripts/validate_persona.sh" --strict "$OUT" >/dev/null
rc=$?
set -e
if [[ $rc -ne 0 ]]; then
  rm -f "$OUT" || true
  exit $rc
fi
echo "Created persona: $OUT"

