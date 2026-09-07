# Projektanweisungen — Vorlage für ein Claude-Projekt (Cowork)

Platzhalter ersetzen und den Block unterhalb der Linie in die Projektanweisungen des
Claude-Projekts einfügen. Bestehende Anweisungen bleiben erhalten; dieser Block wird als
eigener Abschnitt ergänzt. Er ist das Gegenstück zum Abschnitt „Projekt-Manager-Anbindung"
in `agents.md`/`CLAUDE.md` eines Repos.

---

## Projekt-Manager-Anbindung

Dieses Projekt ist an das Projekt-Manager-Projekt **PROJ-{{PROJEKT_ID}} „{{PROJEKT_NAME}}"**
gebunden. Wiki-Wurzel: Seite {{WIKI_ID}} „{{WIKI_TITEL}}". Standard-Log-Ziel: {{LOG_ZIEL}}.
Bindung und Konventionen stehen in der Projekt-Doc `claude/projekt-kontext.md` — zu Beginn
jeder Sitzung lesen. Arbeitsweise: Skill `pm-workflow`.

- Zu Sitzungsbeginn bei Arbeit mit Projektbezug `get_reference_context("PROJ-{{PROJEKT_ID}}")`
  laden. Der Projekt Manager ist die Quelle der Wahrheit, nicht das Chat-Gedächtnis.
- Arbeitspakete als Meilensteine und Aufgaben im Projekt Manager anlegen und pflegen;
  erledigte Objekte auf `pending` setzen.
- Arbeitsergebnisse, Entscheidungen und Probleme als Kommentar am bearbeiteten Objekt und
  am Standard-Log-Ziel loggen — automatisch, ohne Rückfrage, für den Nutzer lesbar, HTML.
- Spezifikation und Dokumentation nur in Wiki-Seiten unterhalb der Wurzelseite pflegen
  (`get_wiki_page` lesen, dann `update_wiki_page` mit vollständigem Inhalt).
- „Sitzung abschließen" bedeutet: offene Arbeit als Aufgabe erfassen, Status abschließen,
  Abschlusskommentar schreiben, kurz berichten.
- Ist der Projekt-Manager-MCP nicht erreichbar: nichts erfinden, Blocker nennen, den
  Log-Text im Chat ausgeben und als Projekt-Doc `claude/session-log-<JJJJ-MM-TT>.md`
  ablegen, damit er später nachgetragen werden kann.
