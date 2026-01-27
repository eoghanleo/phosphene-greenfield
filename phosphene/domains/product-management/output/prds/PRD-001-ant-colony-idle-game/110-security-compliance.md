ID: PRD-001

# 11) Security, Privacy, and Compliance

## 11.1 Data classification and handling
- **Colony state:** Pseudonymous gameplay data; must be encrypted at rest and in transit.
- **Purchase metadata:** Store receipts and transaction IDs with audit trail.

## 11.2 Privacy requirements
- Provide a clear data handling summary on request (R-SPEC-057).
- Allow players to export or delete account-associated colony state.

Privacy is a trust lever for PER-0003 and PER-0001. If players do not understand where their progress is stored or how it is used, they will not return or spend. This is why the PRD treats data disclosure as part of the product experience rather than a legal afterthought. The trust vault and economy ledger interfaces should link directly to the underlying data policies to close the trust loop.

## 11.3 Risk controls
- Validate persistence integrity via state hashes (PROP-0023).
- Rate-limit commerce endpoints to prevent abuse.
- Use anomaly detection to flag unusually high spend patterns that could indicate coercive designs.

## 11.4 Compliance and trust UX
Compliance workflows should be visible but not disruptive. When a player requests data deletion, the system should provide a clear timeline and confirm when the deletion is complete. If purchases are reversed, the system should explain the impact on colony state so that the player understands the consequences.

Trust UX should be consistent across web and chat. If a privacy summary is available in web settings, the same summary should be accessible in chat with the same language. This consistency reduces confusion and reinforces that the product operates under the same fairness principles regardless of surface. It also protects against the perception that chat is an experimental environment with weaker safeguards.
