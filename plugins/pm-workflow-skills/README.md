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

## Vor der ersten Nutzung prüfen

`.mcp.json` nimmt aktuell `http://127.0.0.1:3001/mcp` an (HTTP-Transport, Port aus den
bestehenden Projekt-Manager-Konfigurationen übernommen). **Den genauen Pfad/Port gegen die
tatsächlich laufende Projekt-Manager-MCP-Server-Instanz prüfen und bei Abweichung anpassen** —
das war beim Anlegen dieses Plugins nicht unabhängig verifizierbar.

## Bewusst NICHT enthalten

`architektur`, `code-discipline`, `datenmodell`, `exploration`, `planungsleitplanken`,
`test-entwurfsleitplanken`, `test-quality-review`, `testing` — diese hängen am jeweiligen
Technologiestack des Repos und bleiben projekteigene Skills unter `.claude/skills/`. Ihre
gemeinsame Wissensquelle liegt in dieser Bibliothek unter `dev-testing/`. `leitfaden-pflege`
bleibt ebenfalls projekteigen (Projekt-Manager-spezifisches Leitfaden-Konzept).

## Installation in einem Repo

```bash
claude plugin marketplace add ReneRoseMuG/Skill-Library
claude plugin install pm-workflow-skills@skill-library
```

Für automatische Installation auf jeder Maschine beim Öffnen des Repos: siehe
`templates/ensure-plugins.sh` und `templates/settings-snippet.md` im Wurzelverzeichnis
dieser Bibliothek.
