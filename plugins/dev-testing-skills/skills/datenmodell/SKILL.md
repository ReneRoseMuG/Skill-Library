---
name: datenmodell
description: >
  Datenmodell-Analyse vor Schema-Änderungen, Migrationen und neuen Entitäten.
  Verwenden wenn Tabellen, Spalten, Relationen oder Fremdschlüssel geändert werden sollen,
  eine neue Migration geplant ist, oder Datenbankintegrität geprüft werden soll.
  Auslöser: "neue Tabelle", "Schema ändern", "Migration", "Fremdschlüssel",
  "ON DELETE", "neue Spalte", "Datenbank", "Schema", "Relation", "Datenverlust".
---

# Datenmodell & Persistenz

Schema-Änderungen sind irreversibel in Produktion. Erst analysieren, dann migrieren.

## Schema-Quellen

Konkreter Pfad zur Schema-Definition, zum Migrationsordner und zu den Repositories:
siehe `.claude/project-context/tech-stack.md`, Abschnitt „Schichten" und „Datenbank".
Immer die verbindliche Schema-Datei als primäre Quelle lesen — nicht nur eine
eventuell vorhandene Kurzreferenz im Projektkontext, die veraltet sein kann.

## Schritt 1 — Bestandsaufnahme

Falls Graphify laut `tech-stack.md` verfügbar:
```bash
graphify query "<Domänenobjekt>"
graphify explain "<Schema-Entität>"
```

Dann im Quellcode prüfen:
- Welche Tabellen, Spalten, Typen, Nullable, Default-Werte?
- Welche Fremdschlüssel und Kaskadierungsregeln (ON DELETE, ON UPDATE)?
- Welche Indizes?
- Welche Repositories, Services, API-Routen greifen zu?
- Welche Tests und Fixtures setzen das Schema voraus?

## Schritt 2 — Migrationskategorie bestimmen

| Kategorie | Risiko |
|---|---|
| Additiv: neue Tabelle, nullable Spalte | Niedrig |
| Modifizierend: Typ ändern, NOT NULL hinzufügen | Mittel–Hoch |
| Destruktiv: Spalte/Tabelle löschen | Hoch |
| Datenmigration: Werte transformieren | Hoch |

## Schritt 3 — Migrations-Pflichtablauf

1. Migration nach Repository-Konvention anlegen (nummeriert/benannt, siehe `tech-stack.md`)
2. Strukturmigration und Datenmigration **in getrennten** Migrationsdateien
3. NOT NULL auf bestehenden Zeilen: erst nullable hinzufügen → Zeilen befüllen → NOT NULL setzen
4. Abhängige Repositories, Services, Shared Types und Tests anpassen
5. Migration lokal ausführen und Schema-Zustand prüfen
6. Fixtures, Seeds und Test-Datenbanken aktualisieren
7. Tests ausführen — alle betroffenen Suiten (Testkommandos aus `tech-stack.md`)

## Schritt 4 — Integrität prüfen

- Alle FK mit explizitem ON DELETE / ON UPDATE?
- Kaskadierung fachlich korrekt? (RESTRICT vs CASCADE vs SET NULL)
- Unique-Constraints für fachlich eindeutige Felder?
- Soft-Delete in allen Abfragen konsistent berücksichtigt?
- Test-Isolation korrekt gemäß `tech-stack.md` (Temp-DB/In-Memory/`.runtime`) — nie gegen produktive Datenverzeichnisse

## Projektspezifische Ergänzungen

Manche Repos haben zusätzliche Pflichtschritte bei neuen Tabellen (z. B. eine
Dump-Registry, Test-Truncation-Konfiguration, Seed-Roundtrip). Diese stehen —
falls es sie gibt — im „Sonstige verbindliche Referenzdokumente"-Abschnitt von
`tech-stack.md` bzw. der Projektverfassung.

## Abbruch wenn

- ON DELETE Regel hat Auswirkungen die nicht vollständig bewertet sind
- Migration würde Daten löschen ohne dokumentierten Entscheid
- Test-Infrastruktur (Fixtures, Schema-Init) nicht klar aktualisierbar

Quelle (Ebene 1): Skill Library `dev-testing/data-model/`.
