# Code-Tests: Unit und Integration

Entwirft und implementiert Unit-Tests und Integrationstests.
Unit und Integration werden gemeinsam behandelt weil sie dieselben Quellen analysieren
und ihre Grenze vom Risiko — nicht von der Bequemlichkeit — bestimmt wird.

---

## Wann Unit, wann Integration?

| Unit | Integration |
|---|---|
| Pure Funktionen und Berechnungen | Service- und Repository-Zusammenspiel |
| Lokale Validierung | Datenbankzugriffe und Migrationen |
| Abgegrenzte Zustandsübergänge | API-Endpunkte mit echten Daten |
| Fehlerpfade einer einzelnen Einheit | Authentifizierung und Berechtigungen |
| Systematische Varianten | Serialisierung und Persistenz |
| | Transaktionen, Konflikte und Nebenwirkungen |

**Faustregel:** Wenn das Risiko im Zusammenspiel liegt → Integration. Wenn das Risiko in der Logik einer Einheit liegt → Unit.

---

## Pflichtablauf — Unit-Tests

1. Zu testende Einheit und Vertrag klar benennen.
2. Direkte Eingaben, Ausgaben und relevante Fehler bestimmen.
3. Abhängigkeiten nur dort ersetzen wo sie nicht Teil des zu beweisenden Verhaltens sind.
4. Positive, negative und grenzwertige Varianten planen.
5. Zeit, Zufall und externe Effekte kontrollieren.
6. Tests implementieren.

**Mock-Regeln Unit:**
- Erlaubt: externe Seiteneffekte (Netzwerk, Uhrzeit, Zufall, Dateizugriff), klar begrenzte Collaborators
- Verboten: Fachlogik im Mock vorwegnehmen, fachlich unmögliche Zustände vortäuschen

---

## Pflichtablauf — Integrationstests

1. Reale Komponenten bestimmen die am Ergebnis beteiligt sind.
2. Isolierte Testumgebung mit produktionsnahem Schema herstellen.
3. Fachlich gültige positive und negative Testobjekte anlegen.
4. Aktion über den vorgesehenen öffentlichen Einstiegspunkt ausführen.
5. Rückgabe **und** realen Folgezustand prüfen.
6. Cleanup oder Transaktionsreset sicherstellen.

**Mock-Regeln Integration:**
- Keine Mocks. Echte Objekte, echte Daten, echte Services, Repositories, DB-Clients, Auth.
- Ausnahme: technisch nötiger Parameter ohne nachweislichen Einfluss — muss im Testkommentar stehen.
- Ist Mock unvermeidlich → kein Integrationstest, sondern Blocker dokumentieren.

---

## Testdaten und Isolation

**Datenbank:**
- Nie produktive Datenbankdateien oder -pfade
- Temp-DB, In-Memory-DB oder isolierter Test-Root
- Schema/Migrationen passend zum Produktivcode initialisieren
- Zuverlässiges Cleanup vor/nach dem Test
- Gegenbeispiele explizit anlegen — nicht nur positive Treffer prüfen

**Dateisystem:**
- Echtes Dateisystem, eindeutiger Temp-Root pro Test/Suite
- Nie produktive Upload- oder Content-Verzeichnisse
- Robustes Cleanup in afterEach/afterAll

---

## Aussagekräftige Assertions

**Stark:**
- HTTP-Status + Fehlerformat + persistierter DB-Zustand
- Erzeugte/geänderte/gelöschte Dateien im Temp-Root
- Rollen-/Permission-Wirkung mit echten Usern und Sessions
- Versionskonflikte mit echter aktueller und veralteter Version
- Vollständige Ergebnismengen statt beliebiger Einzelwerte

**Schwach (vermeiden):**
- Nur Mock-Aufruf ausgelöst
- Nur Element vorhanden ohne Zustandsprüfung
- Permission-Test mit gestubbtem Auth-Hook
- Integrationstest mit gemocktem Repository

---

## Verbotene Abkürzungen

- Produktionsschema durch vereinfachtes Testschema ersetzen
- Global gemeinsam genutzte Datenbankzustände
- Fachlich unmögliche Testdaten ohne ausdrücklichen Robustheitszweck
- Assertions nur auf Aufrufanzahl ohne fachliche Wirkung
- Private Implementierungsdetails zum Testvertrag machen

---

## Ergebnis

- Neue oder angepasste Tests mit Zuordnung zu Regeln und Szenarien
- Begründung der Test-Doubles
- Beschreibung von Isolation und Cleanup
- Offene Bereiche die Browser/E2E-Absicherung brauchen
