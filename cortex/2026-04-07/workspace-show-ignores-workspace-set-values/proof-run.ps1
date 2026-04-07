$tmp = 'C:\tmp-workspace-proof-20260407b'
Remove-Item -Recurse -Force $tmp -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $tmp | Out-Null
Push-Location $tmp
cortex workspace init --color never
cortex workspace set model claude-sonnet-test --color never
cortex workspace set sandbox workspace-write --color never
cortex workspace set approval low --color never
Write-Host '---SHOW---'
cortex workspace show --color never
Write-Host '---JSON---'
cortex workspace show --json --color never
Write-Host '---CONFIG---'
Get-Content '.cortex\config.toml'
Pop-Location
