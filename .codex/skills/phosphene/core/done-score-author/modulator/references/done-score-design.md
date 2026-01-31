# Done-score design library

This reference captures deterministic evaluation dimensions, mechanism patterns, and weighting strategies for authoring domain done-score scripts.

## Existing patterns in this repo (quick scan)
- **Minimal scorers**: file count + word count (feature-management, ideation, strategy, vision, research, evaluation, architecture, scrum, test).
- **Rich scorers**: product-marketing and product-management add corpus cleaning, lexical diversity, depth proxies, connectivity graphs, input scaling, and hard gates.

## Dimension catalog (deterministic)
Use any mix of these dimensions. Favor monotonic, earn-only signals unless gating is required.

### Existence and compliance
- Required files present (count or boolean).
- Required headings present (regex scan).
- Required sections non-empty (min words or rows).
- Required tables present with correct headers.
- Required field keys present in coversheet (key:value).
- Required ID patterns present (PER, PROP, RA, etc).
- Forbidden tokens absent (TBD, placeholders).
- Schema conformity (column counts, row format).
- Valid extension/location (artifact in expected path).

### Volume and activity
- Total word count, char count, line count.
- Item counts (personas, propositions, requirements, tests).
- Row counts per table.
- Output/input ratio (words, items, rows).
- Unique item count vs total (de-dup pressure).

### Breadth and coverage
- Number of distinct categories touched.
- Coverage ratio of required categories (count of categories with >=1 item).
- Coverage ratio of upstream IDs (unique referenced / available).
- Coverage ratio of internal IDs (unique referenced / created).
- Target coverage vs dynamic targets (scaled to input size).

### Diversity and novelty (textual)
- Unique word ratio (TTR, Guiraud R).
- Shannon entropy (normalized).
- Unique bigram ratio (simple n-gram diversity).
- Template similarity (Jaccard overlap with template text).
- Stopword ratio (proxy for content density).

### Depth and reasoning
- Avg words per fragment (table rows, bullets, sections).
- Multi-sentence ratio per fragment.
- Reasoning markers count (because, therefore, tradeoff, edge, risk).
- Evidence density (evidence IDs per item).
- Requirement acceptance criteria presence.

### Connectivity and traceability
- Bipartite graph density (items to targets).
- Average degree (per item and per target).
- Minimum degree (coverage floor).
- Multi-target ratio (items linked to >=2 targets).
- Cross-artifact linkage density (REQ to PER/PROP, FEAT to REQ).
- Traceability matrix coverage (IDs used vs IDs existing).

### Consistency and integrity
- ID uniqueness (no duplicates).
- Referential integrity (all referenced IDs exist).
- Unique artifact titles (no duplicate titles).
- Link validity (URL format checks).
- Column consistency (same number of columns per row).

### Balance and distribution
- Min/avg ratio across categories (avoid single bucket domination).
- Standard deviation across categories (encourage balance).
- Per-persona minimums (e.g., 3 props per persona).
- Per-prop minimums (boosters/relievers/caps).

### Specificity and clarity (simple proxies)
- Numeral density (specificity proxy).
- Sentence length bounds (avoid too short or too long).
- Ratio of concrete nouns (if using a static wordlist).
- Presence of action verbs (simple wordlist).

### Risk and edge coverage
- Mentions of risks/objections categories (wordlist scan).
- Coverage of "edge case" phrases.
- Presence of tradeoff language (cost, risk, downside).

### Anti-gaming and quality hardening
- Placeholder removal ([], <...>, TBD).
- Code block exclusion (fenced code).
- Table exclusion when counting prose.
- Token dump detection (high comma density).
- Duplicate line suppression (uniq).

## Mechanism modules (compose a done script)
Use these modules as building blocks in any done-score script:
- **Discovery**: find files, locate docs root and inputs, validate paths.
- **Extraction**: parse section ranges, tables, headers, and IDs into TSVs.
- **Cleaning**: remove IDs, URLs, scripts, placeholders, code blocks.
- **Metric calculators**: counts, ratios, entropies, graph stats.
- **Normalization**: map raw metrics to 0..100 with fixed bounds.
- **Scoring**: weighted sum of category scores, earn-only by default.
- **Gating**: fail fast on missing required artifacts/sections.
- **Reporting**: print subscores, metrics, advice, and exit codes.

## Normalization patterns (deterministic)
- **Linear ramp**: `(x - min) / (max - min)` clamped to 0..1.
- **Ratio cap**: `x/t` clamped to 0..1.
- **Piecewise**: reward only after a minimum threshold.
- **Log or sqrt**: use when raw counts explode (cap for stability).
- **Entropy normalization**: `H / log2(unique)` for 0..1.

## Weighting strategies (deterministic)
- **Weighted sum (SAW)**: sum of normalized metrics times weights.
- **Pairwise weighting (AHP)**: derive weights from comparisons.
- **Geometric mean**: penalize low subscores more strongly.
- **Min-of-scores**: strong gating via `overall = min(subscores)`.
- **Tiered weights**: strict gates for must-haves, soft weights for rest.

## Tuning guidance
- **Exploration bias**: raise diversity and connectivity weights.
- **Compliance bias**: raise structural completeness and traceability.
- **Depth bias**: raise multi-sentence and fragment length weights.
- **Input-aligned**: weight output/input ratios more heavily.
- **Anti-gaming**: hard gates for placeholders and token dumps.

## Reporting patterns
- Print overall + subscores + metric box.
- Provide "next actions" hints for any subscore < 90.
- Always include input/output counts and thresholds for auditability.
