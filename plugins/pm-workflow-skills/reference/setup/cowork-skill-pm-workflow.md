---
name: pm-workflow
description: >
  Projektarbeit über den Projekt-Manager-MCP in Claude-Projekten (Cowork) — Bindung laden,
  Arbeitsplatz (Rechner, Datenordner, Repo) erkennen, Arbeitspakete als Meilensteine und
  Aufgaben, Logs als Kommentare, Wiki-Pflege, Sitzungsabschluss, Projekt einrichten.
  Verwenden, wenn ein Claude-Projekt eine Projekt-Doc claude/projekt-kontext.md hat, eine
  PROJ-/MS-/TASK-/TKT-Referenz genannt wird oder ein Projekt an den Projekt Manager
  angebunden werden soll. Auslöser: "Projektkontext laden", "Sitzung abschließen",
  "logge das", "lege einen Meilenstein an", "Aufgabe anlegen", "bearbeite TKT-…",
  "Tagebuch aktualisieren", "richte das Projekt ein", "neuer Rechner".
---

# pm-workflow

Cowork-Gegenstück zum Claude-Code-Plugin `pm-workflow-skills`: dieselben Regeln für
Projekt-Manager-Arbeit, ohne Plugin-Mechanik und ohne Stop-Hook. Vorlagenversion **1.1**
(Skill Library, `plugins/pm-workflow-skills/reference/setup/cowork-skill-pm-workflow.md` —
dort zuerst ändern, dann diesen Skill aktualisieren).

**Modell:** Ein Projekt existiert an vier Orten — Projekt-Manager-Projekt (gemeinsames
Gedächtnis aller Rechner), Claude-Projekt, lokaler Datenordner (Nextcloud-synchronisiert)
und ggf. Git-Repo (lokaler Klon je Rechner). Die Projekt-Doc `claude/projekt-kontext.md`
ist der **Master** der Bindung; `projekt-kontext.md` im Datenordner und
`docs/projekt-kontext.md` im Repo sind **Spiegel**. Der Projekt Manager ist die Quelle der
Wahrheit für den Arbeitsstand, nicht das Chat-Gedächtnis.

## 0. Modus

- „richte das Projekt ein", „Projekt anbinden", „neuer Rechner", „Arbeitsplatz ergänzen",
  oder es gibt keine Projekt-Doc `claude/projekt-kontext.md` → Abschnitt 9 (Einrichtung).
- Sonst: Abschnitte 1–8 in dieser Reihenfolge, soweit die Aufgabe sie braucht.

## 1. Bindung laden

- Projekt-Doc `claude/projekt-kontext.md` lesen: `PROJ-<id>`, Standard-Log-Ziel,
  Wiki-Wurzelseite, Datenordner, Repo, Tabelle „Arbeitsplätze", Konventionen,
  Projektspezifisches. Fehlt sie → Abschnitt 9; bis dahin nur lesend arbeiten.
- Die Tools des MCP-Servers `projekt-manager` verwenden. `list_projects` ist der
  Verbindungstest. Nicht erreichbar → Blocker nennen, nichts erfinden, weiter mit
  Abschnitt 6 (Fallback). MCP und Rechner sind nur erreichbar, solange die Sitzung mit dem
  Rechner verbunden ist (Desktop-App geöffnet).

## 2. Arbeitsplatz erkennen

1. `get_device_info` → `deviceName`. Kein Rechner erreichbar → Aufgabe ohne lokale Dateien
   fortsetzen, Blocker nennen; keine Pfade aus der Tabelle verwenden.
2. Zeile mit diesem Gerätenamen in „Arbeitsplätze" suchen → Datenordner-Pfad und Repo-Pfad
   **dieses** Rechners. Pfade anderer Zeilen nie verwenden — Benutzername und
   Ordnerstruktur unterscheiden sich je Rechner.
3. Keine Zeile → Abschnitt 9, Kurzablauf „Nur Arbeitsplatz ergänzen". Bis dahin keine
   lokalen Pfade raten.
4. Ordnerzugriff (`device_request_folder_access`) nur anfordern, wenn die Aufgabe Dateien
   braucht: Datenordner für Projektdateien, Repo nur bei Code oder Repo-Doku. Jede Anfrage
   kostet eine Bestätigung des Nutzers — nicht pauschal zu Beginn anfordern.
5. Ist der Datenordner verbunden: dessen `projekt-kontext.md` mit der Projekt-Doc
   vergleichen. Identisch → nichts tun. Abweichend → Unterschiede zeigen; der Nutzer
   entscheidet, welcher Stand gilt (meist der Master; der Spiegel kann neuer sein, wenn er
   zuletzt auf dem anderen Rechner ergänzt wurde). Danach angleichen. Fehlt der Spiegel →
   aus dem Master anlegen.

## 3. Sitzungsstart

Bei Arbeit mit Projektbezug `get_reference_context("PROJ-<id>")` laden: Meilensteine,
Aufgaben, Tickets, Kommentare. Großen Baum nach Relevanz zusammenfassen, nicht roh
ausgeben. Auf Kommentare achten, die von einer Sitzung auf dem anderen Rechner stammen —
sie sind der Übergabepunkt zwischen den Arbeitsplätzen.

## 4. Arbeitsauftrag mit Referenz (PROJ / MS / TASK / TKT)

1. Kontext laden (`get_reference_context` der Referenz).
2. Auftrag ableiten: Titel, Beschreibung, Abnahmekriterien, anhängende Objekte, offene
   Kommentare. Fehlende Anforderungen nicht erfinden — nachfragen oder Blocker benennen.
3. Pflichtfrage vor jeder Schreibaktion: „Direkt ausführen oder zuerst einen Plan
   erstellen?" Bei Plan: auf Freigabe warten.
4. Ausführen — nur, was durch Auftrag oder freigegebenen Plan gedeckt ist. Lokale Dateien
   liegen im Datenordner bzw. Repo dieses Rechners (Abschnitt 2); Ergebnisse dorthin
   schreiben, damit Nextcloud bzw. Git sie zum anderen Rechner bringen.
5. Log (Abschnitt 5), dann Parent-Status auf `pending`.

## 4a. Arbeitspakete pflegen

- Meilenstein: `create_milestone(projectId, name, description, status, startDate, dueDate)`
- Aufgabe: `add_task_to_parent(parentType: "milestone" | "project", parentId, title, description, status, priority)`
- Ticket (Fehler, Änderungswunsch): `add_ticket_to_parent`
- Status: `update_task` / `update_milestone` / `update_ticket`. Erledigt heißt `pending` —
  die Abnahme macht der Nutzer.
- Alle Beschreibungs- und Kommentartexte sind HTML, nie Markdown
  (`<h2>`, `<p>`, `<ul><li>`, `<strong>`).

## 5. Log-Pflicht

Nach jedem abgeschlossenen Arbeitsschritt automatisch und ohne Rückfrage:
`add_comment_to_parent` am bearbeiteten Objekt **und** am Standard-Log-Ziel (wenn
verschieden). Inhalt für den Nutzer: was erledigt wurde, Entscheidungen und
Einschränkungen, durchgeführte Prüfungen, offene Punkte, was er als Ergebnis erwarten
kann; bei lokalen Ergebnissen den Ort (Datenordner oder Repo, nicht der absolute Pfad) und
den Arbeitsplatz nennen, damit die nächste Sitzung auf dem anderen Rechner weiß, wo sie
weitermacht. Keine Dateilisten, kein technischer Jargon. HTML.

Tool-Priorität: `add_comment_to_parent` → `add_note_to_parent` (als Log kennzeichnen) →
Fallback aus Abschnitt 6.

## 6. Sitzungsabschluss („Sitzung abschließen")

Ersetzt den Stop-Hook des Plugins und gilt auch, wenn im Auftrag keine PM-Referenz
genannt war:

1. Offene Arbeit als Aufgabe erfassen oder bestehende Aufgaben aktualisieren.
2. Status der bearbeiteten Objekte abschließen (`pending`).
3. Abschlusskommentar am Standard-Log-Ziel, sobald Ergebnisse, Entscheidungen oder
   Probleme entstanden sind — mit Arbeitsplatz und dem Hinweis, was auf dem anderen
   Rechner erst nach Nextcloud-Sync bzw. `git pull` verfügbar ist (nicht committete
   Änderungen ausdrücklich nennen). Reine Lektüre ohne Ergebnis: kurz begründen, kein
   Kommentar.
4. Kurz im Chat berichten.

**Fallback bei nicht erreichbarem MCP:** Log-Text im Chat ausgeben und als Projekt-Doc
`claude/session-log-<JJJJ-MM-TT>.md` ablegen. Beim nächsten erreichbaren Zugriff als
Kommentar nachtragen und die Doc entfernen.

## 7. Wiki

Spezifikation und Dokumentation ausschließlich in Wiki-Seiten unterhalb der
Wurzelseite aus `claude/projekt-kontext.md`. Immer `get_wiki_page` vor
`update_wiki_page` — es ersetzt den Inhalt vollständig. Markdown wird konvertiert,
Tabellen nur als HTML. Struktur `FT(NN)` → `FT(NN) – Use Cases` → `UC (NN/MM)`; Nummern
nie wiederverwenden; vor dem Anlegen die vorhandenen Nummern über `list_wiki_pages`
prüfen. Redaktionsnachweis als Kommentar an der Seite (`parentType: "wikiPage"`, wenn
der Server das unterstützt; sonst am Projekt mit Seitentitel und Seiten-ID im ersten
Satz). Keine Feature- oder Use-Case-Objekte anlegen.

## 8. Tagebuch (auf Zuruf)

`get_project_diary(projectId)` → `report_activity(from = coveredUntil)` → je Projekt
datierte Abschnitte (`dd.MM.yy`), neueste oben, zusammenhängender Text, HTML →
`update_diary_entry` bzw. `create_diary_entry` mit neuem `coveredUntil` und `sourceCount`.

## 9. Einrichtung (Projekt anbinden, neuer Rechner)

Cowork-Fassung des Ablaufs `projekt-setup` (Kontext B). Maßgeblich ist die Referenz der
Skill Library — **wörtlich lesen, nicht aus dem Gedächtnis nachbauen**:
`plugins/pm-workflow-skills/reference/setup/projekt-setup.md` samt Vorlagen im selben
Ordner (`projekt-kontext-template.md`, `projektanweisungen-cowork.md`). Quelle: lokaler
Klon der Skill Library (Arbeitsplatz-Zeile des Claude-Projekts „Skill Library" oder
verbundener Ordner), sonst `git clone --depth 1 https://github.com/ReneRoseMuG/Skill-Library.git`
im Arbeitsbereich der Sitzung. Web-Abrufe, die Seiten zusammenfassen, sind für Vorlagen
ungeeignet.

Kurzfassung:

1. **Verbindung:** `list_projects`. Fehler → nichts schreiben, abbrechen.
2. **Kurzablauf „Nur Arbeitsplatz ergänzen"** (Projekt-Doc vorhanden, Gerätename fehlt):
   Gerätename nennen; Datenordner-Pfad und Repo-Pfad auf diesem Rechner erfragen (Hilfe:
   `device_list_dir` auf `~` zeigt Ordnernamen ohne Zugriffsanfrage); jeden Pfad mit
   `device_list_dir` prüfen; Zeile in der Projekt-Doc ergänzen (Master zuerst); Spiegel im
   Datenordner angleichen (`device_request_folder_access` → `device_commit_files`);
   Kommentar am Standard-Log-Ziel „Arbeitsplatz ergänzt (dd.MM.yy): <Gerätename> —
   Datenordner, Repo". IDs nicht erneut abfragen. Fertig.
3. **Vollständige Einrichtung** — eine Frage je Schritt, jede Antwort verifizieren und
   bestätigen lassen: **2a** `PROJ-<id>` (Hilfe: Kurzliste; fehlt es → `create_project`,
   falls vorhanden) → `get_reference_context`. **2b** Wiki-Wurzelseite (Hilfe:
   `list_wiki_pages`; „keine" → anlegen anbieten oder ohne Wiki) → `get_wiki_page`.
   **2c** Standard-Log-Ziel, Vorschlag `PROJ-<id>`. **2e** Name des Claude-Projekts.
   **2f** Arbeitsplatz wie im Kurzablauf, zusätzlich Datenordner-Name in Nextcloud und
   Repo-Remote. **2g** Master = diese Projekt-Doc.
4. **Schreiben:** Projekt-Doc `claude/projekt-kontext.md` aus `projekt-kontext-template.md`
   (existiert sie: mergen, Änderung zeigen). Projektanweisungen aus
   `projektanweisungen-cowork.md` befüllen und als Text zum Einfügen geben — sie können
   nicht per Werkzeug gesetzt werden. Spiegel `projekt-kontext.md` im Datenordner
   schreiben bzw. abgleichen.
5. **Skill:** dieser Skill ist bereits vorhanden. Ist seine Vorlagenversion älter als die
   der Datei in der Skill Library → Aktualisierung mit dem vollständigen neuen Inhalt
   vorschlagen. Hinweis: Cowork hat keinen Stop-Hook; Abschluss über „Sitzung abschließen".
6. **Startkommentar** am Projekt (HTML, ohne weitere Rückfrage): „Arbeitskontext angebunden
   (dd.MM.yy): <Name> — Claude-Projekt", Standard-Log-Ziel, Wiki-Wurzel, Datenordner/Repo,
   Arbeitsplatz, Master, „Account-Skill pm-workflow <Vorlagenversion>". Log-Ziel ≠ Projekt →
   dort ebenfalls. Das ist der Steckbrief des Projekts im gemeinsamen Gedächtnis.
7. **Verifikation:** Projekt-Doc zurücklesen (Platzhalter ersetzt), Master = Spiegel,
   Kommentar per `get_reference_context` sichtbar. Ergebnis-Tabelle nach der Referenz mit
   offenen Handgriffen (Projektanweisungen einfügen, `wikiPageId` in der App setzen — per
   MCP nicht setzbar —, Zeile für den zweiten Rechner beim ersten Aufruf dort).

## Regeln

- Keine IDs erfinden; Referenzen per `resolve_reference` prüfen.
- Keine Pfade erfinden; Schlüssel jeder Arbeitsplatz-Zeile ist der Gerätename, jeder Pfad
  ist auf dem aktuellen Rechner geprüft, Pfade anderer Rechner werden nie übernommen.
- Master vor Spiegel: Bindung zuerst in der Projekt-Doc ändern, dann im Datenordner; ein
  Spiegel wird nie stillschweigend zurückgeschrieben — Abweichung zeigen, Nutzer entscheidet.
- Ordnerzugriff nur anfordern, wenn der Schritt ihn braucht.
- Listen können seitenweise antworten (`{ data, total, page, … }`) — `total` beachten,
  serverseitig filtern statt alles zu laden.
- Nur ändern, was durch Auftrag oder freigegebenen Plan gedeckt ist.
- Tool-Umfang kann vom Plugin-MCP abweichen; fehlt ein Tool, das Nächstliegende nehmen
  und die Abweichung im Abschluss nennen.
