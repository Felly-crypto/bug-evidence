$cache = [Environment]::GetFolderPath("LocalApplicationData")
$logs = Join-Path $cache 'cortex\logs'
New-Item -ItemType Directory -Force -Path $logs | Out-Null
Get-ChildItem $logs -Force -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -like 'paths-proof-20260407*' -or $_.Name -like 'proof-20260406*' -or $_.Name -like 'note-20260406*' } |
  Remove-Item -Force -ErrorAction SilentlyContinue
$md = Join-Path $logs 'paths-proof-20260407.md'
$log = Join-Path $logs 'paths-proof-20260407.log'
Set-Content -Path $md -Value 'markdown-proof'
Set-Content -Path $log -Value 'log-proof'
Write-Host BEFORE
Get-ChildItem $logs | Where-Object { $_.Name -like 'paths-proof-20260407*' } | Select-Object Name,Length | Format-Table -AutoSize
