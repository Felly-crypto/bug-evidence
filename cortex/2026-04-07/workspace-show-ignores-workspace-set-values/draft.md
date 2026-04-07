## Summary
`cortex workspace show` ignores values that were just written by `cortex workspace set`.

## Version
- Runtime: `cortex 0.0.7 (ac6398e 2026-02-05)`
- Current local source HEAD inspected: `7954d02`

## Steps To Reproduce
1. Create a clean folder outside any parent `.cortex` or `.git`
2. Run `cortex workspace init`
3. Run `cortex workspace set model claude-sonnet-test`
4. Run `cortex workspace set sandbox workspace-write`
5. Run `cortex workspace set approval low`
6. Run `cortex workspace show`
7. Run `cortex workspace show --json`

## Actual Result
- `workspace set` writes real values into `.cortex/config.toml`
- `workspace show` does not display a `Workspace Settings` section
- `workspace show --json` returns `"settings": null`

## Expected Result
`workspace show` should display the saved model, sandbox, and approval settings written by `workspace set`.

## Evidence
![show-null](https://raw.githubusercontent.com/Felly-crypto/bug-evidence/main/cortex/2026-04-07/workspace-show-ignores-workspace-set-values/01-show-null.png)

![config-values](https://raw.githubusercontent.com/Felly-crypto/bug-evidence/main/cortex/2026-04-07/workspace-show-ignores-workspace-set-values/02-config-values.png)

## Code Match
- `workspace show` deserializes into flat fields in `src/cortex-cli/src/workspace_cmd.rs:90-96` and reads them in `src/cortex-cli/src/workspace_cmd.rs:157` and `src/cortex-cli/src/workspace_cmd.rs:221-227`.
- `workspace set` writes nested TOML tables in `src/cortex-cli/src/workspace_cmd.rs:348-351`.

## Duplicate Check
I checked:
- `workspace show settings null`
- `workspace show ignores model sandbox approval`
- `workspace set model workspace show not displayed`
- `workspace show ignores config.toml`

Closest older issues reviewed:
- `#17444`
- `#46945`
- `#46952`

Those older issues cover workspace root resolution. This issue is specifically about `workspace show` failing to display settings that `workspace set` wrote in the current workspace.
