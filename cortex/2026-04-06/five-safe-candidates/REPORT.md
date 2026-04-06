# Five Safe Candidate Report (2026-04-06)

All five candidates below have:
- screenshot evidence
- public raw image links once this folder is pushed
- real CLI-visible output
- code references matching the behavior
- a fresh duplicate sweep that did not find an older issue owning the same visible failure

## 1. github status marks an unrelated workflow as Cortex-installed
- Surface: `cortex github status --json`
- Evidence image: `01-github-status-wrong-workflow.png`
- Transcript: `01-github-status-wrong-workflow.txt`
- Closest issues checked: `#14618`, `#46651`
- Why it looks unique: those are about env vars and token help text; this one is status misdetection of an unrelated workflow file
- Code match: `src/cortex-cli/src/github_cmd.rs:594-603`

## 2. debug config prints a mixed-separator local path on Windows
- Surface: `cortex debug config`
- Evidence image: `02-debug-config-mixed-separators.png`
- Transcript: `02-debug-config-mixed-separators.txt`
- Closest issues checked: no direct matches for `debug config` mixed separators / `.cortex/config.toml` on Windows
- Why it looks unique: this is the local-config display path itself using `.cortex/config.toml` inside Windows output
- Code match: `src/cortex-cli/src/debug_cmd/handlers/config.rs:36-38`

## 3. completion powershell --install targets the wrong profile root for Windows PowerShell
- Surface: `cortex completion powershell --install`
- Evidence image: `03-completion-powershell-profile-path.png`
- Transcript: `03-completion-powershell-profile-path.txt`
- Closest issues checked: no direct matches for `completion powershell` + `WindowsPowerShell` profile mismatch
- Why it looks unique: the real shell profile is `Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`, but Cortex writes/points to `Documents/PowerShell/Microsoft.PowerShell_profile.ps1`
- Code match: `src/cortex-cli/src/cli/handlers.rs:461-470`

## 4. debug paths hides the full Temp path in the text output
- Surface: `cortex debug paths`
- Evidence image: `04-debug-paths-truncated-temp.png`
- Transcript: `04-debug-paths-truncated-temp.txt`
- Closest issues checked: no direct matches for `debug paths` truncated Temp path / ellipsis output
- Why it looks unique: the text command claims to show Cortex paths, but the Temp row is reduced to `...sers\DELL\AppData\Local\Temp\Cortex` while the JSON output shows the full path
- Code match: `src/cortex-cli/src/debug_cmd/handlers/paths.rs:105-111`

## 5. plugin new generates bash-only install commands on Windows
- Surface: `cortex plugin new <name>` plus generated `README.md`
- Evidence image: `05-plugin-new-bash-install-on-windows.png`
- Transcript: `05-plugin-new-bash-install-on-windows.txt`
- Closest issues checked: direct searches for Windows scaffold install commands / `~/.cortex/plugins` came back clean
- Why it looks unique: this is a Windows-specific scaffold output issue; I am not counting the already-mined obsolete `wasm32-wasi` target lane here
- Code match: `src/cortex-cli/src/plugin_cmd.rs:800`, `src/cortex-cli/src/plugin_cmd.rs:918-920`
