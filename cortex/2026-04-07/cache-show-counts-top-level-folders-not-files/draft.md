## Summary
`cortex cache show --json` counts top-level response folders instead of actual cached files.

## Version
- Runtime: `cortex 0.0.7 (ac6398e 2026-02-05)`
- Current local source HEAD inspected: `7954d02`

## Steps To Reproduce
1. Create `C:\Users\DELL\AppData\Local\cortex\responses\nested-proof-20260407\deep\proof-a.txt`
2. Create `C:\Users\DELL\AppData\Local\cortex\responses\nested-proof-20260407\deep\proof-b.txt`
3. Create `C:\Users\DELL\AppData\Local\cortex\responses\nested-proof-20260407\deep\proof-c.txt`
4. Run `cortex cache show --json`
5. Run `cortex cache list --json --limit 50`

## Actual Result
`cache show --json` reports the `responses` category with `"item_count": 1`, while `cache list --json` shows three nested response files in that same category.

## Expected Result
The `responses` item count in `cache show` should reflect cached files, not just the top-level folder entry.

## Evidence
![show-count](https://raw.githubusercontent.com/Felly-crypto/bug-evidence/main/cortex/2026-04-07/cache-show-counts-top-level-folders-not-files/01-show-count.png)

![list-files](https://raw.githubusercontent.com/Felly-crypto/bug-evidence/main/cortex/2026-04-07/cache-show-counts-top-level-folders-not-files/02-list-files.png)

## Code Match
- `cache show` uses `count_items(&path)` for per-category counts in `src/cortex-cli/src/cache_cmd.rs:201-204`.
- `count_items()` only counts direct directory entries in `src/cortex-cli/src/cache_cmd.rs:143-149`.
- `cache list` walks recursively in `src/cortex-cli/src/cache_cmd.rs:405-417`.

## Duplicate Check
I checked:
- `cache show item_count responses nested files`
- `cache show counts top-level directories instead of files`
- `cache show item count list contradiction`
- `responses item_count 1 cache show`

Closest older issues reviewed:
- `#45330`
- `#45661`

Those older issues cover root-level cache totals and `cache clear` scope. This issue is specifically about the per-category `item_count` in `cache show` not matching the actual cached files revealed by `cache list`.
