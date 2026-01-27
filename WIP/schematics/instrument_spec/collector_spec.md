## COLLECTOR — spec

<table width="100%">
  <tr>
    <td width="340" valign="top">
      <img
        src="https://github.com/user-attachments/assets/7be18c9c-adde-4ec6-8518-137ce5e8c4cd"
        alt="FLORA-Studio Hero Shot-4c8a2eda"
        width="340"
      />
    </td>
    <td valign="top">
      The `COLLECTOR` is an apparatus that acquires raw phos from outside the reactor and refines it into a usable form. Operationally, it is how the reactor gains new information: ingesting external sources (research, docs, datasets, transcripts, reference repos) and transforming them into repo-native artifacts that can be verified, versioned, and coupled back into the main beam. A collector emits the same kind of durable completion receipt as other apparatus, so downstream detectors can treat ingestion as verifiable work rather than a narrative claim.
    </td>
  </tr>
</table>

**Status**: NOT IMPLEMENTED (spec deferred; requirements are not yet enforced).

### Purpose

- Ingest external sources and convert them into repo-native artifacts.
- Emit DONE receipts so ingestion is verifiable, not narrative.

### Responsibilities

- SHOULD acquire external inputs (docs, transcripts, datasets, reference repos).
- SHOULD normalize and structure ingested material into domain artifacts.
- SHOULD maintain traceability back to sources and upstream IDs.
- SHOULD emit `phosphene.done.<domain>.receipt.v1` after ingestion work completes.

### Inputs (expected)

- External sources (URLs, files, datasets, transcripts).
- Issue intent and scope constraints (lane, domain, work_id).
- Parent signal id from prism branch invocation.

### Outputs (signals / side effects)

- Repo-native artifacts under `phosphene/domains/<domain>/output/`.
- DONE receipt signal appended to `phosphene/signals/bus.jsonl`.
- Git commits on the issue-named branch.

### Trigger surface

- SHOULD be summoned via prism issue comments (same as modulators).
- SHOULD operate under a domain skill definition when present.

### Configuration

- Domain skill path: `.codex/skills/phosphene/<color>/<domain>/modulator/SKILL.md`.
- Script paths under `.codex/skills/phosphene/<color>/<domain>/modulator/scripts/`.
- Signal bus tools (`signal_bus.sh`, `signal_hash.sh`) for DONE receipts.

### Constraints

- SHOULD be bash-only for scripts and artifacts.
- SHOULD be script-first (no hand edits to script-managed outputs).
- SHOULD NOT open PRs; human opens PR after branch push.

### Idempotency

- DONE receipt scripts should check for existing signal_id before appending.
- Re-runs should not duplicate artifacts if source inputs are unchanged.

### Failure modes

- Source unavailable or unreadable (ingestion fails).
- Validation failures in downstream detectors (trap remediation).
- Missing parent signal id (cannot emit DONE receipt).

### Observability

- Signal bus entries for DONE receipts.
- Git commit history on the branch.
- Source references embedded in produced artifacts.

### Open questions

- No collector-specific workflows or skills exist yet; define first implementation.
- Do collectors require a dedicated validator surface distinct from modulators?

