---
name: testing
description: >
  Test-Strategie und Testplanung für dieses Repository — Regelanalyse, Szenariomatrix
  und Testebenenentscheidung für abgeschlossene Codeänderungen oder
  Testlückenbewertungen. Auslöser: "welche Tests brauche ich", "schreib Tests für X",
  "prüf die Testabdeckung", "nach der Änderung Tests", "fehlen Tests für Y".
---

# Testing-Skill

Kombiniert Auftragsklärung, Regelanalyse, Teststrategie und Szenarioplanung.
Einstiegspunkt für alle Test-Aufträge die mehr als eine einzelne Testebene betreffen.

Konkrete Testkommandos, Safety Gates und verbindliche Teststrukturen dieses Repos
stehen in `.claude/project-context/tech-stack.md`, Abschnitt „Tests" — dort
nachschlagen statt zu raten.

---

## Trigger

- Abgeschlossene Codeänderung die Tests erfordert
- Auftrag Testlücken oder Testabdeckung fachlich zu prüfen
- Auftrag Tests anzupassen oder zu erweitern
- Abschlussprüfung vor Übergabe oder Merge

## Nicht-Trigger

- Ausdrücklich auf eine einzelne Testebene begrenzter Auftrag ohne vorgelagerte Analyse
- Reiner Testlauf ohne Änderungs- oder Bewertungsauftrag → direkt Testkommando aus `tech-stack.md`

---

## Pflichtablauf

### Teil 1 — Testkontext ermitteln

1. Änderungsquelle und beabsichtigtes Verhalten bestimmen.
2. Graphify-Protokoll anwenden, falls laut `tech-stack.md` verfügbar:
   ```bash
   graphify query "<geänderter Bereich>"
   graphify path "<Einstieg>" "<Persistenz oder Service>"
   ```
3. Geänderte Dateien, direkte Aufrufer, Abhängigkeiten und betroffene Schichten untersuchen (siehe „Schichten" in `tech-stack.md`).
4. Relevante fachliche Regeln laden (aus Shared Types/Routen, Servicecode, Architektur-Leitfaden aus `tech-stack.md`).
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
   - **Unit** → isolierte Berechnung, Validierung, Zustandslogik — kein DB, kein Browser
   - **Integration** → reale Services, Repositories, DB, Auth, Dateisystem (Test-App-Aufbau aus `tech-stack.md`)
   - **Browser/E2E** → kritischer Nutzerablauf, Risiko entsteht erst im Gesamtsystem

---

## Übergangsmodi und projektspezifische Sonderregeln

Befindet sich die Test-Infrastruktur (z. B. E2E/Browser-Isolation) laut einem in
`tech-stack.md` unter „Sonstige verbindliche Referenzdokumente" benannten Dokument
im Umbau: dessen Übergangsregeln gelten bis zur dort beschriebenen Freigabe durch
den Nutzer. Ohne ein solches Dokument gelten die Regeln dieses Skills ohne
Einschränkung.

## Isolationsregeln für Integrationstests

Siehe „Tests" in `tech-stack.md`: Isolationsmechanismus, zentraler Testdaten-Einstieg
(Factory), Test-App-Aufbau. Keine direkten Insert/Update-Statements wenn ein
zentraler Einstieg existiert. Eindeutig identifizierbare Testdaten-Tokens wenn
Verwechslungen möglich.

## Verbotene Testmuster

- Nur prüfen ob ein Element existiert (ohne Count/Identity/Delta)
- Assertions ausschließlich auf Mock-Aufrufe
- Pauschale Wartezeiten in Browser-Tests
- Assertions abschwächen damit Tests grün werden
- Demo- oder Bestandsdaten als implizite Voraussetzung

## Pflichtkommentar in jeder Testdatei

```ts
/**
 * Test Scope:
 *
 * Abgedeckte Regeln:
 * - <Regel 1>
 *
 * Fehlerfälle:
 * - <Fehlerfall 1>
 *
 * Ziel:
 * <Kurzbeschreibung der Absicherung>
 */
```

Falls das Repo eine zentrale Test-Matrix-Datei pflegt (siehe `tech-stack.md`): neue/erweiterte Tests müssen sie aktualisieren.

---

## Ergebnisformat

| Feld | Inhalt |
|---|---|
| Regelkatalog | Fachliche Regeln mit Ausgangszustand, Aktion, Ergebnis |
| Szenariomatrix | Szenarien pro Regel mit Testebene |
| Bestandsbewertung | Status vorhandener Tests |
| Lücken | Fehlende Tests mit Begründung |
| Testplan | Priorität, Ebene, Daten, Isolation |

Quelle (Ebene 1): Skill Library `dev-testing/testing/` — dort zuerst ändern, dann hier nachziehen.
