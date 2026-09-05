# Schema-Analyse

Analysiert das bestehende Datenmodell vor Schemaänderungen, Migrationen oder neuen Entitäten.
Verhindert unbeabsichtigte Seiteneffekte auf referenzielle Integrität, Abfrageverhalten und Performance.

---

## Trigger

- Neue Tabelle oder Entität geplant
- Bestehende Spalte soll geändert oder entfernt werden
- Neue Relation oder Fremdschlüssel geplant
- Performance-Problem das auf Schemaebene liegt
- Audit des bestehenden Schemas

---

## Pflichtablauf

### Phase 1 — Graphify-gestützte Bestandsaufnahme

```bash
graphify query "<Domänenobjekt>"
graphify explain "<Schema-Entität>"
```

Ermitteln:
- Welche Tabellen/Entitäten existieren im betroffenen Bereich?
- Welche Relationen bestehen (FK, Joins, Referenzen)?
- Welche Services und Repositories greifen darauf zu?
- Welche API-Endpunkte lesen oder schreiben die Daten?

### Phase 2 — Schema-Quellcodeprüfung

Direkt im Schema-Code prüfen:
- Spaltentypen, Nullable-Eigenschaften, Default-Werte
- Indizes und ihre Felder
- Fremdschlüssel und Kaskadierungsregeln (ON DELETE, ON UPDATE)
- Versionierungs- oder Audit-Felder
- Existierende Validierungsregeln auf Schema-Ebene

### Phase 3 — Abhängigkeitsanalyse

Für jede betroffene Entität:
- Welche anderen Entitäten referenzieren sie (FK-Empfänger)?
- Welche Repositories und Services greifen lesend/schreibend zu?
- Welche Tests setzen das Schema voraus?
- Welche Fixtures oder Seed-Daten sind betroffen?
- Welche Migrationen haben diesen Bereich bereits verändert?

### Phase 4 — Risikoeinschätzung

| Risiko | Merkmale |
|---|---|
| Hoch | Viele Referenzen, produktive Daten betroffen, Breaking-Change |
| Mittel | Einige Referenzen, kontrollierte Migration möglich |
| Niedrig | Neue isolierte Entität, keine bestehenden Referenzen |

---

## Leitplanken

- Schema-Änderungen immer mit Migration — nie direkt im Produktivschema.
- Nullable vs. NOT NULL sorgfältig entscheiden — nachträgliche Änderung ist aufwändig.
- Kaskadierungsregeln explizit prüfen — stille Datenlöschung ist ein häufiger Fehler.
- Indizes von Anfang an mitdenken — nachträgliche Indizes auf großen Tabellen sind teuer.

---

## Ergebnisformat

| Feld | Inhalt |
|---|---|
| Betroffene Entitäten | Tabellen, Spalten, Relationen |
| Abhängigkeiten | Repositories, Services, APIs, Tests |
| Integritätsregeln | FK-Kaskaden, Nullable, Constraints |
| Risiko | Hoch / Mittel / Niedrig + Begründung |
| Offenes | Ungeklärte Referenzen oder fehlende Informationen |
