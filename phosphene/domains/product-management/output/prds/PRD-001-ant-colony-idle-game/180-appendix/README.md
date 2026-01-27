ID: PRD-001

# Appendix

This folder holds glossary, decision log, open questions, and traceability.

## Appendix usage guidance
The appendix provides the traceability backbone for the PRD. It exists so that future domain work can validate that each requirement still ties back to a proposition and persona. When feature-management and test-management artifacts are created, they should use the appendix to confirm that scope changes are intentional and grounded.

The decision log is not a journal of all activity. It is reserved for decisions that change the direction of the PRD, such as re-prioritizing the fair progress hub or altering the in-chat distribution strategy. This keeps the log lightweight and useful, while still providing a record of why the product moved in a particular direction.

The open questions table is a living list. Questions should be closed only when validated by data or a formal decision; they should not be closed because the team feels confident. This prevents the product from drifting away from evidence-based validation, especially in areas where research confidence is low.

The glossary is critical for cross-domain alignment. Terms like “return recap” or “trust vault” must mean the same thing across product management, feature management, and testing. If a term evolves, it should be updated here first, then propagated to downstream artifacts.

## Extended rationale notes
The appendix exists to preserve continuity across domains, not to store redundant narrative. It should record the reasoning behind requirements so that feature decompositions remain grounded in the same constraints. This is especially important in a product where trust and fairness are central, because those values are easy to erode when features are added in isolation.

When new feature requests are created, the traceability matrix should be consulted before writing any new requirements. This ensures that the feature aligns to an existing proposition or triggers a deliberate upstream change. It also prevents the product-management domain from becoming a dumping ground for unvalidated ideas that bypass research.

Decision log entries should prioritize clarity over completeness. A short entry explaining why a fairness pledge was moved earlier in the roadmap is more valuable than a long entry describing implementation details. Implementation details belong in engineering notes, not in the PRD appendix.

Open questions should be treated as active hypotheses. If an experiment resolves a question, the closure should include a brief summary of the evidence. This practice prevents the team from treating unresolved risks as settled facts and encourages a culture of validation.

The glossary should be updated whenever terminology shifts. For example, if the team decides to rename the “trust vault” to “continuity ledger,” the glossary should change first so that downstream documents remain consistent. This prevents confusion and reduces rework in later domains.

Traceability should be enforced during reviews. If a feature request cannot be traced back to a proposition and persona, it should be paused until the connection is made. This gate protects the product from drifting away from the original problem statement.

## Alignment taxonomy
Alignment reviews should be classified into governance, trust, and pacing tracks. Governance reviews focus on ID integrity, versioning, and dependency headers; trust reviews focus on continuity signals, receipt clarity, and fairness safeguards; pacing reviews focus on cadence, milestone spacing, and return-loop clarity. These tracks allow reviews to be scoped without losing cross-domain accountability.

Experiment reviews should map hypotheses to evidence types: behavioral telemetry, qualitative feedback, and operational incidents. A single metric spike is insufficient; the review should seek convergence across at least two evidence types. This approach preserves rigor without requiring perfect data.

Scope reviews should categorize changes as additive, substitutive, or disruptive. Additive changes extend existing propositions, substitutive changes replace a requirement with an equivalent, and disruptive changes require an updated decision log and traceability matrix. Using this taxonomy keeps scope growth explicit and auditable.

Consistency reviews should verify that terminology, metric names, and event tags remain stable across artifacts. If terminology drifts, update the glossary and propagate the change immediately. This avoids subtle mismatches that can erode automated validation and human understanding.

Governance notes should be written in operational language rather than aspirational prose. Clear, checkable statements reduce ambiguity and improve downstream execution. This supports the PRD’s role as a contract rather than a vision statement.
