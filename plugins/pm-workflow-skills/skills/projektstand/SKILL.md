---
name: projektstand
description: >
  Schreibt den Arbeitsstand eines Projekts als lesbare Nachricht in einen fortlaufenden
  Gesprächsfaden — während der Arbeit, nicht nachträglich aus dem Journal. Zwei Kommandos:
  „schreibe Status" für die aktuelle Aufgabe, „schreibe Session" für die ganze Sitzung.
  Auslöser: "schreibe Status", "schreibe Session", "Projektstand schreiben",
  "Stand festhalten", "Session festhalten", sowie der automatische Abschluss eines
  Änderungsauftrags.
---

# Projektstand

## Zweck

Je Projekt ein **Gesprächsfaden**: datierte Nachrichten, neueste zuerst. Mehr nicht.

Kein überschreibbarer Kopf, keine gepflegte Liste offener Punkte, keine zweite Schicht.
Was gerade offen ist, beantworten Aufgaben und Tickets über ihren Status — dafür braucht
es keine Prosa, die jemand aktuell halten muss.

Der Faden ist **append-only**: Nichts wird je überschrieben. Eine Korrektur ist eine neue
Nachricht.

## Das Entscheidende ist der Text

Alles andere ist Mechanik. Diese Nachricht ist das, was der Projektverantwortliche in
Wochen liest, wenn er wissen will, was damals passiert ist. Sie muss ohne den Code
verständlich sein, ohne die Sitzung, ohne Rückfrage.

**Schreibe für den Projektverantwortlichen, nicht für Entwickler.**

- **Anwendersprache.** Nicht „`getPrimaryTaskParentContextMap` ergänzt", sondern „Die
  Aufgabenliste liefert jetzt mit, zu welchem Projekt eine Aufgabe gehört."
- **Zusammenhängende Sätze statt Stichpunkte.** Ein Absatz, der etwas erzählt, bleibt
  hängen; eine Liste aus Fragmenten nicht.
- **Den Grund, nicht nur das Ergebnis.** „Behoben" sagt nichts. „Die Übersicht zählte
  überall null, weil die Liste den Trägerkontext nicht mitlieferte" sagt, was los war.
- **Was es für den Nutzer ändert.** Woran merkt er den Unterschied?
- **Ehrlich bei Unfertigem.** Was blieb offen, was ist ungeprüft, was wurde bewusst
  weggelassen — mit dem Grund.
- **Keine Dateinamen, Funktionsnamen, Commit-Hashes, Testzahlen.** Dafür ist der
  Schritt-Log da. Ausnahme: ein Bezeichner, den der Nutzer selbst benutzt (`TKT-196`).

Länge nach Inhalt, nicht nach Vorgabe — meist zwei bis vier Absätze. Eine Nachricht, die
nur „Aufgabe erledigt" sagt, ist den Eintrag nicht wert.

Der `title` ist eine kurze Überschrift, kein Satz und keine Wiederholung des ersten Satzes.

## Kommandos

| Kommando | Umfang |
|---|---|
| `schreibe Status` | eine Nachricht über die **aktuelle Aufgabe** (`kind: status`) |
| `schreibe Session` | eine Nachricht über die **ganze Sitzung** (`kind: session`) |

`schreibe Session` läuft zusätzlich **automatisch** beim Abschluss jedes Änderungsauftrags
(Klasse 4 und 5), am selben Auslöser wie der Abschlusskommentar der Projektverfassung.

## Zielprojekt bestimmen (Vorrangregel)

1. **Explizite Referenz im Auftrag** — `schreibe Session PROJ-7`, oder ein Auftrag, der von
   `PROJ`/`MS`/`TASK`/`TKT` ausging. Überschreibt alles; bei `MS`/`TASK`/`TKT` das Projekt
   über `get_reference_context` auflösen.
2. **Bindungsdatei des Arbeitskontexts** — `docs/projekt-kontext.md` (Repo) bzw. das
   Projekt-Doc (Cowork), Abschnitt „Standard-Log-Ziel".
3. **Nichts von beidem** → **fragen und nichts schreiben.** Kein Default-Projekt. Eine
   falsch zugeordnete Nachricht ist schlechter als keine.

Enthält die Bindungstabelle mehr als eine Projektzeile, greift ebenfalls Punkt 3.

## Ablauf

1. **Zielprojekt** nach der Vorrangregel bestimmen.
2. **Nachricht formulieren** aus der eigenen Sitzung — nicht aus dem Journal. Nach den
   Schreibregeln oben.
3. **`append_project_log`** mit `projectId`, `kind`, `title`, `content`. `occurredAt` nur
   setzen, wenn nachträglich für einen früheren Zeitpunkt geschrieben wird.
4. **Kurz im Chat berichten**: welches Projekt, welche Art Nachricht. Kein Schritt-Log
   nötig (kein Repo-Code, reiner MCP-Schreibvorgang).

## Lesen

`get_project_briefing` — mit `reference` (`PROJ-N`) die jüngsten Nachrichten plus offene
und überfällige Aufgaben und Tickets; ohne `reference` eine Zeile je Projekt. Der
Normalfall zum Nachschauen ist aber die Dashboard-Kachel „Projektstand"; das Werkzeug ist
für Rückfragen **innerhalb** einer Sitzung gedacht.

## Bestandsübernahme aus dem alten Tagebuch

Trägt ein Projekt noch einen alten Tagebuchtext (`get_project_diary`), wird er **einmalig**
als Nachricht in den Faden übernommen — `occurredAt` auf `coveredUntil` des Tagebuchs, damit
er sich unter die neueren Nachrichten einsortiert. Danach ist das Tagebuch dieses Projekts
erledigt. Das passiert nur auf ausdrücklichen Auftrag, nicht nebenbei.

## Regeln

- Keine hartcodierten Projektnamen, IDs oder Pfade; generisch gegen den MCP arbeiten.
- Inhalte als Markdown oder HTML; menschenlesbare Daten `dd.MM.yy`, maschinenlesbare ISO 8601.
- Nur lesen und erzählen — keine fachlichen Daten ändern.
- Append-only: bestehende Nachrichten nie korrigieren, sondern eine neue schreiben.
- Schreibvorgänge erzeugen **kein** Journal-Ereignis (das Backend stellt das sicher) —
  keine Rückkopplung in die eigene Quelle.
- Ist die API nicht erreichbar (`fetch failed`) oder fehlt das Schreibrecht: kontrolliert
  abbrechen, als Blocker melden, den Text im Chat ausgeben — nichts erfinden.

Quelle (Ebene 1): Skill Library, Plugin `pm-workflow-skills`.
