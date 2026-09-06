# Work-Order-Protokoll

Gemeinsames Ablaufmuster für jeden Arbeitsauftrag, dessen Quelle ein Objekt im
Projekt Manager ist (Projekt, Meilenstein, Aufgabe, Ticket, Feature, Use Case).
Plattformneutral — kein Projektname, keine hartcodierte ID, keine Abschnittsnummer
einer bestimmten `agents.md`. Jedes Repo, das diesen Ablauf nutzt, verweist in seiner
eigenen `agents.md` auf seine Logpflicht und trägt sein Standard-Log-Ziel in
`docs/projekt-kontext.md` ein — dieses Dokument selbst bleibt davon unabhängig.

## 1. Kontext laden

Parent-Referenz auflösen (`resolve_reference`), dann Kontext laden
(`get_reference_context`: rekursive Kinder, Notes, Attachments, Comments, Relationen).
Zusätzliche Lesetools nur wenn der geladene Kontext nicht ausreicht. Ist der Parent
nicht ladbar: kontrolliert abbrechen, Blocker dokumentieren statt zu raten.

**Umfang bewusst wählen.** Ohne weitere Angaben lädt `get_reference_context` den
gesamten Teilbaum samt Anhang-Textvorschauen — bei großen Parents (ganzes Projekt,
Meilenstein mit vielen Kindern) ist das sehr viel Kontext. Erst orientieren, dann
vertiefen:

- `depth` begrenzt die Rekursion (`0` = nur das Objekt selbst, `1` = plus direkte Kinder).
- `include` wählt die Support-Arten (z. B. nur `["comments"]`, wenn es um die Absprachen geht).
- `attachmentPreviews: false` lässt die Dateitexte weg — der größte Einzelposten.
- `maxChildrenPerType` deckelt breite Kinderlisten.

Gekürzte Stellen weist das Ergebnis über `childrenTruncated` und `depthLimitReached`
aus — diese Marker lesen und bei Bedarf gezielt nachladen, statt sie zu übergehen.
Für einen einzelnen Arbeitsgegenstand (Ticket, Aufgabe) ist der Vollabzug dagegen
richtig und bleibt die Voreinstellung.

## 2. Auftrag ableiten

Aus dem geladenen Kontext ableiten: Titel, Beschreibung, Status, Abnahmekriterien,
anhängende Arbeitsgegenstände, offene Comments, erkennbare Reihenfolge/Abhängigkeiten/
Blocker. Keine fehlenden Anforderungen erfinden — bei Widerspruch nachfragen oder
Blocker benennen.

## 3. Plan-oder-Ausführen-Frage

Vor jeder Code-, Datei-, Git-, Status- oder Schreibaktion fragen, ob direkt ausgeführt
oder zuerst ein Plan erstellt werden soll. Bei Planwunsch: Plan erstellen, auf
Freigabe warten, nichts vorher anfassen.

## 4. Ausführung

Die Projektverfassung des Repos (`agents.md`/`CLAUDE.md`), dessen Teststrategie,
Log-Pflicht, Git-Vorgaben und Sicherheitsregeln einhalten. Nur ändern was durch den
Auftrag oder den freigegebenen Plan gedeckt ist. Blockierte Teilaufgaben dokumentieren,
mit unabhängigen Schritten weitermachen statt komplett zu stoppen.

Repo-eigene, technologiestack-spezifische Skills (Architektur/Design, Datenmodell,
Exploration, Planungsgate, Testentwurf, Code-Disziplin — siehe `dev-testing/` in
dieser Bibliothek) anwenden, wenn das Repo sie bereitstellt.

## 5. Log nach der Ausführung

Nach Abschluss **automatisch und ohne Rückfrage** einen Abschlusskommentar schreiben —
Pflicht, nicht optional. Geloggt wird an den Auftrags-Parent **und** an das
projektweite Standard-Log-Ziel aus `docs/projekt-kontext.md` des Repos, sofern beide
nicht identisch sind. Diese Logpflicht gilt unabhängig davon, ob der Auftrag über
eine PM-Referenz hereinkam — siehe den sitzungsweiten Logging-Hinweis (Stop-Hook)
dieses Plugins für Arbeit ohne genannte Referenz.

Der Log-Inhalt ist für den Nutzer geschrieben: gut lesbar, keine technischen
Dateilisten. Er benennt was erledigt wurde, wichtige Entscheidungen oder
Einschränkungen, durchgeführte Prüfungen, offene Punkte oder Blocker, und welches
Ergebnis der Nutzer erwarten kann.

Tool-Priorität: `add_comment_to_parent` → `add_note_to_parent` (als Log kennzeichnen)
→ wenn beides nicht verfügbar: Blocker melden und Log im Chat ausgeben.

## 6. Statusabschluss

Parent-Status auf `pending` setzen — erst nach Ausführung (und optionaler
Log-Rückfrage). Fehlt ein passendes Status-Update-Tool: als Blocker melden statt
zu improvisieren.

---
Fertige, direkt nutzbare Fassung dieses Musters: `skills/mcp-code-auftrag/SKILL.md` in diesem Plugin.
