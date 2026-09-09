---
name: projektstand
description: >
  Schreibt den Arbeitsstand eines Projekts als lesbare Erzählung fort — während der
  Arbeit, nicht nachträglich aus dem Journal. Zwei Kommandos: „schreibe Status" für die
  aktuelle Aufgabe, „schreibe Session" für die ganze Sitzung. Beide hängen einen
  Verlaufs-Eintrag an und frischen den Stand-Kopf auf. Auslöser: "schreibe Status",
  "schreibe Session", "Projektstand schreiben", "Stand festhalten", "Session festhalten",
  sowie der automatische Abschluss eines Änderungsauftrags.
---

# Projektstand

## Zweck

Hält je Projekt zwei Dinge aktuell:

- **Stand** — ein kurzer, immer aktueller Kopf: Wo stehen wir, was ist offen, was kommt als
  Nächstes, wann wurde zuletzt gearbeitet. Wird bei jedem Schreibvorgang überschrieben.
- **Verlauf** — datierte Erzähl-Einträge, append-only. Wird nur ergänzt, nie umgeschrieben.

Der Text entsteht aus dem, was der Agent in dieser Sitzung selbst getan hat — **keine**
Recherche im Änderungsjournal, kein Nachladen des Bestands. Das ist der Unterschied zum
Skill `tagebuch`, der nachträglich aus `report_activity` erzählt und weiterhin für
Zeiträume ohne Agent-Sitzung zuständig bleibt.

## Kommandos

| Kommando | Wirkung |
|---|---|
| `schreibe Status` | Ein Verlaufs-Eintrag (`kind: status`) über die **aktuelle Aufgabe** plus Stand-Kopf neu |
| `schreibe Session` | Ein Verlaufs-Eintrag (`kind: session`) über die **ganze Sitzung** plus Stand-Kopf neu |

`schreibe Session` läuft zusätzlich **automatisch** beim Abschluss jedes Änderungsauftrags
(Klasse 4 und 5), am selben Auslöser wie der Abschlusskommentar der Projektverfassung.
Beide Kommandos schreiben immer **beide** Schichten — der Nutzer muss den Unterschied
zwischen Stand und Verlauf nie kennen.

## Zielprojekt bestimmen (Vorrangregel)

1. **Explizite Referenz im Auftrag** — `schreibe Session PROJ-7`, oder ein Auftrag, der von
   `PROJ`/`MS`/`TASK`/`TKT` ausging. Überschreibt alles; bei `MS`/`TASK`/`TKT` das Projekt
   über `get_reference_context` auflösen.
2. **Bindungsdatei des Arbeitskontexts** — `docs/projekt-kontext.md` (Repo) bzw. das
   Projekt-Doc (Cowork), Abschnitt „Standard-Log-Ziel".
3. **Nichts von beidem** → **fragen und nichts schreiben.** Kein Default-Projekt, keine
   Sammelablage. Ein falsch zugeordneter Eintrag ist schlechter als kein Eintrag.

Enthält die Bindungstabelle mehr als eine Projektzeile, greift ebenfalls Punkt 3.

## Ablauf

### 1. Zielprojekt bestimmen
Nach der Vorrangregel oben. Ohne eindeutiges Projekt abbrechen und fragen.

### 2. Verlaufs-Eintrag formulieren
Aus der eigenen Sitzung, nicht aus dem Journal. Fester Bauplan, drei bis sechs Sätze
Fließtext in Anwendersprache:

- **Was** wurde gemacht,
- **warum so** entschieden — nur wenn eine Entscheidung fiel,
- **Zustand jetzt**,
- **was offen** bleibt oder als Nächstes ansteht.

Keine Dateilisten, keine Commit-Hashes, keine Funktionsnamen — dafür ist der Schritt-Log da.
Der `title` ist eine kurze Überschrift, kein Satz.

`append_project_log` mit `projectId`, `kind` (`status` oder `session`), `title`, `content`.
`occurredAt` nur setzen, wenn nachträglich für einen anderen Zeitpunkt geschrieben wird.

### 3. Stand-Kopf neu setzen
`set_project_status` mit `projectId` und:

- `content` — Lage in drei bis fünf Sätzen. Ersetzt den bisherigen Text vollständig,
  ist also **keine** Fortschreibung, sondern eine frische Kurzfassung.
- `openPoints` — höchstens fünf Punkte, nach Dringlichkeit geordnet, als Liste.
- `nextStep` — genau ein Satz.
- `lastWorkedAt` — weglassen; das Werkzeug setzt den Aufrufzeitpunkt.

Das Werkzeug entscheidet selbst zwischen Anlegen und versionsgeschütztem Fortschreiben.
Bei `409 CONFLICT` erneut aufrufen — der Kopf ist kurz, ein zweiter Versuch ist billig.

**Bestandsübernahme (automatisch):** Trägt ein Projekt noch einen alten Tagebuchtext, sichert
das Werkzeug ihn beim **ersten** Aufruf selbsttätig als Verlaufs-Eintrag, bevor es den Kopf
ersetzt — `content` wird vollständig überschrieben und es gibt keine Versionshistorie, der
Text wäre sonst unwiederbringlich weg. Das passiert genau einmal je Projekt (Marker: noch nie
gesetztes `lastWorkedAt`) und muss nicht von Hand ausgelöst werden. Schlägt die Sicherung
fehl, bricht der gesamte Vorgang ab und der Alt-Text bleibt unangetastet.

### 4. Kurz im Chat berichten
Welches Projekt, welche Art Eintrag, ein Satz zum neuen Stand. Kein Schritt-Log nötig
(kein Repo-Code, reiner MCP-Schreibvorgang).

## Lesen

`get_project_briefing` — mit `reference` (`PROJ-N`) ausführlich für ein Projekt, ohne
`reference` eine Zeile je Projekt über alle Projekte. Der Normalfall zum Nachschauen ist
aber die Dashboard-Kachel „Projektstand" in der App; das Werkzeug ist für Rückfragen
**innerhalb** einer Sitzung gedacht.

Meldet das Briefing `unnarrated.count > 0`, wurde seit der letzten Erzählung außerhalb einer
Agent-Sitzung gearbeitet. Das ist ein **Hinweis an den Nutzer**, kein Auftrag: Nacherzählen
übernimmt auf ausdrücklichen Wunsch der Skill `tagebuch`.

## Regeln

- Keine hartcodierten Projektnamen, IDs oder Pfade; generisch gegen den MCP arbeiten.
- Inhalte als Markdown oder HTML; menschenlesbare Daten `dd.MM.yy`, maschinenlesbare ISO 8601.
- Nur lesen und erzählend verdichten — keine fachlichen Daten ändern.
- Der Verlauf ist append-only: bestehende Einträge nie korrigieren, sondern einen neuen
  Eintrag schreiben.
- Stand- und Verlaufs-Schreibvorgänge erzeugen **kein** Journal-Ereignis (das Backend stellt
  das sicher) — keine Rückkopplung in die eigene Quelle.
- Ist die API nicht erreichbar (`fetch failed`) oder fehlt das Schreibrecht: kontrolliert
  abbrechen, als Blocker melden, den Text im Chat ausgeben — nichts erfinden.

Quelle (Ebene 1): Skill Library, Plugin `pm-workflow-skills`.
