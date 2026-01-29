ID: PRD-001

# Feature catalogue

Split into core vs special features.

## Feature taxonomy rationale
Core features represent the minimum set required to satisfy the three persona pillars. They include fairness, return recaps, experimentation tools, and in-chat continuity. Without these, the product would not meet the promises encoded in the propositions, so they are prioritized as P0–P1 features. Special features are value-add elements that enhance delight or growth but can be delayed without breaking the core experience.

The catalogue is intentionally redundant across personas. For example, the fair progress hub serves both relaxed and in-chat personas, while the experimentation studio serves strategists and provides analytics signals for product managers. This redundancy is a deliberate design choice: it ensures that each feature is accountable to multiple personas, reducing the chance that a feature becomes orphaned from actual user needs.

## Feature sequencing notes
Feature sequencing is driven by validation learning, not by aesthetic polish. The return recap loop and fairness hub ship first because they validate whether the core loop is trustworthy. Experimentation tools ship next because they test whether strategists perceive depth. In-chat continuity follows once persistence stability is proven in the web baseline.

## Feature-to-requirement alignment
Every feature in this catalogue maps to explicit requirements and propositions. This alignment ensures that the feature catalogue can be decomposed into feature requests (FRs) without losing traceability. If a new feature is proposed, it must either map to an existing proposition or trigger an upstream change in product-marketing or research.

## Quality thresholds
Core features must meet the non-functional requirements for performance and reliability before they can be marked complete. Special features can be shipped behind feature flags if their performance impact is minimal. The product team should avoid shipping special features that undermine fairness or increase cognitive load.

## Deprecation and iteration guidance
If a feature underperforms, the team should first look at the persona and proposition it supports before removing it. For example, if discovery pulses are underused, the team should test cadence changes and narrative framing before retiring the feature. This avoids over-reacting to early data and keeps the product aligned with the research hypotheses.
