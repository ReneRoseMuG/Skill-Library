# pm-workflow-skills

Claude-Code-Plugin: Projekt-Manager-MCP-Zugriff + die technologiestack-unabhängigen
Workflow-Skills, die in jedem Repo mit Projekt-Manager-Anbindung gleich sein sollen.

## Enthält

- **MCP-Server** `projekt-manager` (`.mcp.json`) — HTTP-Verbindung zur lokal laufenden Projekt-Manager-App.
- **Skills:** `projekt-manager` (Basiszugriff), `projekt-setup` (Projekt-Einrichtung, s. u.),
  `mcp-code-auftrag` (Arbeitsauftrags-Orchestrierung),
  `documentation` (Wiki/Anwenderdoku), `specification` (Feature-/Use-Case-Redaktion),
  `feature-editorial` (redaktionelle Aufbereitung), `tagebuch` (Projekt-Tagebuch).
- **Stop-Hook** `session-log-reminder.sh` — erinnert am Ende jeder Sitzung ans Kommentar-Logging,
  auch ohne genannte PM-Referenz.
- **Referenz** `reference/` — Ebene-1-Fassungen der Skills (`work-order.md`, `wiki-ablage.md`,
  `documentation/`, `specification/`) und unter `reference/setup/` der Ablauf plus die Vorlagen
  der Projekt-Einrichtung.

## Projekt-Einrichtung

Der Skill `projekt-setup` bindet einen Arbeitskontext dauerhaft an ein Projekt des Projekt
Managers: fragt `PROJ-<id>` und Wiki-Wurzelseite ab, verifiziert beides per MCP, schreibt die
Bindungsdateien, stellt Skills bereit, ergänzt die Projektverfassung und loggt einen
Startkommentar. Er kennt zwei Kontexte:

| Kontext | Bindung | Skills | Verfassung |
|---|---|---|---|
| Repo (Claude Code) | `docs/projekt-kontext.md`, `.claude/project-context/wiki.md` | dieses Plugin (+ optional `dev-testing-skills`) per `settings.json` + SessionStart-Hook | Abschnitt in `agents.md`/`CLAUDE.md` |
| Claude-Projekt (Cowork) | Projekt-Doc `claude/projekt-kontext.md` | Account-Skill `pm-workflow` (Vorlage `reference/setup/cowork-skill-pm-workflow.md`) | Abschnitt in den Projektanweisungen |

Einstieg ohne installiertes Plugin — von jedem Arbeitsplatz: `templates/projekt-setup.md`
im Wurzelverzeichnis der Bibliothek (per GitHub-Raw-URL oder lokalem Klon an eine Sitzung
übergeben).

Der Cowork-Skill `pm-workflow` ist das Gegenstück zu diesem Plugin für Claude-Projekte:
gleiche Regeln (Kontext laden, Meilensteine/Aufgaben, Log-Pflicht, Wiki, Tagebuch), aber
ohne Plugin-Mechanik und ohne Stop-Hook — der Sitzungsabschluss wird dort über
„Sitzung abschließen" ausgelöst. Änderungen an den Regeln zuerst hier im Plugin, dann in
der Vorlage nachziehen (Vorlagenversion hochzählen).

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
