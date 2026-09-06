# Migrationsregeln

Regelt wie Schemaänderungen sicher geplant, umgesetzt und verifiziert werden.
Gilt für alle strukturellen Datenbankänderungen.

---

## Grundsätze

1. **Jede Schemaänderung ist eine Migration** — keine direkten Schema-Änderungen ohne Migrationsdatei.
2. **Migrationen sind unumkehrbar in Produktion** — Down-Migrations sind nützlich für Entwicklung, aber kein Sicherheitsnetz.
3. **Keine Datenverluste ohne expliziten Entscheid** — DROP und DELETE immer mit Begründung.
4. **Tests nach Migration ausführen** — Schema und Fixtures müssen konsistent bleiben.

---

## Migrationskategorien

| Kategorie | Beispiel | Risiko |
|---|---|---|
| Additiv | Neue Tabelle, neue Spalte nullable | Niedrig |
| Modifizierend | Spaltentyp ändern, NOT NULL hinzufügen | Mittel–Hoch |
| Destruktiv | Spalte löschen, Tabelle löschen | Hoch |
| Datenmigration | Daten transformieren, Werte befüllen | Hoch |

---

## Pflichtablauf für jede Migration

### Planung
1. Schemaanalyse (`01-schema-analysis.md`) abgeschlossen.
2. Abhängige Repositories, Services und APIs identifiziert.
3. Breaking-Changes benannt und Aktualisierungsstrategie festgelegt.
4. Rückwärtskompatibilität für laufende Prozesse geprüft.

### Implementierung
1. Migrationsdatei erstellen (nach Repository-Konvention benannt und nummeriert).
2. Up-Migration schreiben: Schema-Änderung.
3. Bei Datenmigration: Transformation in separatem Schritt, nicht gemischt mit Struktur.
4. Down-Migration schreiben wenn sinnvoll.
5. Abhängige Repositories, Services, Shared Types und Tests anpassen.

### Verifikation
1. Migration lokal ausführen und Ergebnis prüfen.
2. Schema-Snapshot gegen Erwartung vergleichen.
3. Fixtures, Seeds und Test-Datenbanken aktualisieren.
4. Tests ausführen — alle betroffenen Testsuiten.
5. Down-Migration testen wenn vorhanden.

---

## NOT NULL Migrationen

Besonders riskant auf Tabellen mit bestehenden Zeilen:

1. Spalte zuerst nullable hinzufügen.
2. Bestehende Zeilen mit Default-Wert befüllen (Datenmigration).
3. NOT NULL Constraint in separater Migration setzen.

Niemals NOT NULL direkt auf Spalte mit bestehenden Zeilen ohne Default-Wert.

---

## Löschregeln

Vor dem Löschen einer Spalte oder Tabelle:

- Alle Codesstellen die sie referenzieren identifiziert und entfernt?
- FK-Kaskaden bewertet — was wird mitgelöscht?
- Backup oder Archivierungsstrategie für Produktionsdaten?
- Migrationslauf in Test-Umgebung erfolgreich?

---

## Leitplanken

- Keine Datenmigration und Strukturmigration in derselben Migrationsdatei.
- Keine Migration die Daten still löscht ohne dokumentierten Entscheid.
- Breaking-Changes an API-Contracts parallel zur Migration kommunizieren.
- Migrations-Reihenfolge ist unveränderlich — keine rückwirkenden Änderungen.
