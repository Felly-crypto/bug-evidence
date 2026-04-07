## Summary
`cortex logs --paths` lists unrelated non-log files from the logs directory.

## Version
- Runtime: `cortex 0.0.7 (ac6398e 2026-02-05)`
- Current local source HEAD inspected: `7954d02`

## Steps To Reproduce
1. Create `%LOCALAPPDATA%\cortex\logs\paths-proof-20260407.log`
2. Create `%LOCALAPPDATA%\cortex\logs\paths-proof-20260407.md`
3. Run `cortex logs --color never`
4. Run `cortex logs --paths --color never`

## Actual Result
`cortex logs` reads only `paths-proof-20260407.log`, but `cortex logs --paths` lists both `paths-proof-20260407.log` and `paths-proof-20260407.md` as log files.

## Expected Result
`logs --paths` should only list actual log files, matching the extension filtering used by the normal `logs` command.

## Evidence
![proof](https://raw.githubusercontent.com/Felly-crypto/bug-evidence/main/cortex/2026-04-07/logs-paths-includes-non-log-files/01-proof.png)

## Code Match
- Normal log discovery only includes `.log` and `.txt` in `src/cortex-cli/src/logs_cmd.rs:118`.
- `run_paths()` pushes any file in the logs directory without an extension check in `src/cortex-cli/src/logs_cmd.rs:268-280`.

## Duplicate Check
I checked:
- `logs --paths non-log file`
- `logs paths markdown file`
- `Show log file paths instead of content non-log`
- `logs --paths debug.txt`

Closest older issues reviewed:
- `#44102`
- `#44939`
- `#45905`
- `#48867`

These older issues cover `debug.txt` handling, folder-path disagreement, and `logs --clear` deletion scope, not `logs --paths` listing unrelated non-log files.
