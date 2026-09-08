# Projektkontext

Bindung dieses Arbeitskontexts an den Projekt Manager. Dies ist die **einzige** Stelle mit
konkreten Projekt-Manager-IDs und Rechnerpfaden — Skills, Hooks und Projektverfassung
verweisen hierher und enthalten selbst keine ID und keinen Pfad.

| Feld | Wert |
|---|---|
| Arbeitskontext | {{KONTEXT_NAME}} ({{KONTEXT_ART}}) |
| Projekt | `PROJ-{{PROJEKT_ID}}` — {{PROJEKT_NAME}} |
| Standard-Log-Ziel | `{{LOG_ZIEL}}` |
| Wiki-Wurzelseite | Seite {{WIKI_ID}} — „{{WIKI_TITEL}}" |
| Datenordner | {{DATENORDNER_NAME}} (Nextcloud-synchronisiert; lokaler Pfad je Rechner s. u.) |
| Repo | {{REPO_REMOTE}} |
| Master dieser Bindung | {{MASTER}} |
| Eingerichtet am | {{DATUM}} |

<!--
KONTEXT_ART: „Repo" oder „Claude-Projekt". Ohne Wiki: Zeile „Wiki-Wurzelseite" auf „kein Wiki".
DATENORDNER_NAME: Name bzw. relativer Pfad des Ordners innerhalb von Nextcloud (rechnerunabhängig),
  z. B. „Projekte/MuG Plan"; ohne Datenordner: „kein Datenordner".
REPO_REMOTE: Remote-URL des Git-Repos; ohne Repo: „kein Repo".
MASTER: „Projekt-Doc claude/projekt-kontext.md im Claude-Projekt „<Name>"" — oder „diese Datei",
  wenn das Projekt kein Claude-Projekt hat. Spiegel (Datenordner, Repo) werden bei Abweichung
  aus dem Master aktualisiert, nie umgekehrt ohne Rückfrage.
-->

## Arbeitsplätze

Das Projekt wird auf mehreren Rechnern bearbeitet; der Projekt Manager ist ihr gemeinsames
Gedächtnis, diese Tabelle ihre lokale Bindung. Je Rechner eine Zeile. Schlüssel ist der
Gerätename, wie ihn die Claude-Desktop-App meldet (Cowork: `get_device_info` → `deviceName`;
Claude Code: `hostname`). Pfade absolut, so wie sie auf **diesem** Rechner gelten —
Benutzername und Ordnerstruktur unterscheiden sich je Rechner.

| Gerätename | Datenordner (lokaler Nextcloud-Pfad) | Repo (lokaler Klon) | Bemerkung |
|---|---|---|---|
| {{GERAET_1}} | `{{DATENORDNER_PFAD_1}}` | `{{REPO_PFAD_1}}` | {{BEMERKUNG_1}} |

<!-- Ohne Repo: Spalte „Repo" auf „—". Weitere Rechner werden beim ersten Aufruf dort ergänzt. -->

Regeln:
- Unbekannter Gerätename → Zeile beim Nutzer erfragen, Pfade auf Existenz prüfen, dann
  ergänzen. Nie raten, nie Pfade eines anderen Rechners übernehmen.
- Änderungen an dieser Tabelle zuerst im Master, dann in den Spiegeln.
- Ein Spiegel dieser Datei liegt als `projekt-kontext.md` im Datenordner — dadurch auf allen
  Rechnern vorhanden, auch ohne Zugriff auf das Claude-Projekt.

## Arbeitskonventionen

- **Arbeitspakete:** Meilensteine (`create_milestone`) unter dem Projekt, Aufgaben
  (`add_task_to_parent`) unter dem Meilenstein; Tickets für Fehler und Änderungswünsche.
  Erledigte Objekte auf Status `pending` setzen — die Abnahme macht der Nutzer.
- **Logs:** Arbeitsergebnisse, Entscheidungen und Probleme als Kommentar
  (`add_comment_to_parent`) am bearbeiteten Objekt **und** am Standard-Log-Ziel, sofern
  verschieden. Für den Nutzer geschrieben: was erledigt, welche Entscheidungen, was offen —
  keine Dateilisten. Automatisch, ohne Rückfrage.
- **Spezifikation und Doku:** ausschließlich Wiki-Seiten unterhalb der Wurzelseite
  (Ablage: `reference/wiki-ablage.md` des Plugins `pm-workflow-skills`). Keine
  Feature-/Use-Case-Objekte mehr anlegen.
- **Sitzungsabschluss:** offene Arbeit als Aufgabe erfassen, Status abschließen,
  Abschlusskommentar schreiben — auch wenn im Auftrag keine PM-Referenz genannt war.
- **Format:** Textfelder des Projekt Managers sind HTML. Wiki-Inhalte dürfen Markdown sein,
  Tabellen nur als HTML.

## Projektspezifisches

<!-- Freitext: Besonderheiten, feste Meilensteine, weitere Referenzen, Abweichungen von den Konventionen. -->
