# Anwenderdoku-Orchestrator

Einstiegspunkt für alle Dokumentationsaufträge.
Verwendet das Projekt-Manager-MCP als primäre Datenquelle (Features, Use Cases, Wiki).

---

## Trigger

- Neues Feature oder Use Case soll dokumentiert werden
- Bestehende Wiki-Artikel sollen aktualisiert werden
- Doku ist veraltet nach Code- oder Spec-Änderungen
- Vollständiger Dokumentationslauf für einen Bereich

## Nicht-Trigger

- Änderung an Spezifikation (Features/Use Cases) → `specification/`
- Reine Codeanalyse ohne Dokumentationsauftrag

---

## Quellenpriorität

1. Freigegebene Spezifikation und Akzeptanzkriterien
2. Features via MCP (`get_feature`)
3. Use Cases via MCP (`get_use_case`)
4. Tickets und Nutzerauftrag
5. Quellcode als letzte verfügbare Quelle

---

## Pflichtablauf

1. Auftragsart bestimmen: Neuanlage, Aktualisierung, Audit oder vollständiger Lauf.
2. Betroffene Features und Use Cases via MCP laden.
3. Verwandte Features und bestehende Wiki-Artikel identifizieren.
4. Passende Spezialisierungsskills aktivieren:
   - Inhalt schreiben/überarbeiten → `02-content-edit.md`
   - Stil und Konsistenz prüfen → `03-style-check.md`
   - Im Wiki veröffentlichen → `04-wiki-publish.md`
5. Ergebnisse konsolidieren und Vollständigkeit prüfen.

---

## Leitplanken

- Keine Fachregeln erfinden — nur aus Quellen ableiten.
- Widersprüche zwischen Quellen immer dokumentieren, nie stillschweigend auflösen.
- Kein Wiki-Artikel ohne Quellen-Verifikation veröffentlichen.
- Kleine Änderungen dürfen direkt ohne vollständigen Lauf umgesetzt werden.
