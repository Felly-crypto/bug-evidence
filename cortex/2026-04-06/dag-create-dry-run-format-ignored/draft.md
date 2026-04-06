# [BUG] [v0.0.7] dag create --dry-run ignores --format json and still prints plain text

## Repro Steps
1. Save a valid DAG spec file.
2. Run `cortex dag create --file <spec> --dry-run --format json --color never`.
3. Compare with `cortex dag create --file <spec> --id dag-format-control-4 --format json --color never`.

## Actual Result
The dry-run path prints plain text (`[OK] DAG is valid (2 tasks)`) even though `--format json` was requested.

## Expected Result
`--format json` should return JSON output, consistent with the normal create path and with the command's documented format option.

## Evidence
- Help / format option: `01-help-proof.png`
- Failing dry-run request: `02-dry-run-json-proof.png`
- Control JSON output: `03-control-json-proof.png`

## Duplicate Check
Searched live on 2026-04-06 for:
- `dag create dry run json`
- `dag create output format`
- `dag create format ignored`
- `DAG is valid task_count json`
No matching older issue was found.
