@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\DELL\Desktop\ClaudeFelly\tmp-felly-bug-evidence\cortex\2026-04-07\logs-paths-includes-non-log-files\setup-proof.ps1"
echo.
echo RUN cortex logs --color never
cortex logs --color never
echo.
echo RUN cortex logs --paths --color never
cortex logs --paths --color never
