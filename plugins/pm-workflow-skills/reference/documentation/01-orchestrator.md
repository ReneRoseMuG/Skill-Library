# Anwenderdoku-Orchestrator

Einstiegspunkt für alle Dokumentationsaufträge.
Primäre Datenquelle und Veröffentlichungsziel ist das Wiki des Projekt Managers — Ablage und
Werkzeuge: `../wiki-ablage.md`.

---

## Trigger

- Neues Feature oder Use Case soll dokumentiert werden
- Bestehende Wiki-Artikel sollen aktualisiert werden
- Doku ist veraltet nach Code- oder Spec-Änderungen
- Vollständiger Dokumentationslauf für einen Bereich

## Nicht-Trigger

- Änderung an der Spezifikation selbst (Feature- oder Use-Case-Seiten) → `specification/
- Reine Codeanalyse ohne Dokumentationsauftrag

---

## Quellenpriorität

1. Freigegebene Spezifikation und Akzeptanzkriterien
2. Feature-Seiten im Wiki (`get_wiki_page`)
3. Use-Case-Seiten im Wiki (`get_wiki_page`)
4. Tickets und Nutzerauftrag
5. Quellcode als letzte verfügbare Quelle

---

## Pflichtablauf

1. Auftragsart bestimmen: Neuanlage, Aktualisierung, Audit oder vollständiger Lauf.
2. Betroffene Feature- und Use-Case-Seiten laden (`list_wiki_pages`, `get_wiki_page`).
3. Verwandte Seiten und bestehende Anwenderdoku-Artikel identifizieren.
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
