# Logs Clear Deletes Non-Log Files

Runtime tested:
- `cortex 0.0.7 (ac6398e 2026-02-05)`

Current local source inspected:
- `CortexLM/cortex` HEAD `7954d02`

Candidate title:
- `[BUG] [v0.0.7] logs --clear deletes non-log files from the logs directory`

Repro:
1. Create `%LOCALAPPDATA%\cortex\logs\clear-proof-20260407.log`
2. Create `%LOCALAPPDATA%\cortex\logs\clear-proof-20260407.md`
3. Set both files older than 1 day
4. Run `cortex logs --clear --keep-days 1 --color never`

Actual:
- Cortex reports `Cleared 2 log file(s)` and deletes both the real `.log` file and the unrelated `.md` file.

Expected:
- `logs --clear` should only delete actual log files, matching the extension filtering used by the normal `logs` read path.

Evidence:
- `01-before-run-after.png`

Why this is real:
- The normal log reader filters for `.log` and `.txt` before treating files as logs.
- The clear path removes every file older than the cutoff without any extension filter.

Code refs:
- `src/cortex-cli/src/logs_cmd.rs:118`
- `src/cortex-cli/src/logs_cmd.rs:331`
- `src/cortex-cli/src/logs_cmd.rs:337`

Duplicate sweep run on 2026-04-07:
- `logs --clear non-log file`
- `clear old log files deletes non-log`
- `logs clear markdown file`
- `logs clear extension filter`

Closest older issues checked:
- `#44102`
- `#44939`
- `#45905`

Why it is not the same family:
- Those older issues are about `debug.txt` discovery and path disagreements.
- This candidate is about `logs --clear` deleting unrelated non-log files inside the logs directory.
