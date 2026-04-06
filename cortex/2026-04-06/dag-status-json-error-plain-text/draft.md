# [BUG] [v0.0.7] dag status --format json returns plain-text error for missing DAG IDs

## Repro Steps
1. Run `cortex dag status missing-dag --format json --color never`.
2. Compare with `cortex dag status hunt-dag-1 --format json --color never`.

## Actual Result
The missing-DAG path returns plain text:
`Error: DAG 'missing-dag' not found`

## Expected Result
When `--format json` is requested, the error path should also return JSON output instead of plain text.

## Evidence
- `01-help-proof.png`
- `02-missing-dag-json-proof.png`
- `03-control-json-proof.png`
