# Konformitäts- und Driftprüfung

Prüft nach einer Änderung ob die Umsetzung der Architektur- und Designentscheidung entspricht,
bestehende Muster korrekt verwendet und keinen neuen strukturellen oder visuellen Drift erzeugt.

Kann auch standalone als Audit-Skill eingesetzt werden — ohne vorherige Implementierung.

---

## Prüfbereiche

**Strukturell**
- Verwendung der geplanten Referenzkomponente
- Verantwortungs- und Schichtengrenzen
- Neue Abhängigkeiten und Umgehung zentraler Pfade
- Duplizierte Fach-, Auswahl-, Filter- oder Validierungslogik

**UI und Interaktion**
- Buttons, Icons, Menüs und Aktionsreihenfolge
- Collapse-, Expand- und Navigationsmuster
- Drag-Handles, Drop-Ziele und Rückmeldungen
- Design-Token, Abstände, Größen und responsive Verhalten
- Lade-, Leer-, Fehler-, Fokus- und Tastaturzustände

**Tests und Dokumentation**
- Tests, Stories und visuelle Regression
- Dokumentierte Ausnahmen und nachgeführte Regeln

---

## Pflichtablauf

1. Geplante Entscheidung und Abnahmekriterien laden.
2. Geänderte Dateien und tatsächliche Abhängigkeiten untersuchen.
   ```bash
   graphify update .
   graphify query "<geänderte Komponente>"
   ```
3. Prüfen ob eine neue parallele Komponente oder Logik entstanden ist.
4. Neue Imports, Knoten oder Pfade mit Analysewerkzeugen untersuchen.
5. Bei Graphify-Verfügbarkeit: aktualisierten Teilgraphen mit Ausgangszustand vergleichen.
6. UI-Änderungen in relevanten Varianten und Zuständen prüfen.
7. Tests und Lint-Prüfungen ausführen.
8. Abweichungen als zulässige Ausnahme, behebbare Drift oder Blocker klassifizieren.
9. Abschlussurteil und verbleibende Risiken dokumentieren.

---

## Driftklassen

| Klasse | Merkmal |
|---|---|
| Struktureller Drift | Neue/falsche Abhängigkeit, Umgehung einer Schicht, paralleler Datenpfad |
| Komponentendrift | Neue lokale Komponente trotz geeigneter Referenz |
| Interaktionsdrift | Abweichendes Verhalten für Auswahl, Drag-and-drop, Collapse, Navigation |
| Visueller Drift | Abweichende Icons, Buttons, Abstände, Farben, Zustände |
| Regeldrift | Code und aktuelle Regelquelle widersprechen sich |
| Dokumentationsdrift | Referenz, Story oder Regelkatalog beschreibt den aktuellen Standard nicht mehr |
| Akzeptierte Ausnahme | Bewusste, begründete und dokumentierte Abweichung |

---

## Leitplanken

- Funktionierende Tests allein beweisen keine Architektur- oder Designkonformität.
- Nicht jede neue Datei ist Drift — Verantwortung und Bedarf entscheiden.
- Graphänderungen sind Hinweise, keine abschließenden Urteile.
- Wiederkehrender Drift sollte durch Linting oder zentrale Exporte abgesichert werden.
- Akzeptierte Ausnahmen müssen dokumentiert werden — sonst sind sie Drift.

---

## Ergebnisformat

| Feld | Inhalt |
|---|---|
| Prüfstatus | Konform | Drift | Blocker |
| Befunde | Driftklasse, betroffene Datei, Beschreibung |
| Empfehlung | Sofort beheben | Als Ausnahme dokumentieren | Separater Auftrag |
| Risiken | Verbleibende Unsicherheiten |
