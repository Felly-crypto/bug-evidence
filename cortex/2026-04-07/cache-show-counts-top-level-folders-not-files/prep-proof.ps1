$cache = Join-Path ([Environment]::GetFolderPath(''LocalApplicationData'')) ''cortex''
$resp = Join-Path $cache ''responses\nested-proof-20260407''
$sub = Join-Path $resp ''deep''
New-Item -ItemType Directory -Force -Path $sub | Out-Null
Set-Content -Path (Join-Path $sub ''proof-a.txt'') -Value ''A''
Set-Content -Path (Join-Path $sub ''proof-b.txt'') -Value ''B''
Set-Content -Path (Join-Path $sub ''proof-c.txt'') -Value ''C''
