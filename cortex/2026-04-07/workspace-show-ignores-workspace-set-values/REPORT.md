# Workspace Show Ignores Workspace Set Values

Runtime tested:
- `cortex 0.0.7 (ac6398e 2026-02-05)`

Current local source inspected:
- `CortexLM/cortex` HEAD `7954d02`

Candidate title:
- `[BUG] [v0.0.7] workspace show ignores values written by workspace set`

Repro:
1. Create a clean folder outside any parent `.cortex` or `.git`
2. Run `cortex workspace init`
3. Run `cortex workspace set model claude-sonnet-test`
4. Run `cortex workspace set sandbox workspace-write`
5. Run `cortex workspace set approval low`
6. Run `cortex workspace show`
7. Run `cortex workspace show --json`

Actual:
- `workspace set` writes real values into `.cortex/config.toml`
- `workspace show` does not print the `Workspace Settings` section at all
- `workspace show --json` returns `"settings": null`

Expected:
- `workspace show` should surface the saved model, sandbox, and approval values that were just written by `workspace set`

Evidence:
- `01-show-null.png`
- `02-config-values.png`

Why this is real:
- `workspace show` deserializes the file into a flat `WorkspaceSettings` struct with top-level `model`, `sandbox_mode`, and `approval_mode` fields
- `workspace set` writes those values into nested TOML tables (`[model].default`, `[sandbox].mode`, `[approval].mode`)
- The two commands therefore disagree about the config shape

Code refs:
- `src/cortex-cli/src/workspace_cmd.rs:90`
- `src/cortex-cli/src/workspace_cmd.rs:157`
- `src/cortex-cli/src/workspace_cmd.rs:221`
- `src/cortex-cli/src/workspace_cmd.rs:348`
- `src/cortex-cli/src/workspace_cmd.rs:349`
- `src/cortex-cli/src/workspace_cmd.rs:350`
- `src/cortex-cli/src/workspace_cmd.rs:351`

Duplicate sweep run on 2026-04-07:
- `workspace show settings null`
- `workspace show ignores model sandbox approval`
- `workspace set model workspace show not displayed`
- `workspace show ignores config.toml`

Closest older issues checked:
- `#17444`
- `#46945`
- `#46952`

Why it is not the same family:
- Those issues are about workspace root resolution and where `.cortex` is created
- This candidate is about `workspace show` failing to display settings that `workspace set` wrote successfully in the current workspace
