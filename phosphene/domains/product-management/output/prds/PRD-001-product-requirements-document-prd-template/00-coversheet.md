ID: PRD-001
Title: Product Requirements Document (PRD) Template
DocType: PRD (Many-release Program Bible)
Version: [v0.1 | v1.0 | vNext]
Status: [Draft | In Review | Approved | Deprecated]
Updated: [YYYY-MM-DD]
Owners: [Name, Role]
Contributors: [Names / Teams]
Approvers: [Names / Governance Group]
Dependencies:
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/cerulean/product-management/modulator/SKILL.md)

# Product Requirements Document (PRD)
**Product:** [PRODUCT_NAME]  
**Doc Type:** PRD (Many-release Program Bible)  
**Version:** [v0.1 | v1.0 | vNext]  
**Status:** [Draft | In Review | Approved | Deprecated]  
**Last Updated:** [YYYY-MM-DD]  
**Owners:** [Name, Role]  
**Contributors:** [Names / Teams]  
**Approvers:** [Names / Governance Group]  
**Links:**  
- Value Proposition Analysis (Input): [link]  
- Persona Pack (Input): [link]  
- Proposition and Messaging (Input): [link]  
- Competitive Analysis (Optional): [link]  
- Architecture Decision Records (ADRs): [link]  
- Design System / UI Kit: [link]  
- Repository / Monorepo: [link]  
- Analytics Spec: [link]  
- Security Review: [link]  

---

## How to Use This Template (for the generating agent)
**Inputs required:**
1) Value proposition analysis: personas, jobs-to-be-done, propositions, differentiators, objections, pricing assumptions  
2) Constraints: platform limits, legal/compliance, delivery constraints, budget/time, integration constraints  
3) Target operating model: expected teams, release cadence, support posture, SLAs/SLOs  
4) Any existing architecture standards: cloud, language, identity, observability, CI/CD

**Output quality bar:**
- Every core feature traces to at least one proposition and persona job.
- Every architectural choice has explicit rationale, alternatives considered, and trade-offs.
- Every requirement is testable: clear acceptance criteria, non-functional requirements, and observable metrics.
- Roadmap reflects sequencing logic (dependencies, risk, platform foundations), not only desirability.

**Writing rules:**
- Prefer specific, testable statements over slogans.
- Use “shall/should/may” modality consistently in requirements.
- Use measurable metrics and defined thresholds wherever feasible.
- Keep a decision log and an open questions register. Do not leave ambiguity untracked.
