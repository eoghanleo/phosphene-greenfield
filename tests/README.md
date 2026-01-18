# PHOSPHENE tests

This repo’s automated tests are **bash-native** and live under `tests/` (not repo root).

## Layout

- `tests/run.sh`
  - Convenience runner for the whole suite (or a subset).
- `tests/e2e/`
  - End-to-end lifecycle tests that chain multiple domain scripts together.
- `tests/product-marketing/`
  - Script-level tests for `<product-marketing>` control scripts (PER/PROP/VPD).
- `tests/lib/`
  - Shared test helpers (sourced by the test scripts).
- `tests/playground/`
  - Non-executed manual playground artifacts (e.g. HTML).

## Run

Run everything:

```bash
bash tests/run.sh
```

Run everything with line-hit coverage:

```bash
bash tests/run.sh --coverage
```

Run only end-to-end:

```bash
bash tests/run.sh --e2e
```

Run only product-marketing script tests:

```bash
bash tests/run.sh --product-marketing
```

Run a single test directly:

```bash
bash tests/product-marketing/test_add_persona_note.sh
```

## Test hygiene (important)

Tests may create temporary artifacts under canonical `phosphene/domains/**/output/**`.
They must clean up and should leave `phosphene/id_index.tsv` consistent afterward.

