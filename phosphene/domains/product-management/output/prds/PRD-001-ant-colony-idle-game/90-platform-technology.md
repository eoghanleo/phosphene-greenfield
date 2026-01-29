ID: PRD-001

# 9) Platform Selection and Technology Standards

## 9.1 Selection criteria
- Performance on mid-tier laptops and modern mobile browsers.
- Compatibility with ChatGPT in-chat surface requirements.
- Ability to support deterministic simulation snapshots.

The platform decisions prioritize consistency over maximal reach. The user promise is that the colony feels alive and responsive; any platform that undermines this promise should be excluded from early phases. This is especially critical for PER-0002, who interprets poor performance as shallow design. Therefore, a stable WebGPU pipeline and reliable state persistence are non-negotiable even if they limit initial device coverage.

## 9.2 Platform choices (with rationale)
- **WebGPU + WebAssembly:** Required for credible simulation depth (supports PER-0002 expectations).
- **Server-side persistence service:** Needed for cross-surface continuity (PROP-0008, PROP-0023).
- **Event telemetry pipeline:** Supports fairness and retention measurement.

## 9.3 Known constraints
- WebGPU coverage on iOS may be limited; plan for graceful fallback (lite mode).
- ChatGPT commerce integration is still evolving; the purchase flow must be resilient to changing APIs (E-0010).

## 9.4 Technology standards
- Use deterministic simulation steps to ensure benchmark and experiment reproducibility.
- Ensure all user-facing economic values can be audited in the economy ledger.
- Maintain strict separation between optional purchases and core progression logic.
