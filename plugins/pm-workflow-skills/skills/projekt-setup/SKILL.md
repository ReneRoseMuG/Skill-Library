---
name: projekt-setup
description: >
  Richtet den aktuellen Arbeitskontext (Repo oder Claude-Projekt) dauerhaft an ein
  Projekt des Projekt Managers an: fragt Projekt-ID, Wiki-Seite und den Arbeitsplatz
  (Datenordner, Repo auf diesem Rechner) ab, verifiziert sie per MCP bzw. Dateisystem,
  schreibt Bindungsdatei und Datenordner-Spiegel, stellt die Skills bereit, ergänzt die
  Projektverfassung und loggt einen Startkommentar. Auslöser: "richte das Projekt ein",
  "Projekt an den Projekt Manager anbinden", "Projekt-Setup", "projekt-setup",
  "Projekt-Manager-Anbindung einrichten", "neuer Rechner", "Arbeitsplatz ergänzen",
  ein Rechner fehlt in der Tabelle "Arbeitsplätze", oder eine Sitzung erhält
  templates/projekt-setup.md der Skill Library als Auftrag.
---

# Projekt-Setup

Vollständiger Ablauf, Regeln und Ergebnisformat:
`${CLAUDE_PLUGIN_ROOT}/reference/setup/projekt-setup.md` — **vor dem ersten Schritt lesen.**
Vorlagen liegen im selben Ordner `${CLAUDE_PLUGIN_ROOT}/reference/setup/`. Diese Seite ist
die Kurzfassung.

## Ablauf

| # | Schritt | Kern |
|---|---|---|
| 0 | Kontext erkennen | A = Claude Code im Repo (`.claude/`, `agents.md`/`CLAUDE.md`), B = Claude-Projekt in Cowork (Projekt-Docs, Projektanweisungen). Unklar → fragen. Kontext schon eingerichtet, nur dieser Rechner fehlt in „Arbeitsplätze" → **Kurzablauf**: 1 → Master lesen → 2f → Zeile ergänzen → Spiegel → Kommentar „Arbeitsplatz ergänzt" → 6; IDs nicht erneut abfragen. |
| 1 | Verbindung prüfen | `list_projects`. Fehler → Blocker, **nichts schreiben**, abbrechen. |
| 2 | Bindung abfragen | Eine Frage je Schritt, jede Antwort per MCP verifizieren und bestätigen lassen: **2a** `PROJ-<id>` (Hilfe: Kurzliste; fehlt es → `create_project`, falls vorhanden) → `get_reference_context`. **2b** Wiki-Wurzelseite (Hilfe: `list_wiki_pages`; „keine" → anlegen anbieten oder ohne Wiki) → `get_wiki_page`. **2c** Standard-Log-Ziel, Vorschlag `PROJ-<id>`. **2d** nur A: `dev-testing-skills` ja/nein. **2e** Name des Arbeitskontexts. **2f** Arbeitsplatz: Gerätename (A `hostname`, B `get_device_info`), Datenordner (Name in Nextcloud + lokaler Pfad), Repo (Remote + lokaler Klon), Bemerkung — jeden Pfad auf diesem Rechner prüfen, nie Pfade eines anderen Rechners übernehmen. **2g** Master: Projekt-Doc des Claude-Projekts, sonst `docs/projekt-kontext.md`. |
| 3 | Bindung schreiben | A: `docs/projekt-kontext.md` (`projekt-kontext-template.md`, inkl. Tabelle „Arbeitsplätze"), `.claude/project-context/wiki.md` (`wiki-kontext-template.md`). B: Projekt-Doc `claude/projekt-kontext.md`; Projektanweisungen aus `projektanweisungen-cowork.md` als Text zum Einfügen. A und B: Spiegel `projekt-kontext.md` im Datenordner schreiben bzw. mit dem Master abgleichen (Abweichung zeigen, Nutzer entscheidet). Bestehende Dateien mergen, Änderung zeigen. |
| 4 | Skills bereitstellen | A: `.claude/settings.json` nach `templates/settings-snippet.md` mergen, `ensure-plugins.sh` nach `.claude/hooks/`, `claude plugin marketplace add` + `install`, bei dev-testing `tech-stack.md` aus Vorlage (Unbelegtes `TODO`), Abschnitt aus `agents-abschnitt-projekt-manager.md` in `agents.md`/`CLAUDE.md`, gleichnamige `.claude/skills/*` nur nach Bestätigung löschen. B: Account-Skill `pm-workflow` prüfen; fehlt er oder ist seine Vorlagenversion älter → Inhalt von `cowork-skill-pm-workflow.md` unverändert als Skill vorschlagen; Hinweis: kein Stop-Hook, Abschluss über „Sitzung abschließen". |
| 5 | Startkommentar | `add_comment_to_parent` am Projekt (HTML): „Arbeitskontext angebunden (dd.MM.yy): Name — Art", Standard-Log-Ziel, Wiki-Wurzel, Datenordner/Repo, Arbeitsplatz, Master, Skills mit Version. Log-Ziel ≠ Projekt → dort ebenfalls. Ohne weitere Rückfrage. |
| 6 | Verifikation | Dateien nochmals lesen (Platzhalter ersetzt, JSON gültig, Pfade vorhanden), Master = Spiegel, Kommentar per `get_reference_context` sichtbar, Ergebnis-Tabelle mit offenen Handgriffen. |

## Regeln

- Keine IDs erfinden — verifiziert **und** bestätigt, bevor sie in eine Datei kommen.
- Keine Pfade erfinden — auf dem aktuellen Rechner geprüft; Schlüssel ist der Gerätename.
- Master vor Spiegel: Bindung zuerst im Master ändern, dann in den Spiegeln; Spiegel nie
  stillschweigend zurückschreiben.
- Bestehende Dateien mergen, nie stillschweigend überschreiben. Nichts löschen ohne
  Bestätigung. Ordnerzugriff (Cowork) nur anfordern, wenn der Schritt ihn braucht.
- Kommentar-/Beschreibungstexte HTML; Wiki-Inhalte dürfen Markdown sein (Tabellen HTML).
- Nur Kern-Tools verwenden (`list_projects`, `resolve_reference`, `get_reference_context`,
  `list_wiki_pages`, `get_wiki_page`, `create_wiki_page`, `add_comment_to_parent`,
  ggf. `create_project`) — der Tool-Umfang unterscheidet sich zwischen Plugin-MCP und
  Desktop-Anbindung.
- Versionen aus `plugin.json` bzw. der Vorlagenzeile lesen, nicht raten.

## Ergebnis

Tabelle nach `reference/setup/projekt-setup.md`: Kontext, Projekt, Wiki, Log-Ziel,
Arbeitsplatz, Master/Spiegel, Dateien, Skills, Startkommentar, offene Handgriffe
(Projektanweisungen einfügen, `wikiPageId` in der App setzen, Commit, `TODO`s in
`tech-stack.md`, Zeile für den zweiten Rechner beim ersten Aufruf dort).

Quelle (Ebene 1): Skill Library, Plugin `pm-workflow-skills`, `reference/setup/projekt-setup.md` — dort zuerst ändern, dann hier nachziehen.
