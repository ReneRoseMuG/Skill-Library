# Planung

Planungs-Gate vor jeder Umsetzung. Stellt sicher, dass betroffene Schichten, Risiken, Tests und Abnahmekriterien vor der ersten Änderung bekannt sind.

---

## Trigger

- Jede Ankündigung einer Umsetzung oder Änderung: Feature, Fix, Migration, Test, Refactoring, Schnittstelle, UI.

## Nicht-Trigger

- Reine Frage oder Analyse ohne Änderungsabsicht.

---

## Pflichtablauf

1. Auftragsklasse aus dem `00-auftrags-orchestrator.md` übernehmen.
2. Bei Code-Bezug: `graphify-protocol.md` anwenden, bevor Dateien gelesen werden.
3. Betroffene Domänen, Schichten, Datenflüsse, Persistenz, Zustand, Tests und Abnahmekriterien identifizieren.
4. Explizit entscheiden, ob Berechtigungen/Rollen, Datenmigration, Schnittstellen oder UI-Regeln betroffen sind.
5. Annahmen und Blocker benennen — keine stillen Architektur- oder Scope-Entscheidungen.
6. Plan proportional zur Klasse — Sicherheit, Tests und Datenmigration nie weglassen, wenn relevant.
7. Benennen, was bewusst unverändert bleibt und was kaputtgehen kann, samt Risikobegrenzung.

---

## Pflichtfragen vor jedem Plan

- Welche Domäne, welche Schichten, welche Objekte?
- Berechtigungen, Rollen oder Zugriffsregeln betroffen?
- Datenmigration, Schema- oder Fixture-Änderung nötig?
- Zustandsverwaltung, Schnittstellen oder Invalidierung betroffen?
- Was bleibt bewusst unverändert?
- Was kann brechen — wie wird das Risiko begrenzt?

---

## Leitplanken

- Plan immer proportional zur Auftragsklasse.
- Keine Umsetzung ohne benannte Abnahmekriterien.
- Keine unverwandten Refactorings oder Scope-Erweiterungen.

---

## Hard-Stop

- Architekturentscheidung nicht spezifiziert und keine sichere Konvention vorhanden.
- Plan würde stille, unverwandte Änderungen überschreiben.
- Benötigte Quelle (Schema, Spezifikation, Aufgabe) fehlt und abhängige Schritte brauchen sie.

---

## Ergebnisformat

| Feld | Inhalt |
|---|---|
| Klasse | Auftragsklasse |
| Betroffen | Domänen, Schichten, Dateien, Daten |
| Querschnitt | Berechtigungen, Migration, Schnittstellen, UI |
| Unverändert | Was bewusst unberührt bleibt |
| Risiken | Schadenspotential + Begrenzung |
| Verifikation | Wie die Änderung geprüft wird |
