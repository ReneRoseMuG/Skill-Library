---
name: documentation
description: >
  Anwenderdokumentation und Wiki-Artikel im Projekt-Manager-Wiki.
  Verwenden wenn Wiki-Artikel geschrieben, aktualisiert oder veröffentlicht werden sollen,
  oder wenn Anwenderdoku zu einem Feature oder Use Case erstellt wird.
  Auslöser: "schreibe Wiki", "Wiki-Artikel", "dokumentiere für Anwender",
  "Anwenderdokumentation", "Wiki aktualisieren", "Doku für Feature X",
  "veröffentliche im Wiki", Artikel zu einer Feature- oder Use-Case-Seite.
---

# Anwenderdokumentation — Projekt Manager

Quelle und Ziel ist das Wiki des Projekt Managers. Keine Doku ohne Quellen-Verifikation
veröffentlichen. Ablage, Nummerierung und Werkzeuge: `${CLAUDE_PLUGIN_ROOT}/reference/wiki-ablage.md`.

## Quellenpriorität

1. Freigegebene Spezifikationen und Akzeptanzkriterien
2. Feature-Seiten im Wiki (`get_wiki_page`)
3. Use-Case-Seiten im Wiki (`get_wiki_page`)
4. Quellcode als letzte verfügbare Quelle

## Schritt 1 — Quellen laden

```
list_wiki_pages(<parentId>)
get_wiki_page(<Seiten-ID>)
```

Verwandte Seiten identifizieren und bei Bedarf nachladen.

## Schritt 2 — Code-Verifikation (wenn nötig)

Prüfen ob Doku durch Code gestützt wird:
- UI-Pfade: existieren die beschriebenen Menüpunkte und Dialoge?
- Rollen: stimmen beschriebene Berechtigungen mit der Implementierung überein?
- Regeln: werden alle beschriebenen Regeln tatsächlich durchgesetzt?

Widersprüche zwischen Doku und Code immer explizit benennen — nie stillschweigend auflösen.

## Schritt 3 — Inhalt schreiben

**Schreibregeln:**
- Direkte Anrede: "Klicken Sie auf..." oder "Sie klicken auf..."
- Aktive Formulierungen: "Das System speichert..." nicht "Die Daten werden gespeichert"
- Konkrete Labels aus der echten UI — nicht abstrakte Beschreibungen
- Fehlermeldungen im Wortlaut zitieren wenn bekannt
- Keine technischen Interna ohne direkten Nutzerbezug

**Feature-Artikel enthält:**
- Einstieg: was kann der Anwender damit tun? (1-2 Sätze)
- Schritt-für-Schritt-Anleitung für Hauptablauf
- Wichtige Regeln und Einschränkungen
- Häufige Fehlersituationen mit Lösung
- Verwandte Themen

## Schritt 4 — Prüfen vor Veröffentlichung

- Alle Pflichtabschnitte vorhanden?
- Einheitliche Anrede im gesamten Artikel?
- Widersprüche zwischen Doku und Code benannt (nicht verschwiegen)?
- Verlinkungen zu verwandten Artikeln vorhanden — und bidirektional (verweist B zurück auf A)?
- Kein Platzhalter, kein offenes TODO, kein inhaltlich leerer Abschnitt?
- Für fachkundige Anwender ohne Entwicklerhintergrund verständlich?

Vollständige Prüfliste (Stil, Konsistenz, Verlinkung, Vollständigkeit) und Ergebnisstufen:
`${CLAUDE_PLUGIN_ROOT}/reference/documentation/03-style-check.md` lesen.

## Schritt 5 — Veröffentlichen

Artikel anlegen (`create_wiki_page`) oder aktualisieren (`update_wiki_page`). Inhalt vollständig übergeben — `update_wiki_page` ersetzt, es ergänzt nicht. Format HTML; Tabellen ausschließlich als `<table>`.

Verlinkungen in den verwandten Artikeln nachziehen, damit keine einseitigen Querverweise entstehen.

**Nicht veröffentlichen wenn:** inhaltliche Widersprüche ungeklärt sind, Quellen unklar sind oder offene TODOs im Artikel stehen.

Quelle (Ebene 1): Skill Library, Plugin `pm-workflow-skills`, `reference/documentation/` — dort zuerst ändern, dann hier nachziehen.
