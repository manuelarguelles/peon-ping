# peon-ping - Instalador en Español
# Instala peon-ping con los 3 personajes de Warcraft III en español latino:
#   - peon_es    : Peon Orco
#   - acolyte_es : Acolito Muertos Vivientes
#   - peasant_es : Campesino Humano
#
# También instala el hook de sonido de látigo al enviar prompts.
#
# Uso: powershell -File install-es.ps1

$ScriptDir = if ($PSScriptRoot) { $PSScriptRoot } else { $PWD.Path }
$ClaudeDir = "$env:USERPROFILE\.claude"

# 1. Instalar peon-ping con los packs en español
& "$ScriptDir\install.ps1" -Packs peon_es, acolyte_es, peasant_es

# 2. Copiar sonido de látigo
$soundsDir = "$ClaudeDir\sounds"
New-Item -ItemType Directory -Path $soundsDir -Force | Out-Null
Copy-Item "$ScriptDir\sounds\whip.wav" "$soundsDir\whip.wav" -Force
Write-Host "  Sonido de latigo instalado" -ForegroundColor DarkGray

# 3. Copiar hook de látigo
$hooksDir = "$ClaudeDir\hooks"
New-Item -ItemType Directory -Path $hooksDir -Force | Out-Null
Copy-Item "$ScriptDir\hooks\whip.ps1" "$hooksDir\whip.ps1" -Force
Write-Host "  Hook de latigo instalado" -ForegroundColor DarkGray

# 4. Registrar hook en settings.json
$settingsFile = "$ClaudeDir\settings.json"
$whipCommand  = "powershell -NoProfile -NonInteractive -File `"$hooksDir\whip.ps1`""

if (Test-Path $settingsFile) {
    $raw      = Get-Content $settingsFile -Raw
    $settings = $raw | ConvertFrom-Json
} else {
    $settings = [PSCustomObject]@{}
}

if (-not $settings.hooks) {
    $settings | Add-Member -NotePropertyName "hooks" -NotePropertyValue ([PSCustomObject]@{}) -Force
}

# Obtener o crear array de UserPromptSubmit
$ups = $settings.hooks.UserPromptSubmit
if (-not $ups) {
    $ups = @()
}

# Verificar si el hook ya está registrado
$alreadyRegistered = $ups | Where-Object {
    $_.hooks | Where-Object { $_.command -like "*whip.ps1*" }
}

if (-not $alreadyRegistered) {
    $newEntry = [PSCustomObject]@{
        matcher = ""
        hooks   = @([PSCustomObject]@{
            type    = "command"
            command = $whipCommand
            timeout = 3
        })
    }
    $ups = @($ups) + $newEntry
    $settings.hooks | Add-Member -NotePropertyName "UserPromptSubmit" -NotePropertyValue $ups -Force
    $settings | ConvertTo-Json -Depth 10 | Set-Content $settingsFile -Encoding UTF8
    Write-Host "  Hook de latigo registrado en settings.json" -ForegroundColor DarkGray
} else {
    Write-Host "  Hook de latigo ya estaba registrado" -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "=== install-es completado ===" -ForegroundColor Cyan
Write-Host "  Sonara un latigo cada vez que envies un prompt." -ForegroundColor Green
Write-Host "  Usa /personaje para cambiar entre peon, acolito y campesino." -ForegroundColor Green
