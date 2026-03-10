# Hook: reproduce sonido de latigo al enviar un prompt
# UserPromptSubmit hook - se ejecuta cada vez que el usuario presiona Enter

$soundFile = "$env:USERPROFILE\.claude\sounds\whip.wav"
$winPlay   = "$env:USERPROFILE\.claude\hooks\peon-ping\scripts\win-play.ps1"

if ((Test-Path $soundFile) -and (Test-Path $winPlay)) {
    Start-Process powershell -ArgumentList "-NoProfile -NonInteractive -File `"$winPlay`" -path `"$soundFile`" -vol 0.7" -WindowStyle Hidden
}

'{"continue": true}' | Write-Output
