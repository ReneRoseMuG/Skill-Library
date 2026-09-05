#!/usr/bin/env bash
# Kommentar-Logging-Hinweis (Stop-Hook): erinnert am Ende JEDER Sitzung daran, relevante
# Arbeitsergebnisse, Entscheidungen oder Probleme als Projekt-Kommentar zu loggen — auch
# wenn kein PROJ/MS/TASK/TKT/FEAT/UC ausdruecklich genannt wurde. Ergaenzt die Logpflicht
# aus mcp-code-auftrag Schritt 5 (die nur bei erkannter PM-Referenz automatisch greift).
#
# Reines Bash, keine jq/python-Abhaengigkeit (gleiche Linie wie graphify-hint.sh /
# leitfaden-check.sh). Once-Guard pro Sitzung, damit nicht in jedem Turn erneut erinnert wird.

INPUT=$(cat)

# Endlosschleife vermeiden: wenn wir bereits aus einem Stop-Hook fortsetzen, nichts tun.
case "$INPUT" in *'"stop_hook_active":true'*) exit 0 ;; esac

SID=$(printf '%s' "$INPUT" | sed -n 's/.*"session_id"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')
[ -z "$SID" ] && SID="nosession"

# Marker-Verzeichnis: bevorzugt .git/, sonst .claude/ im aktuellen Arbeitsverzeichnis.
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  MARK_DIR=".git/pm-log-hook"
else
  MARK_DIR=".claude/pm-log-hook"
fi
mkdir -p "$MARK_DIR" 2>/dev/null

MARK_FILE="$MARK_DIR/$SID"
[ -f "$MARK_FILE" ] && exit 0
: > "$MARK_FILE" 2>/dev/null

{
  printf 'Kommentar-Logging (pm-workflow-skills): Pruefe vor Abschluss dieser Sitzung, ob'
  printf ' relevante Arbeitsergebnisse, Entscheidungen oder Probleme als Projekt-Kommentar'
  printf ' geloggt gehoeren — auch ohne genannte PROJ/MS/TASK/TKT/FEAT/UC-Referenz.\n'
  printf 'Ziel: das projektweite Standard-Log-Ziel aus docs/projekt-kontext.md (falls vorhanden)'
  printf ' via add_comment_to_parent (Skill projekt-manager).\n'
  printf 'Nichts zu loggen (reine Lektuere, keine Ergebnisse/Entscheidungen/Probleme)? Dann kurz'
  printf ' begruenden und ohne weitere Aktion abschliessen.\n'
} 1>&2
exit 2
