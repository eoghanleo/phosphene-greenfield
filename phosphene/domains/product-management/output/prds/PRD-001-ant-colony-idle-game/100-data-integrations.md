ID: PRD-001

# 10) Data, Integrations, and APIs

## 10.1 Data model overview
- **Colony state:** Snapshot model with delta history for recaps and experiments. The snapshot must include milestone and discovery fields.
- **Economy ledger:** Baseline vs boosted progression values for fairness transparency. The ledger must support drill-down comparisons.
- **Experiment logs:** Scenario parameters, metrics, and outcomes. The logs must support repeatable benchmarks.

The data model must support rapid synthesis into player-facing summaries. Each snapshot should include explicit fields for discovery events, milestone progress, and economy changes so the recap generator can produce a high-quality narrative without re-running the simulation. This design ensures that return recaps remain fast even on slower devices and in chat contexts.

## 10.2 Integrations
- **ChatGPT App surface:** Embed interactive UI; support commerce protocol when available (E-0010). The integration must preserve conversational context.
- **Telemetry pipeline:** Events for recap, discovery, purchases, and experiments. The pipeline must tag surface and pacing template.

The telemetry design should allow segmentation by persona proxies (session length, feature usage, and pacing template) so the PM team can map behavior to PER-0001/2/3 without explicit self-reporting. This segmentation is essential for evaluating whether the product is meeting persona-specific expectations. The commerce integration should also expose clear receipt data so that trust vault entries can be shown to PER-0003.

## 10.3 Data retention
- Keep minimal personal data; focus on session and colony state identifiers. This supports a trust-first privacy posture.
- Retain experiment logs long enough to support comparison across sessions. This supports strategist credibility.
- Provide a clear data deletion path to maintain trust. This supports compliance and transparency.

## 10.4 Data governance and analytics notes
Data governance must align with the fairness narrative. Players should feel confident that the game is not extracting unnecessary data, so only events needed for progression, trust, and experimentation should be stored. Any additional telemetry should be justified in the decision log and described in the privacy summary. This reduces the risk that data collection undermines trust, especially for in-chat explorers.

Analytics should emphasize sequence analysis rather than isolated event counts. For example, a ledger view followed by a purchase suggests an informed choice, while a purchase without a ledger view may suggest confusion or pressure. Similarly, a discovery pulse that leads to a recap action suggests successful pacing, while a pulse that leads to a session exit suggests overload. These analytics patterns should guide iteration decisions.

The data model should also support experimental toggles. When a feature variant is active, the event stream should record variant IDs so that outcomes can be attributed accurately. This is critical for evaluating whether changes to pacing, discovery cadence, or in-chat prompts are improving or harming the experience. Without this, the team would be unable to validate the hypotheses embedded in the PRD.
