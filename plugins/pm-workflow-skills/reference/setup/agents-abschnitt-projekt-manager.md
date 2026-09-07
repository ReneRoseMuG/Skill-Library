## Projekt-Manager-Anbindung

Dieses Repo ist an den Projekt Manager gebunden. Bindung und IDs stehen in
`docs/projekt-kontext.md` (Wiki-Wurzel zusätzlich in `.claude/project-context/wiki.md`).
Skills kommen aus dem Plugin `pm-workflow-skills` der Skill Library; dieser Abschnitt
enthält bewusst keine ID.

- **Sitzungsstart:** Bei Arbeit mit Projektbezug den Stand über `get_reference_context`
  laden, statt aus dem Gedächtnis zu arbeiten. Der Projekt Manager ist die Quelle der
  Wahrheit.
- **Arbeitspakete:** als Meilensteine und Aufgaben im Projekt Manager führen; erledigte
  Objekte auf `pending` setzen, die Abnahme macht der Nutzer.
- **Log-Pflicht:** Nach jedem Arbeitsauftrag automatisch und ohne Rückfrage ein
  Abschlusskommentar am Auftrags-Parent und am Standard-Log-Ziel aus
  `docs/projekt-kontext.md` (Skill `mcp-code-auftrag`, Schritt 5). Gilt auch für Arbeit
  ohne genannte PM-Referenz — der Stop-Hook des Plugins erinnert daran.
- **Spezifikation und Doku:** nur im Wiki unterhalb der Wurzelseite; Feature- und
  Use-Case-Objekte nicht mehr verwenden.
- **Format:** Textfelder des Projekt Managers sind HTML, nie Markdown.
