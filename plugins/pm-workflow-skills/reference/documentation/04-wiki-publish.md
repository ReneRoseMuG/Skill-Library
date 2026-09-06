# Wiki-Publikation

Veröffentlicht fertige Doku-Artikel im Wiki und prüft die Abnahmekriterien.
Ablage und Werkzeuge: `../wiki-ablage.md`.

---

## Voraussetzungen

Vor der Veröffentlichung müssen erfüllt sein:
- Inhalt vollständig und durch Quellen gedeckt (`02-content-edit.md`)
- Stil und Konsistenz geprüft (`03-style-check.md`)
- Keine offenen Widersprüche zwischen Quellen

---

## Ablauf

1. Finalen Artikel-Inhalt vorbereiten.
2. Über `list_wiki_pages` prüfen, ob der Artikel an der vorgesehenen Stelle bereits existiert.
3. Artikel anlegen (`create_wiki_page`) oder aktualisieren (`update_wiki_page`) — Inhalt vollständig, Format HTML.
4. Verlinkungen in verwandten Artikeln aktualisieren.
5. Abschlussprüfung durchführen.

---

## Abschlussprüfung

**Vollständigkeit:**
- Alle geplanten Abschnitte vorhanden?
- Alle verwandten Themen verknüpft?

**Verständlichkeit:**
- Für Anwender ohne Entwicklerhintergrund verständlich?
- Fehlerfälle mit konkreter Handlungsempfehlung?

**Konsistenz:**
- Keine Widersprüche zu veröffentlichten verwandten Artikeln?
- Einheitliche Terminologie mit dem restlichen Wiki?

**Veröffentlichungsfähigkeit:**
- Keine Platzhalter oder unvollständigen Abschnitte?
- Keine offenen Fragen oder TODO-Markierungen?

---

## Leitplanken

- Kein Artikel veröffentlichen der inhaltliche Widersprüche enthält.
- Verwaiste Artikel (keine Verlinkung) nur wenn fachlich unvermeidbar.
- Nach Veröffentlichung: verwandte Artikel auf Aktualität prüfen.

---

## Ergebnis

- Veröffentlichter Wiki-Artikel (URL oder ID)
- Aktualisierte Verlinkungen in verwandten Artikeln
- Abnahme-Status mit Begründung bei Einschränkungen
