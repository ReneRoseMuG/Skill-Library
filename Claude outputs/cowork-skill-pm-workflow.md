---
name: pm-workflow
description: >
  Projektarbeit über den Projekt-Manager-MCP in Claude-Projekten (Cowork) — Kontext laden,
  Arbeitspakete als Meilensteine und Aufgaben, Logs als Kommentare, Wiki-Pflege,
  Sitzungsabschluss. Verwenden, wenn ein Claude-Projekt eine Projekt-Doc
  claude/projekt-kontext.md hat oder eine PROJ-/MS-/TASK-/TKT-Referenz genannt wird.
  Auslöser: "Sitzung abschließen", "logge das", "lege einen Meilenstein an",
  "Aufgabe anlegen", "bearbeite TKT-…", "Tagebuch aktualisieren".
---

# pm-workflow

Cowork-Gegenstück zum Claude-Code-Plugin `pm-workflow-skills`: dieselben Regeln für
Projekt-Manager-Arbeit, ohne Plugin-Mechanik und ohne Stop-Hook. Vorlagenversion **1.0**
(Skill Library, `plugins/pm-workflow-skills/reference/setup/cowork-skill-pm-workflow.md` —
dort zuerst ändern, dann diesen Skill aktualisieren).

## 1. Bindung laden

- Projekt-Doc `claude/projekt-kontext.md` lesen: `PROJ-<id>`, Standard-Log-Ziel,
  Wiki-Wurzelseite, Konventionen. Fehlt sie → Einrichtung anbieten
  (`templates/projekt-setup.md` der Skill Library); bis dahin nur lesend arbeiten.
- Die Tools des MCP-Servers `projekt-manager` verwenden. `list_projects` ist der
  Verbindungstest. Nicht erreichbar → Blocker nennen, nichts erfinden, weiter mit
  Abschnitt 6 (Fallback).

## 2. Sitzungsstart

Bei Arbeit mit Projektbezug `get_reference_context("PROJ-<id>")` laden: Meilensteine,
Aufgaben, Tickets, Kommentare. Großen Baum nach Relevanz zusammenfassen, nicht roh
ausgeben. Der Projekt Manager ist die Quelle der Wahrheit, nicht das Chat-Gedächtnis.

## 3. Arbeitsauftrag mit Referenz (PROJ / MS / TASK / TKT)

1. Kontext laden (`get_reference_context` der Referenz).
2. Auftrag ableiten: Titel, Beschreibung, Abnahmekriterien, anhängende Objekte, offene
   Kommentare. Fehlende Anforderungen nicht erfinden — nachfragen oder Blocker benennen.
3. Pflichtfrage vor jeder Schreibaktion: „Direkt ausführen oder zuerst einen Plan
   erstellen?" Bei Plan: auf Freigabe warten.
4. Ausführen — nur, was durch Auftrag oder freigegebenen Plan gedeckt ist.
5. Log (Abschnitt 5), dann Parent-Status auf `pending`.

## 4. Arbeitspakete pflegen

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
kann. Keine Dateilisten, kein technischer Jargon. HTML.

Tool-Priorität: `add_comment_to_parent` → `add_note_to_parent` (als Log kennzeichnen) →
Fallback aus Abschnitt 6.

## 6. Sitzungsabschluss („Sitzung abschließen")

Ersetzt den Stop-Hook des Plugins und gilt auch, wenn im Auftrag keine PM-Referenz
genannt war:

1. Offene Arbeit als Aufgabe erfassen oder bestehende Aufgaben aktualisieren.
2. Status der bearbeiteten Objekte abschließen (`pending`).
3. Abschlusskommentar am Standard-Log-Ziel, sobald Ergebnisse, Entscheidungen oder
   Probleme entstanden sind. Reine Lektüre ohne Ergebnis: kurz begründen, kein Kommentar.
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

## Regeln

- Keine IDs erfinden; Referenzen per `resolve_reference` prüfen.
- Listen können seitenweise antworten (`{ data, total, page, … }`) — `total` beachten,
  serverseitig filtern statt alles zu laden.
- Nur ändern, was durch Auftrag oder freigegebenen Plan gedeckt ist.
- Tool-Umfang kann vom Plugin-MCP abweichen; fehlt ein Tool, das Nächstliegende nehmen
  und die Abweichung im Abschluss nennen.
