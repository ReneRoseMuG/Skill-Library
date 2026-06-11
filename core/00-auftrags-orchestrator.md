# Auftrags-Orchestrator

Einstiegspunkt für jeden eingehenden Auftrag. Bestimmt die Auftragsklasse, aktiviert nur die erforderlichen Skills und sichert die Reihenfolge Analyse → Planung → Umsetzung → Abschluss.

---

## Trigger

- Jeder neue Auftrag, dessen Klasse oder zuständige Skills noch nicht feststehen.

## Nicht-Trigger

- Ein spezialisierter Orchestrator ist bereits aktiv und die Domäne ist eindeutig.
- Triviale, eindeutig begrenzte Einzelhandlung ohne Analyse- oder Änderungsbedarf.

---

## Auftragsklassen

| Klasse | Beschreibung | Folge |
|---|---|---|
| Frage / Lesen | Reine Auskunft ohne Änderung | Minimaler Umfang, keine Planung |
| Analyse / Audit / Report | Verstehen und bewerten, kein Code | Nur relevante Bereiche, kurzer Analyseplan |
| Versionsverwaltung | Operation ohne Code-Änderung | Nur Zustand prüfen |
| Kleiner lokaler Fix | Begrenzte Änderung in bestehender Struktur | Kleiner Plan, dateinaher Start |
| Mehrschichtige Änderung / Feature | Mehrere Schichten oder neue Funktion | Voller Plan, begründet breitere Analyse |

---

## Pflichtablauf

1. Auftrag genau einer Klasse zuordnen. Wahl, Begründung und die daraus folgenden Startschritte **sichtbar nennen, bevor gehandelt wird.**
2. Prüfen, ob der Auftrag eine Objektreferenz aus einem Vorgangssystem als Quelle nennt → wenn ja: `work-order.md` anwenden.
3. Prüfen, ob die Aufgabe Code liest, analysiert oder recherchiert → wenn ja: `graphify-protocol.md` in Schritt 1 anwenden (Pflicht, nicht Option).
4. Nur die erforderlichen Spezialisierungsskills aktivieren:
   - Struktur, Impact, Mustersuche → `exploration/`
   - Architektur, Design, Komponenten → `architecture/`
   - Schema, Persistenz, Migration → `data-model/`
   - Spezifikation → `specification/`
   - Anwenderdokumentation → `documentation/`
   - Tests → `testing/`
5. Bei Änderungsaufträgen: erst `planung.md`, dann Umsetzung unter `code-discipline.md`.
6. Analyseumfang proportional zur Klasse halten — keine Vollanalyse für kleine Fixes.
7. Abschluss erst nach Ende der **gesamten** Aufgabe (Bericht und Statuspflege gemäß `work-order.md` bzw. Projektregel).

---

## Leitplanken

- Klassifikation steht immer am Anfang und ist sichtbar — sie steuert Tiefe, Lektüre und Planung.
- Keine Codeänderung aus einem reinen Frage- oder Analyseauftrag.
- Keine doppelte Detailanalyse, wenn ein nachgelagerter Skill sie vollständig übernimmt.
- Graphify vor klassischer Datei- oder Textsuche, sobald Code berührt wird.
- Keine stillen Architektur-, Produkt- oder Scope-Entscheidungen — Unsicherheit als Blocker benennen.

---

## Ergebnisformat

| Feld | Inhalt |
|---|---|
| Klasse | Gewählte Auftragsklasse + Begründung |
| Aktivierte Skills | Welche Spezialisierungen, warum |
| Kontextquelle | Objektreferenz / Vorgangskontext, falls vorhanden |
| Startschritte | Erste konkrete Schritte |
| Offenes | Annahmen, Blocker, fehlende Quellen |
