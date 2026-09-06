# Projekt-Kontext: Tech-Stack (Vorlage)

Diese Datei gehört in jedes Repo unter `.claude/project-context/tech-stack.md` und
liefert den Dev/Testing-Skills aus `dev-testing-skills` die konkreten Pfade, Muster
und Konventionen dieses Repos. Die Skills selbst enthalten keine Pfade — sie lesen
diese Datei. Eine Zeile pro Fakt, Tabellen wo passend. Nicht befüllte Abschnitte
knapp mit „nicht zutreffend" markieren statt zu löschen, damit ein Skill weiß, dass
er nichts findet, statt zu raten.

## Schichten

| Ebene-1-Rolle | Konkreter Ort in diesem Repo |
|---|---|
| Shared Types / Schema | |
| API-Routen (Validierung + Service-Aufruf) | |
| Controller (falls eigene Schicht zwischen Routen und Services) | |
| Repositories (CRUD, Persistenz) | |
| Services (Business-Regeln, domänenübergreifend) | |
| Frontend-API-Client | |
| Frontend-Seiten/Komponenten | |

## State-Management (Frontend)

- Bibliothek:
- Zentrale Query-Keys:
- Zentrale/verteilte Invalidierung:
- Verboten (z. B. `useState`+`useEffect` für Server-State)?

## UI-Komponenten

- Bevorzugte gemeinsame Komponenten (Karten, Modals, Listenzeilen o. ä.):
- Komponentenbibliothek (z. B. Radix, eigenes Design-System):
- Label-/Übersetzungskonvention (zentrale Datei? verboten: inline-Strings?):
- Design-Leitfaden-Datei (falls vorhanden):

## Datenbank

- Typ (z. B. MySQL, PostgreSQL, SQLite):
- ORM:
- Migrationsordner:
- Connection-Pool-Limits (falls relevant):
- Verbotene Pfade in Tests (produktive DB-/Upload-/Backup-Verzeichnisse):

## Tests

- Testebenen und Ordner (Unit/Integration/E2E):
- Testkommandos je Ebene:
- Isolationsmechanismus (Temp-DB, In-Memory, `.runtime`):

## Domänen-Abdeckung (für test-quality-review)

| Domäne | Kern-Entitäten |
|---|---|
| | |

## Analysewerkzeuge

- Graphify vorhanden? (ja/nein, `graphify-out/`-Pfad)
- Sonstige Analyse-Skripte (z. B. `depcruise`, `knip`):

## Auth & Rollen

- Permission-Mapping (lesend/schreibend/löschend/admin):
- Öffentliche Ausnahmen (Health-Check, Login-Route o. ä.):

## Git-Kurzkommandos (optional, falls im Repo etabliert)

- z. B. `branch <name>`, `save`, `savetowork` — falls das Repo solche Kurzformen kennt.

## Sonstige verbindliche Referenzdokumente

- Projektverfassung (`agents.md`/`CLAUDE.md`):
- Architektur-/Design-Leitfaden (falls vorhanden):
