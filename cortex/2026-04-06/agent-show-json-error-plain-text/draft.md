# [BUG] [v0.0.7] agent show --json returns plain-text error for missing agents

## Repro Steps
1. Run `cortex agent show does-not-exist --json --color never`.
2. Compare with `cortex agent show architect --json --color never`.

## Actual Result
The missing-agent path returns plain text:
`Error: Agent 'does-not-exist' not found`

## Expected Result
When `--json` is requested, the missing-agent error path should also return JSON output.

## Evidence
- `01-help-proof.png`
- `02-missing-agent-json-proof.png`
- `03-control-json-proof.png`
