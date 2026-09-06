# dev-testing-skills

Claude-Code-Plugin: Architektur-, Datenmodell-, Exploration-, Code-Disziplin-,
Planungs- und Test-Gate-Skills, technologiestack-generisch formuliert. Für Repos
gedacht, die technisch gleichartig sind — geschichtetes TypeScript-Backend + Frontend
+ ORM (z. B. TanStack Query, Drizzle ORM) — auch wenn die konkrete Ordnerstruktur
abweicht (Monorepo mit npm-Workspaces vs. Single-Package, mit oder ohne eigene
Controller-Schicht, unterschiedliche Datenbanktypen).

## Enthält

- **Skills:** `architektur`, `code-discipline`, `datenmodell`, `exploration`,
  `planungsleitplanken`, `test-entwurfsleitplanken`, `test-quality-review`, `testing`.

Alle acht Skills enthalten keine repo-spezifischen Pfade, Bibliotheken oder Kommandos
mehr direkt — sie verweisen stattdessen auf `.claude/project-context/tech-stack.md`
im jeweiligen Repo.

## Voraussetzung in jedem Repo: `tech-stack.md`

Jedes Repo, das dieses Plugin nutzt, braucht unter `.claude/project-context/tech-stack.md`
eine ausgefüllte Kopie der Vorlage aus `reference/tech-stack-template.md` dieses
Plugins. Dort stehen: Schichten-Tabelle, State-Management, UI-Komponenten, Datenbank,
Tests, Domänen-Abdeckung, Analysewerkzeuge, Auth & Rollen, Git-Kurzkommandos und
sonstige verbindliche Referenzdokumente. Ohne diese Datei können die Skills nur allgemein
bleiben und müssen an vielen Stellen nachfragen statt nachzuschlagen.

## Bewusst NICHT enthalten

`projekt-manager`, `mcp-code-auftrag`, `documentation`, `specification`,
`feature-editorial`, `tagebuch` — diese liegen im separaten Plugin `pm-workflow-skills`,
weil sie unabhängig vom konkreten Technologiestack sind und auch in Repos ohne diesen
Stack gelten. `leitfaden-pflege` bleibt projekteigen.

## Installation in einem Repo

```bash
claude plugin marketplace add ReneRoseMuG/Skill-Library
claude plugin install dev-testing-skills@skill-library
```

Für automatische Installation auf jeder Maschine beim Öffnen des Repos: siehe
`templates/ensure-plugins.sh` und `templates/settings-snippet.md` im Wurzelverzeichnis
dieser Bibliothek.

Nach der Installation: `.claude/project-context/tech-stack.md` anlegen/prüfen (siehe oben),
sonst laufen die Skills ins Leere.
