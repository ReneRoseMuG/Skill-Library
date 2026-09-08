# Aufgabe: Projekt einrichten (Projekt-Manager-Anbindung)

Diese Datei ist ein Arbeitsauftrag für eine Claude-Sitzung. Sie liegt im Repo und ist
damit von jedem Arbeitsplatz erreichbar. Aufruf:

```
Lies https://raw.githubusercontent.com/ReneRoseMuG/Skill-Library/main/templates/projekt-setup.md
und führe die Einrichtung aus.
```

(oder der Pfad `templates/projekt-setup.md` in einem lokalen Klon der Skill Library)

## Was eingerichtet wird

Der aktuelle Arbeitskontext — ein Repo (Claude Code) oder ein Claude-Projekt (Cowork) —
wird dauerhaft an ein Projekt des Projekt Managers gebunden:

- Projekt-ID (`PROJ-<id>`, Pflicht) und Wiki-Wurzelseite (falls vorhanden) werden abgefragt
  und per MCP verifiziert; Standard-Log-Ziel wird festgelegt.
- Der Arbeitsplatz wird erfasst: Gerätename dieses Rechners, lokaler Pfad des
  Nextcloud-Datenordners, lokaler Klon-Pfad des Repos (falls vorhanden) — jeder Pfad wird
  auf diesem Rechner geprüft. Je Rechner eine Zeile in der Tabelle „Arbeitsplätze".
- Die Bindung wird geschrieben: Repo → `docs/projekt-kontext.md` und
  `.claude/project-context/wiki.md`; Claude-Projekt → Projekt-Doc `claude/projekt-kontext.md`
  (Master). Zusätzlich ein Spiegel `projekt-kontext.md` im Datenordner, der über Nextcloud
  alle Rechner erreicht.
- Skills werden bereitgestellt: Repo → Plugins `pm-workflow-skills` (und optional
  `dev-testing-skills`) samt SessionStart-Hook; Claude-Projekt → Account-Skill `pm-workflow`.
- Projektverfassung (`agents.md`/`CLAUDE.md`) bzw. Projektanweisungen bekommen den Abschnitt
  „Projekt-Manager-Anbindung".
- Ein Startkommentar wird im Projekt geloggt — der Steckbrief des Projekts im gemeinsamen
  Gedächtnis.

Danach gilt in diesem Kontext: Logs als Kommentare, Arbeitspakete als Meilensteine und
Aufgaben, Spezifikation und Doku im Wiki.

**Zweiter Rechner:** derselbe Auftrag. Die Sitzung erkennt, dass die Bindung schon existiert
und nur der Gerätename fehlt, fragt Datenordner- und Repo-Pfad für diesen Rechner ab und
ergänzt die Zeile — IDs werden nicht erneut abgefragt.

## Anweisung an die Sitzung

1. **Kontext feststellen:** Claude Code in einem Repo (A) oder Claude-Projekt in Cowork (B)?
   Unklar → fragen, nicht raten.

2. **A, Plugin bereits installiert** (Skill `projekt-setup` ist in der Skill-Liste):
   den Skill ausführen. Fertig.

   **A, Plugin fehlt:** zuerst installieren

   ```bash
   claude plugin marketplace add ReneRoseMuG/Skill-Library
   claude plugin install pm-workflow-skills@skill-library
   ```

   dann den Skill `projekt-setup` ausführen (ggf. in einer neuen Sitzung, falls die
   Skill-Liste nicht sofort aktualisiert wird). Schlägt die Installation fehl: den Ablauf
   direkt aus der Referenz ausführen (Punkt 3).

   **B:** den Ablauf direkt aus der Referenz ausführen (Punkt 3).

3. **Referenz und Vorlagen** — Basis `https://raw.githubusercontent.com/ReneRoseMuG/Skill-Library/main/`
   (oder derselbe Pfad im lokalen Klon):

   | Datei | Zweck |
   |---|---|
   | `plugins/pm-workflow-skills/reference/setup/projekt-setup.md` | **Ablauf** — vollständig lesen und befolgen |
   | `plugins/pm-workflow-skills/reference/setup/projekt-kontext-template.md` | Bindungsdatei (`docs/projekt-kontext.md` bzw. Projekt-Doc) |
   | `plugins/pm-workflow-skills/reference/setup/wiki-kontext-template.md` | `.claude/project-context/wiki.md` (nur A, nur mit Wiki) |
   | `plugins/pm-workflow-skills/reference/setup/agents-abschnitt-projekt-manager.md` | Abschnitt für `agents.md`/`CLAUDE.md` (nur A) |
   | `plugins/pm-workflow-skills/reference/setup/projektanweisungen-cowork.md` | Text für die Projektanweisungen (nur B) |
   | `plugins/pm-workflow-skills/reference/setup/cowork-skill-pm-workflow.md` | Account-Skill `pm-workflow` (nur B) |
   | `templates/settings-snippet.md`, `templates/ensure-plugins.sh` | Plugin-Installation im Repo (nur A) |

   Vorlagen werden gelesen und mit den abgefragten Werten befüllt — nicht aus dem
   Gedächtnis nachgebaut.

4. **Voraussetzung:** Die Projekt-Manager-App läuft und der MCP ist erreichbar
   (A: Plugin-MCP `http://127.0.0.1:3010/mcp`; B: MCP-Server `projekt-manager` in der
   Claude-Desktop-App registriert). Der erste Schritt des Ablaufs ist der Verbindungstest —
   ohne Verbindung wird nichts geschrieben.
