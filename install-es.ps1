# peon-ping - Instalador en Español
# Instala peon-ping con los 3 personajes de Warcraft III en español latino:
#   - peon_es    : Peon Orco
#   - acolyte_es : Acolito Muertos Vivientes
#   - peasant_es : Campesino Humano
#
# Uso: powershell -File install-es.ps1

$ScriptDir = if ($PSScriptRoot) { $PSScriptRoot } else { $PWD.Path }

& "$ScriptDir\install.ps1" -Packs peon_es, acolyte_es, peasant_es
