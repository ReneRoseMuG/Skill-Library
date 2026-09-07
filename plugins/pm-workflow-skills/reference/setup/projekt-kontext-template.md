# Projektkontext

Bindung dieses Arbeitskontexts an den Projekt Manager. Dies ist die **einzige** Stelle mit
konkreten Projekt-Manager-IDs — Skills, Hooks und Projektverfassung verweisen hierher und
enthalten selbst keine ID.

| Feld | Wert |
|---|---|
| Arbeitskontext | {{KONTEXT_NAME}} ({{KONTEXT_ART}}) |
| Projekt | `PROJ-{{PROJEKT_ID}}` — {{PROJEKT_NAME}} |
| Standard-Log-Ziel | `{{LOG_ZIEL}}` |
| Wiki-Wurzelseite | Seite {{WIKI_ID}} — „{{WIKI_TITEL}}" |
| Eingerichtet am | {{DATUM}} |

<!-- KONTEXT_ART: „Repo" oder „Claude-Projekt". Ohne Wiki: Zeile „Wiki-Wurzelseite" auf „kein Wiki" setzen. -->

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
