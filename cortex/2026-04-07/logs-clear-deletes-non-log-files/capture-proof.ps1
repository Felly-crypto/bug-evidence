$base = "C:\Users\DELL\Desktop\ClaudeFelly\tmp-felly-bug-evidence\cortex\2026-04-07\logs-clear-deletes-non-log-files"
& 'C:\Users\DELL\Desktop\ClaudeFelly\evidence-tools\capture-cli-window.ps1' `
  -WindowTitle 'logs-clear-proof-20260407' `
  -WorkingDirectory 'C:\Users\DELL\Desktop\ClaudeFelly' `
  -Columns 160 `
  -Lines 50 `
  -LaunchDelayMs 4500 `
  -FocusDelayMs 800 `
  -CloseWindow `
  -OutputPath (Join-Path $base '01-before-run-after.png') `
  -ScriptLines @(
    "powershell -NoProfile -Command \"`$cache=[Environment]::GetFolderPath('LocalApplicationData'); `$logs=Join-Path `$cache 'cortex\\logs'; New-Item -ItemType Directory -Force -Path `$logs | Out-Null; `$md=Join-Path `$logs 'clear-proof-20260407.md'; `$log=Join-Path `$logs 'clear-proof-20260407.log'; Set-Content -Path `$md -Value 'not-a-log'; Set-Content -Path `$log -Value 'real-log'; `$old=(Get-Date).AddDays(-2); (Get-Item `$md).LastWriteTime=`$old; (Get-Item `$log).LastWriteTime=`$old; Write-Host BEFORE; Get-ChildItem `$logs | Where-Object {`$_.Name -like 'clear-proof-20260407*'} | Select-Object Name,Length,LastWriteTime | Format-Table -AutoSize\"",
    'echo.',
    'echo RUN cortex logs --clear --keep-days 1 --color never',
    'cortex logs --clear --keep-days 1 --color never',
    'echo.',
    "powershell -NoProfile -Command \"`$logs=Join-Path ([Environment]::GetFolderPath('LocalApplicationData')) 'cortex\\logs'; Write-Host AFTER; Get-ChildItem `$logs | Where-Object {`$_.Name -like 'clear-proof-20260407*'} | Select-Object Name,Length,LastWriteTime | Format-Table -AutoSize\""
  )
