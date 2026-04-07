## Summary
`cortex logs --clear --keep-days 1` deletes unrelated non-log files from the logs directory.

## Version
- Runtime: `cortex 0.0.7 (ac6398e 2026-02-05)`
- Current local source HEAD inspected: `7954d02`

## Steps To Reproduce
1. Create `%LOCALAPPDATA%\cortex\logs\clear-proof-20260407.log`
2. Create `%LOCALAPPDATA%\cortex\logs\clear-proof-20260407.md`
3. Set both files older than 1 day
4. Run `cortex logs --clear --keep-days 1 --color never`

## Actual Result
Cortex reports `Cleared 2 log file(s)` and removes both files, including the unrelated `.md` file.

## Expected Result
`logs --clear` should only delete actual log files.

## Evidence
![before-run-after](https://raw.githubusercontent.com/Felly-crypto/bug-evidence/main/cortex/2026-04-07/logs-clear-deletes-non-log-files/01-before-run-after.png)

## Code Match
- Normal log discovery only treats `.log` and `.txt` files as logs in `src/cortex-cli/src/logs_cmd.rs:118`.
- The clear branch removes any file older than the cutoff without checking the extension in `src/cortex-cli/src/logs_cmd.rs:331-337`.

## Duplicate Check
I checked:
- `logs --clear non-log file`
- `clear old log files deletes non-log`
- `logs clear markdown file`
- `logs clear extension filter`

Closest older issues reviewed:
- `#44102`
- `#44939`
- `#45905`

These older issues cover `debug.txt` discovery/path inconsistencies, not `logs --clear` deleting unrelated non-log files.
