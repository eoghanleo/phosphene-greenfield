ID: PRD-001

# 10) Data, Integrations, and APIs
## 10.1 Data model overview
- **Core entities:** [list]
- **Entity ownership:** [service/module ownership]
- **Data lifecycle:** create, update, delete, retention

## 10.2 Data schema (logical)
| Entity | Key Fields | Relationships | Retention | Sensitivity |
|---|---|---|---|---|
| [entity] | [fields] | [rels] | [time] | [PII/PHI/etc] |

## 10.3 Integrations
| Integration | Purpose | Direction | Protocol | Auth | Rate Limits | Failure Handling | Owner |
|---|---|---|---|---|---|---|---|
| [system] | [purpose] | [in/out] | [REST/events] | [OAuth/etc] | [limits] | [retries/DLQ] | |

## 10.4 Public APIs (if applicable)
### API: [Name]
- **Consumers:** [who]
- **Endpoints:** [list]
- **Versioning strategy:** [semver/path/header]
- **Backward compatibility policy:** [policy]
- **Deprecation plan:** [policy]

## 10.5 Eventing and messaging (if applicable)
- **Event taxonomy:** [event types]
- **Schema registry:** [yes/no]
- **Ordering guarantees:** [per key/global/none]
- **Idempotency strategy:** [strategy]
- **DLQ and replay:** [strategy]
