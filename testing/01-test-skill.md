# Test-Skill: Kontext, Regeln und Strategie

Kombiniert Auftragsklärung, Regelanalyse, Teststrategie und Szenarioplanung in einem Schritt.
Einstiegspunkt für alle Test-Aufträge die mehr als eine einzelne Testebene betreffen.

---

## Trigger

- Abgeschlossene Codeänderung die Tests erfordert
- Auftrag Testlücken oder Testabdeckung fachlich zu prüfen
- Auftrag Tests anzupassen oder zu erweitern
- Abschlussprüfung vor Übergabe oder Merge

## Nicht-Trigger

- Ausdrücklich auf eine einzelne Testebene begrenzter Auftrag ohne vorgelagerte Analyse
- Reiner Testlauf ohne Änderungs- oder Bewertungsauftrag → direkt `05-test-execution.md`

---

## Pflichtablauf

### Teil 1 — Testkontext ermitteln

1. Änderungsquelle und beabsichtigtes Verhalten bestimmen.
2. Graphify-Protokoll anwenden (`core/graphify-protocol.md`):
   ```bash
   graphify query "<geänderter Bereich>"
   graphify path "<Einstieg>" "<Persistenz oder Service>"
   ```
3. Geänderte Dateien, direkte Aufrufer, Abhängigkeiten und betroffene Schichten untersuchen.
4. Relevante Spezifikationen und fachliche Regeln laden.
5. Regeln als: Ausgangszustand → Aktion → Ergebnis → Ausnahmen formulieren.
6. Bestehende Tests nur als Indiz auswerten — Abweichungen zur Fachregel markieren.

**Quellenpriorität:**
1. Akzeptanzkriterien und freigegebene Spezifikationen
2. Feature- und Use-Case-Dokumentation
3. Architekturentscheidungen und API-Verträge
4. Tickets und nachvollziehbarer Nutzerauftrag
5. Bestehende Tests
6. Aktueller Code

### Teil 2 — Strategie und Szenarien

1. Für jede Regel mindestens ableiten: Erfolgsweg, relevante Gegenbeispiele, Fehlerfälle.
2. Ausgangszustand, Aktion, erwartete Wirkung und erwartete Nicht-Wirkung je Szenario festhalten.
3. Bestehende Tests den Regeln zuordnen. Status bewerten:
   - weiterhin passend | muss angepasst werden | muss erweitert werden | redundant | fehlt vollständig
4. Für Lücken entscheiden: anpassen, erweitern, ersetzen oder neu erstellen.
5. Testebene wählen:
   - **Unit** → isolierte Berechnung, Validierung, Zustandslogik
   - **Integration** → Zusammenspiel realer Services, Repositories, DB, Auth, Dateisystem
   - **Browser/E2E** → kritischer Nutzerablauf, Risiko entsteht erst im Gesamtsystem
6. Testdaten, Isolation und Priorität planen.

---

## Allgemeine Test-Qualitätsbasis

Jeder Test muss:
- Eine konkrete fachliche oder technische Aussage beweisen
- Einen nachvollziehbaren Ausgangszustand herstellen
- Eine reale oder für die Ebene angemessen isolierte Aktion ausführen
- Beobachtbare Ergebnisse und relevante Nicht-Wirkungen prüfen
- Reproduzierbar und unabhängig von Ausführungsreihenfolgen sein
- Fachlich mögliche Testdaten verwenden

**Verbotene Abkürzungen:**
- Nur prüfen ob ein Element existiert
- Assertions ausschließlich auf Mock-Aufrufe
- Snapshots ohne fachliche Aussage
- Pauschale Wartezeiten in Browser-Tests
- Assertions abschwächen damit Tests grün werden

---

## Leitplanken

- Keine Coverage-Betrachtung als Testlückenanalyse.
- Nicht automatisch möglichst viele Unit- und möglichst wenige E2E-Tests verlangen.
- Keine fehlgeschlagenen Tests automatisch an neues Verhalten anpassen.
- Keine Produktivcode-Änderung aus einem reinen Testauftrag.

---

## Ergebnisformat

| Feld | Inhalt |
|---|---|
| Regelkatalog | Fachliche Regeln mit Ausgangszustand, Aktion, Ergebnis |
| Szenariomatrix | Szenarien pro Regel mit Testebene |
| Bestandsbewertung | Status vorhandener Tests |
| Lücken | Fehlende Tests mit Begründung |
| Testplan | Priorität, Ebene, Daten, Isolation |
