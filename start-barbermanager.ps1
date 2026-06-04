# start-barbermanager.ps1
# Arranca a Horse API e o Cloudflare Tunnel em janelas PowerShell separadas.
# Executar na raiz do projecto: .\start-barbermanager.ps1

$Root = $PSScriptRoot

Write-Host ""
Write-Host "=== BarberManager ===" -ForegroundColor Cyan
Write-Host "A iniciar dois terminais..." -ForegroundColor White
Write-Host ""

# Terminal 1 — BarberManager API (porta 9000)
Start-Process powershell -ArgumentList "-NoExit", "-Command",
    "Set-Location '$Root'; Write-Host '--- BarberManager API ---' -ForegroundColor Cyan; .\BarberManagerAPI.exe"

Start-Sleep -Milliseconds 500

# Terminal 2 — Cloudflare Tunnel
Start-Process powershell -ArgumentList "-NoExit", "-Command",
    "Set-Location '$Root'; Write-Host '--- Cloudflare Tunnel ---' -ForegroundColor Yellow; .\cloudflared.exe tunnel --url http://localhost:9000"

Write-Host "Terminais abertos:" -ForegroundColor Green
Write-Host "  [1] BarberManagerAPI.exe  — http://localhost:9000" -ForegroundColor White
Write-Host "  [2] cloudflared           — a URL publica (trycloudflare.com) aparece no terminal do tunel" -ForegroundColor White
Write-Host ""
