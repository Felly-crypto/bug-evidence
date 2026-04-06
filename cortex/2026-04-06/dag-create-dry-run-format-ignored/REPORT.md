# Fresh Hunt Report - 2026-04-06

## Safe Keepers

### 1. dag create --dry-run ignores --format json and still prints plain text
- Confidence: 86%
- Screenshot/video provided: Yes
- Images accessible: Yes
- Shows CLI/TUI interface: Yes
- Code matches description: Yes
- No duplicates found: Yes

Evidence:
- 01-help-proof.png
- 02-dry-run-json-proof.png
- 03-control-json-proof.png

Code match:
- `src/cortex-cli/src/dag_cmd/args.rs:73-78` exposes `--dry-run` and `--format`
- `src/cortex-cli/src/dag_cmd/commands.rs:30-33` returns early on `dry_run`
- `src/cortex-cli/src/dag_cmd/commands.rs:50-64` only applies `args.format` after that early return

Why this survived:
- The failing state is visible in the real CLI.
- The control state shows the same command family can emit JSON when not in dry-run mode.
- Live duplicate sweeps on 2026-04-06 came back clean.
