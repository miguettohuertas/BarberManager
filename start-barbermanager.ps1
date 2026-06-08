# start-barbermanager.ps1
# Arranca a Horse API e o ngrok Tunnel em janelas PowerShell separadas.
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

# Terminal 2 — ngrok Tunnel (dominio fixo permanente)
Start-Process powershell -ArgumentList "-NoExit", "-Command",
    "Set-Location '$Root'; Write-Host '--- ngrok Tunnel ---' -ForegroundColor Yellow; .\ngrok.exe http --url=humid-boots-posted.ngrok-free.dev 9000"

Write-Host "Terminais abertos:" -ForegroundColor Green
Write-Host "  [1] BarberManagerAPI.exe  — http://localhost:9000" -ForegroundColor White
Write-Host "  [2] ngrok                 — https://humid-boots-posted.ngrok-free.dev" -ForegroundColor White
Write-Host ""
