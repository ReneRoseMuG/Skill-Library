---
name: test-quality-review
description: >
  Vollständige Qualitäts- und Abdeckungsanalyse des Testbestands dieses Repos.
  Liest alle Testdateien, zählt Testfunktionen (nicht nur Dateien), prüft
  Teststrategie-Konformität gemäß der Projektverfassung, identifiziert
  Abdeckungslücken und erzeugt einen priorisierten Markdown-Bericht mit
  Änderungsaufträgen. Auslöser: "Testanalyse", "Testbericht",
  "Testqualität prüfen", "Teststrategie-Konformität", "Testabdeckung prüfen",
  "Tests analysieren".
---

# Test Quality Review

Auftragsklasse „reiner Report" (falls die Projektverfassung ein Klassenschema kennt) —
keine Codeänderungen.

Konkrete Testordnerstruktur, Hilfsdateien (Factory, Test-App-Aufbau) und die
Domänen-Tabelle dieses Repos stehen in `.claude/project-context/tech-stack.md`,
Abschnitte „Tests" und „Domänen-Abdeckung" — dort nachschlagen statt zu raten.

## Schritt 0: Vorbereitung

Alle Testdateien unter dem Testordner aus `tech-stack.md` kartieren (`*.test.ts`, `*.spec.ts`).

Zählung pro Ebene (Ebenen und Ordner aus `tech-stack.md`):
- Anzahl Testdateien
- Anzahl Testfunktionen (`it(` / `test(`) — nicht nur Dateizählung

## Schritt 1: Teststrategie-Konformität

**1.1 DB-Isolation in Unit-Tests**
Prüfen ob Unit-Tests echte DB-Verbindungen verwenden (ORM-Client, DB-Treiber, Connection-Pool aus `tech-stack.md`).
Jeder Treffer → Befund (Kritisch).

**1.2 Produktions-DB-Zugriff**
Prüfen ob Tests produktive Datenpfade oder produktive DB-Namen/-Umgebungen verwenden (siehe „Verbotene Pfade in Tests" in `tech-stack.md`).
Jeder Treffer → Befund (Kritisch).

**1.3 Safety-Gate-Umgehung**
Falls `tech-stack.md` Guard-APIs oder ein Safety Gate benennt (z. B. Testmodus-Prüfung, Allowlist-Prüfung): fehlende Guards in schreibenden Integrationstests → Befund (Kritisch).

**1.4 Pflichtkommentar**
Prüfen ob Testdateien den Pflichtkommentar enthalten (Test Scope / Abgedeckte Regeln / Fehlerfälle / Ziel).
Fehlend → Befund (Niedrig).

**1.5 Leere Tests und undokumentierte Skips**
Prüfen auf `test.skip`, `it.skip`, `describe.skip` oder leere Testkörper ohne Log-Blocker.
Jeder Treffer → Befund (Mittel).

**1.6 Berechtigungstests**
Prüfen ob geschützte Routen Berechtigungstests haben (positiver Fall + negativer Fall).
Fehlend → Befund (Hoch).

**1.7 Zentraler Testdaten-Einstieg**
Falls `tech-stack.md` einen zentralen Testdaten-Einstieg (Factory) benennt: Integrationstests mit direkten Insert-Statements statt Factory → Befund (Mittel).

**1.8 Versionierte Update-Tests**
Falls das Projekt optimistische Versionierung verwendet (siehe `tech-stack.md`): fehlendes Versionsfeld in Update-Tests → Befund (Mittel).

## Schritt 2: Domänen-Abdeckung

Tabelle aus „Domänen-Abdeckung" in `tech-stack.md` übernehmen und je Domäne bewerten,
ob Kern-Entitäten durch Tests abgedeckt sind.

Fehlende Kerndomänen → Befund (Hoch). Fehlende Infrastruktur (z. B. Auth & Rollen, Journal/Audit) → Befund (Mittel).

## Schritt 3: Dump- und Fixture-Vollständigkeit

Falls das Repo eine zentrale Truncate-/Dump-Registry oder Seed-Mechanik kennt (siehe
`tech-stack.md`): prüfen ob alle aktuellen Tabellen aus der Schema-Datei dort enthalten
sind. Fehlende Tabelle → Befund (Hoch). Fehlende repräsentative Seed-Daten für neue
Tabellen → Befund (Mittel).

## Schritt 4: Methodische Qualität

**4.1 Zu schwache Assertions**
`toBeTruthy()` / `toBeDefined()` wo spezifische Werte prüfbar wären → Befund (Niedrig).

**4.2 Mehrfach-Status-Erwartungen**
`expect([200, 201]).toContain(status)` statt konkretem Status → Befund (Mittel).

**4.3 Assertions abschwächen**
Prüfen ob neuere Tests gegenüber älteren Versionen abgeschwächte Assertions haben → Befund (Hoch).

**4.4 Direkter DB-Sprawl in Testdateien**
Falls ein zentraler Testdaten-Einstieg existiert: Tests die stattdessen direkt Daten einfügen → Befund (Mittel).

## Schritt 5: Dateisystem-Sicherheit

Schreibzugriffe auf Produktionspfade (siehe „Verbotene Pfade in Tests" in `tech-stack.md`) → Befund (Kritisch).

Temporäre Schreibzugriffe ohne den in `tech-stack.md` benannten Temp-Mechanismus und ohne Cleanup → Befund (Mittel).

## Schritt 6: Bericht

```markdown
# Test Quality Review
**Datum:** <DATUM>

## Kennzahlen
| Ebene | Dateien | Testfunktionen |
|---|---|---|
| ... | N | N |
| Gesamt | N | N |

## Befunde
### Kritisch
### Hoch
### Mittel
### Niedrig

## Empfehlungen
```

## Schritt 7: Änderungsaufträge

- Pro Befund Kritisch/Hoch → eigenständiger Änderungsauftrag (Task-Vorlage aus `tech-stack.md`, falls vorhanden)
- Pro Befund Mittel → gebündelter Auftrag
- Befunde Niedrig → Gesamtliste ohne Einzelauftrag

Quelle (Ebene 1): Skill Library `dev-testing/testing/` + `dev-testing/core/graphify-protocol.md`.
