# Exploration-Orchestrator

Einstiegspunkt für alle Explorations- und Impact-Analyse-Aufträge.
Antwortet auf: "Was ist hier?", "Was passiert wenn ich X ändere?", "Gibt es schon etwas für Y?"

---

## Trigger

- Auftrag liegt vor, aber Zuständigkeiten oder vorhandene Lösungen sind unklar
- Vor einer Architektur- oder Implementierungsentscheidung
- "Finde ähnliche Implementierungen"
- "Was ist betroffen wenn ich X ändere?"
- "Gibt es bereits etwas für Y?"
- Neuer Entwickler oder neuer Codebereich ohne Vorkenntnisse
- Audit- oder Review-Auftrag ohne konkrete Änderungsabsicht

## Nicht-Trigger

- Ziel, zuständige Datei und Umfang sind bereits vollständig klar
- Auftrag ist rein redaktionell ohne Codebezug

---

## Auftragsarten

| Art | Beschreibung |
|---|---|
| Strukturerkundung | Was existiert in diesem Bereich, welche Muster gibt es? |
| Impact-Analyse | Was ist betroffen wenn Komponente X verändert wird? |
| Mustersuche | Gibt es bereits etwas das Y tut oder Y ähnelt? |
| Vollanalyse | Alle drei kombiniert vor einer größeren Änderung |

---

## Pflichtablauf

1. Graphify-Protokoll (`core/graphify-protocol.md`) in Schritt 1 anwenden.
2. Auftragsart bestimmen: Strukturerkundung, Impact, Mustersuche oder Vollanalyse.
3. Passende Spezialisierungsskills aktivieren:
   - Strukturerkundung → `02-graphify-exploration.md`
   - Impact-Analyse → `03-impact-analysis.md`
   - Mustersuche → `04-pattern-search.md`
4. Quellcodeprüfung der Graphfunde durchführen.
5. Ergebnis konsolidieren: gefundene Komponenten, Muster, Abhängigkeiten, offene Fragen.

---

## Leitplanken

- Keine Implementierungsentscheidung treffen — nur analysieren und dokumentieren.
- Keine Codeänderung aus einem reinen Explorationsauftrag ableiten.
- Unsicherheiten als Annahmen kennzeichnen, nicht stillschweigend auflösen.
- Analyseumfang proportional zur geplanten Änderungsgröße halten.
- Widersprüche zwischen Graphfund und Quellcode immer zugunsten des Quellcodes auflösen.

---

## Übergabeformat

| Feld | Inhalt |
|---|---|
| Auftrag | Auftragsart und Zielbereich |
| Graphfunde | Relevante Knoten, Pfade, Vernetzung |
| Quellcode-Verifikation | Was tatsächlich vorhanden ist |
| Muster | Gefundene Implementierungen und ihre Klassifikation |
| Abhängigkeiten | Direkte Aufrufer, Seiteneffekte, betroffene Schichten |
| Offenes | Unklare Verantwortlichkeiten, Widersprüche, fehlende Quellen |
