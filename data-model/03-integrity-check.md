# Datenintegrität und Persistenzprüfung

Prüft ob Datenmodell, Persistenzlogik und Geschäftsregeln konsistent sind.
Findet Integritätslücken bevor sie zu Datenproblemen in Produktion werden.

---

## Prüfbereiche

### Referentielle Integrität
- Alle Fremdschlüssel mit expliziter ON DELETE / ON UPDATE Regel?
- Kaskadierungsregeln fachlich korrekt (RESTRICT vs CASCADE vs SET NULL)?
- Keine verwaisten Referenzen möglich durch fehlende Constraints?
- Soft-Delete korrekt in allen Abfragen berücksichtigt?

### Löschregeln
- Was passiert mit abhängigen Objekten wenn ein Elternobjekt gelöscht wird?
- Sind Löschregeln in Tests abgedeckt?
- Sind Löschregeln in der Spezifikation dokumentiert?
- Verhindert die Datenbank unbeabsichtigte Datenlöschung?

### Validierung und Constraints
- Pflichtfelder als NOT NULL im Schema?
- Längen- und Formatbeschränkungen auf Schema-Ebene?
- Unique-Constraints für fachlich eindeutige Felder?
- Check-Constraints für Wertebereichsbeschränkungen?

### Konsistenz zwischen Schema und Code
- Validierungsregeln im Service decken Schema-Constraints ab?
- Keine Logik die Schema-Constraints umgeht?
- Versionierungs- oder Audit-Felder korrekt gepflegt?

### Performance-relevante Integritätsaspekte
- Häufig abgefragte Spalten mit Index?
- FK-Spalten mit Index (für Join-Performance)?
- Soft-Delete-Felder bei häufigen Abfragen indiziert?

---

## Pflichtablauf

1. Graphify-Protokoll anwenden für betroffene Entitäten:
   ```bash
   graphify query "<Entität>"
   graphify explain "<Entität>"
   ```
2. Schema-Quellcode lesen — alle Constraints, FKs, Indizes prüfen.
3. Repository-Code lesen — Abfragen auf Korrektheit prüfen.
4. Service-Code lesen — Validierungslogik gegen Schema-Constraints prüfen.
5. Tests prüfen — sind Lösch- und Konfliktszenarien getestet?
6. Befunde klassifizieren.

---

## Befundklassen

| Klasse | Merkmal |
|---|---|
| Kritisch | Datenverlust oder Datenkonsistenz-Verletzung möglich |
| Hoch | Integritätslücke ohne unmittelbares Datenproblem |
| Mittel | Inkonsistenz zwischen Code und Schema |
| Niedrig | Verbesserungsmöglichkeit ohne Integritätsrisiko |

---

## Leitplanken

- Fehlendes FK-Constraint ist immer ein Befund — auch wenn es bisher keine Probleme gab.
- Kaskadierungsregeln ohne fachliche Begründung sind immer kritisch zu prüfen.
- Soft-Delete ohne konsistente Abfragen ist eine häufige Quelle von Datenproblemen.
- Performance-Indizes sind kein Integritätsthema — aber fehlende FKs schon.

---

## Ergebnisformat

| Feld | Inhalt |
|---|---|
| Prüfbereich | Referentielle Integrität / Validierung / Konsistenz / Performance |
| Befund | Konkrete Lücke mit betroffener Tabelle/Spalte |
| Klasse | Kritisch / Hoch / Mittel / Niedrig |
| Empfehlung | Konkrete Maßnahme (Migration, Code-Änderung, Test) |
| Risiko | Was passiert wenn es nicht behoben wird |
