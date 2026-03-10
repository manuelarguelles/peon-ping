---
name: personaje
description: Switch peon-ping voice pack between Spanish Warcraft III characters. Use when user wants to change between the three Spanish voice packs. Accepts Spanish aliases (peon/orco, acolito, campesino) and pack names (peon_es, acolyte_es, peasant_es).
user-invocable: true
---

# /personaje

Switch the active peon-ping voice pack between the three Warcraft III Spanish characters.

## Available characters

| Alias | Pack | Character |
|---|---|---|
| `peon`, `orco`, `peon_es` | `peon_es` | Orc Peon (ES) |
| `acolito`, `acolyte`, `acolyte_es` | `acolyte_es` | Undead Acolyte (ES) |
| `campesino`, `peasant`, `peasant_es` | `peasant_es` | Human Peasant (ES) |

## Usage

```
/personaje peon
/personaje acolito
/personaje campesino
```

Without an argument, shows the currently active character and available options.

## Prerequisites

The three Spanish packs must be installed. Install them with:

```bash
# Unix/WSL2
bash install.sh --packs=peon_es,acolyte_es,peasant_es

# Native Windows
powershell -File install.ps1 -Packs peon_es,acolyte_es,peasant_es
```

## Execution instructions

### 1. Parse the argument

Extract the character from the user's message and map aliases to pack names:
- `peon` / `orco` / `peon_es` → `peon_es`
- `acolito` / `acolyte` / `acolyte_es` → `acolyte_es`
- `campesino` / `peasant` / `peasant_es` → `peasant_es`

### 2. No argument — show current status

If the user types `/personaje` with no argument, run:

**Unix/WSL2:**
```bash
bash "${CLAUDE_CONFIG_DIR:-$HOME/.claude}/hooks/peon-ping/peon.sh" --status
```

**Windows:**
```powershell
powershell -Command "& { . '$env:USERPROFILE\.claude\hooks\peon-ping\peon.ps1' --status }"
```

Then display the available characters table.

### 3. Switch character

**Unix/WSL2:**
```bash
bash "${CLAUDE_CONFIG_DIR:-$HOME/.claude}/hooks/peon-ping/peon.sh" --pack PACK_NAME
```

**Windows:**
```powershell
powershell -Command "& { . '$env:USERPROFILE\.claude\hooks\peon-ping\peon.ps1' --pack PACK_NAME }"
```

Replace `PACK_NAME` with `peon_es`, `acolyte_es`, or `peasant_es`.

### 4. Confirm to user

Reply with:

```
Personaje cambiado a: Peon Orco (peon_es)
```

Use the friendly character name, not just the pack name.

## Error handling

- **Unrecognized alias**: Show the alias table and ask the user to pick a valid one.
- **Pack not installed**: Tell the user to install the pack first with `install.sh --packs=PACK_NAME` (Unix) or `install.ps1 -Packs PACK_NAME` (Windows).
- **Command error**: Report the error and suggest running `peon --pack peon_es` manually.
