# Cache Show Counts Top-Level Folders Instead of Cached Files

Runtime tested:
- `cortex 0.0.7 (ac6398e 2026-02-05)`

Current local source inspected:
- `CortexLM/cortex` HEAD `7954d02`

Candidate title:
- `[BUG] [v0.0.7] cache show counts top-level response folders instead of cached files`

Repro:
1. Create `C:\Users\DELL\AppData\Local\cortex\responses\nested-proof-20260407\deep\proof-a.txt`
2. Create `C:\Users\DELL\AppData\Local\cortex\responses\nested-proof-20260407\deep\proof-b.txt`
3. Create `C:\Users\DELL\AppData\Local\cortex\responses\nested-proof-20260407\deep\proof-c.txt`
4. Run `cortex cache show --json`
5. Run `cortex cache list --json --limit 50`

Actual:
- `cache show --json` reports the `responses` category with `"item_count": 1`
- `cache list --json` shows three nested response files in that same category

Expected:
- The `responses` item count in `cache show` should reflect cached files, not just the top-level folder entry

Evidence:
- `01-show-count.png`
- `02-list-files.png`

Why this is real:
- `run_show()` uses `count_items(&path)` for category counts
- `count_items()` only counts direct directory entries with `read_dir(...).count()`
- Size is computed recursively, and `cache list` also walks recursively, so the category count disagrees with the actual cached files shown elsewhere

Code refs:
- `src/cortex-cli/src/cache_cmd.rs:143`
- `src/cortex-cli/src/cache_cmd.rs:201`
- `src/cortex-cli/src/cache_cmd.rs:204`
- `src/cortex-cli/src/cache_cmd.rs:405`

Duplicate sweep run on 2026-04-07:
- `cache show item_count responses nested files`
- `cache show counts top-level directories instead of files`
- `cache show item count list contradiction`
- `responses item_count 1 cache show`

Closest older issues checked:
- `#45330`
- `#45661`

Why it is not the same family:
- Those older issues are about root-level cache bytes and totals not being accounted for by `cache clear` / `cache show`
- This candidate is about the per-category `item_count` in `cache show` counting only top-level directory entries instead of the actual cached files that `cache list` reveals
