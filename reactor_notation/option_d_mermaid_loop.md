## Option D — Mermaid loop diagram (system view)

This is intentionally **not** part of the reactor *notation* options. It’s a **system diagram view** that we can generate from any of the notations later.

Constraints you asked for:

- **Gantries are circles**
- **Apparatus is a square**
- **Decision points are diamonds** placed after the deciding gantry
- Diagram is designed to **loop**
  - `Condenser -> Autoscribe`
  - `Trap -> Apparatus`

### Product-marketing loop (beryl) — Mermaid flowchart

```mermaid
flowchart LR
  %% Gantries (circles)
  AS((Autoscribe))
  H((Hopper))
  P((Prism))
  D((Detector))
  K((Condenser))
  T((Trap))

  %% Apparatus (square)
  CX[Apparatus: Codex]

  %% Decision (diamond)
  DEC{Approve?}

  %% Core loop
  AS -->|issue_created| H
  H -->|start| P
  P -->|branch_invoked| CX
  CX -->|receipt| D
  D --> DEC

  %% Detector split
  DEC -->|approve| K
  DEC -->|trap| T

  %% Reactor loops
  K -->|merge_complete| AS
  T -->|remediate| CX
```

Notes:

- This diagram **assumes signals are wireless** (implicit bus). The arrows represent “a signal causes the next component to react”.
- If you want, we can add optional externals (`Issue`, `PR`, `CI`) as separate shapes, but I kept it to your core loop + decision semantics.

