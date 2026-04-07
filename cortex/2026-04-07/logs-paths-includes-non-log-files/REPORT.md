# Logs Paths Includes Non-Log Files

Runtime tested:
- `cortex 0.0.7 (ac6398e 2026-02-05)`

Current local source inspected:
- `CortexLM/cortex` HEAD `7954d02`

Candidate title:
- `[BUG] [v0.0.7] logs --paths lists non-log files from the logs directory`

Repro:
1. Create `%LOCALAPPDATA%\cortex\logs\paths-proof-20260407.log`
2. Create `%LOCALAPPDATA%\cortex\logs\paths-proof-20260407.md`
3. Run `cortex logs --color never`
4. Run `cortex logs --paths --color never`

Actual:
- `cortex logs` reads only the `.log` file.
- `cortex logs --paths` lists both the `.log` and the unrelated `.md` file as if they were log files.

Expected:
- `logs --paths` should use the same log-file filtering as the normal `logs` read path and exclude unrelated file types.

Evidence:
- `01-proof.png`

Why this is real:
- The normal log reader filters for `.log` and `.txt` before treating files as logs.
- The `run_paths` branch pushes every file in the logs directory into the output without checking the extension.

Code refs:
- `src/cortex-cli/src/logs_cmd.rs:118`
- `src/cortex-cli/src/logs_cmd.rs:268`
- `src/cortex-cli/src/logs_cmd.rs:280`

Duplicate sweep run on 2026-04-07:
- `logs --paths non-log file`
- `logs paths markdown file`
- `Show log file paths instead of content non-log`
- `logs --paths debug.txt`

Closest older issues checked:
- `#44102`
- `#44939`
- `#45905`
- `#48867`

Why it is not the same family:
- `#44102` and `#44939` are about `debug.txt` discovery and clear behavior.
- `#45905` is about the folder path reported by `logs --paths` versus `debug paths`.
- `#48867` is about `logs --clear` deleting all file types.
- This candidate is specifically about `logs --paths` displaying unrelated non-log files.
