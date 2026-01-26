## PHOSFLOW (Mermaid-only) — canonical diagram conventions

PHOSFLOW is now **pure Mermaid**, with strict conventions. The diagrams are intended to be both:

- **human-readable** (in schematics and docs)
- **machine-parseable** (by reading nodes/edges + labels; optional metadata via Mermaid comments later)

### Conventions (non-negotiable)

- **Instruments are always labeled in CAPITALS**
  - Example labels: `AUTOSCRIBE`, `HOPPER`, `PRISM`, `DETECTOR`, `CONDENSER`, `TRAP`, `MODULATOR`
- **Signals are lowercase**, minimal identifiers
  - Use the smallest meaningful action name (often the action/step name being triggered), e.g. `issue_created`, `start`, `branch_invoked`, `receipt`, `approve`, `trap`, `merge_complete`, `remediate`
- **GANTRIES are circles**: `((...))`
- **APPARATUS are squares**: `[...]`
- **Decisions are diamonds**: `{...}`, placed immediately after the instrument that decides
- **Do not use “codex”** in diagrams (runtime supplier is not hard-wired)
  - For the current product-marketing flow, the work configuration is **`MODULATOR`** (this is the apparatus square)
- **Wireless bus implied**: an edge label implies “signal emitted → downstream reacts”; we do not draw the bus each time

---

### Example: `<product-marketing>` loop (lane: `beryl`)

```mermaid
flowchart LR
  %% Gantries (circles)
  AS((AUTOSCRIBE))
  H((HOPPER))
  P((PRISM))
  D((DETECTOR))
  K((CONDENSER))
  T((TRAP))

  %% Apparatus (square)
  MOD[MODULATOR]
  HUM[HUMAN PR MERGE]

  %% Decision (diamond)
  DEC{Approve?}

  %% Core loop
  AS -->|issue_created| H
  H -->|start| P
  P -->|branch_invoked| MOD
  MOD -->|receipt| D
  D --> DEC

  %% Detector split
  DEC -->|approve| K
  DEC -->|trap| T

  %% Reactor loops
  K -->|approve| HUM
  HUM -->|merge_complete (manual)| AS
  T -->|remediate| MOD
```

Notes:

- This diagram **assumes signals are wireless** (implicit bus). The arrows represent “a signal causes the next component to react”.
- If you want, we can add optional externals (`Issue`, `PR`, `CI`) as separate shapes, but I kept it to your core loop + decision semantics.

