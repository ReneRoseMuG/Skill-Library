# Auftrags-Orchestrator

Einstiegspunkt für jeden Arbeitsauftrag, der über eine Projekt-Manager-Referenz
(`PROJ-<id>`, `MS-<id>`, `TASK-<id>`, `TKT-<id>`, `FEAT-<id>`, `UC-<id>`) hereinkommt.
Bestimmt, dass es sich um einen MCP-Arbeitsauftrag handelt, lädt den Kontext und
übergibt an `work-order.md` für den eigentlichen Ablauf.

Erkennungsmerkmal: Der Auftrag nennt eine solche Referenz als Auftragsquelle
("bearbeite TKT-90", "setze MS-12 um", "führe UC-5 aus") — unabhängig davon,
ob explizit "Ticket"/"Aufgabe"/"Feature" gesagt wird.

Reine Zahlen ohne Typ-Präfix: kurz nachfragen, welcher Typ gemeint ist, statt zu raten.

Siehe `work-order.md` für Kontextladen, Ausführung, Logpflicht und Statusabschluss.
Die fertige, direkt nutzbare Fassung dieses Musters liegt als Skill in diesem Plugin: `skills/mcp-code-auftrag/SKILL.md`.
