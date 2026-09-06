# pm-workflow-skills

Claude-Code-Plugin: Projekt-Manager-MCP-Zugriff + die technologiestack-unabhängigen
Workflow-Skills, die in jedem Repo mit Projekt-Manager-Anbindung gleich sein sollen.

## Enthält

- **MCP-Server** `projekt-manager` (`.mcp.json`) — HTTP-Verbindung zur lokal laufenden Projekt-Manager-App.
- **Skills:** `projekt-manager` (Basiszugriff), `mcp-code-auftrag` (Arbeitsauftrags-Orchestrierung),
  `documentation` (Wiki/Anwenderdoku), `specification` (Feature-/Use-Case-Redaktion),
  `feature-editorial` (redaktionelle Aufbereitung), `tagebuch` (Projekt-Tagebuch).
- **Stop-Hook** `session-log-reminder.sh` — erinnert am Ende jeder Sitzung ans Kommentar-Logging,
  auch ohne genannte PM-Referenz.

## Verbindung

`.mcp.json` verbindet sich über HTTP mit `http://127.0.0.1:3010/mcp` — dem MCP-Server der
Projekt-Manager-App (`projekt-manager-mcp`). Verifiziert am 2026-09-06 gegen die laufende
Instanz. Nicht zu verwechseln mit `http://127.0.0.1:3001`: das ist die REST-API der App,
deren `/mcp`-Pfad eine Authentifizierung verlangt und für dieses Plugin nicht geeignet ist.

## Bewusst NICHT enthalten

`architektur`, `code-discipline`, `datenmodell`, `exploration`, `planungsleitplanken`,
`test-entwurfsleitplanken`, `test-quality-review`, `testing` — diese liegen im
separaten Plugin `dev-testing-skills` (siehe dessen README), nicht hier, weil sie
unabhängig vom Projekt-Manager-Zugriff installierbar sein sollen (z. B. in Repos ohne
Projekt-Manager-Anbindung). `leitfaden-pflege` bleibt projekteigen
(Projekt-Manager-spezifisches Leitfaden-Konzept, noch nicht generalisiert).

## Installation in einem Repo

```bash
claude plugin marketplace add ReneRoseMuG/Skill-Library
claude plugin install pm-workflow-skills@skill-library
```

Für automatische Installation auf jeder Maschine beim Öffnen des Repos: siehe
`templates/ensure-plugins.sh` und `templates/settings-snippet.md` im Wurzelverzeichnis
dieser Bibliothek.
