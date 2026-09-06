---
name: feature-editorial
description: >
  Redaktionelle Aufbereitung eines Features aus Anwendersicht. IMMER verwenden wenn
  der Nutzer ein Feature "überarbeiten", "redaktionell aufbereiten", "aus Anwendersicht
  beschreiben" oder "dokumentieren" möchte — egal ob eine Feature-Nummer (z. B. FT(35)),
  eine Wiki-Seiten-ID oder ein Feature-Name genannt wird. Auch bei "schreib eine Beschreibung für...",
  "erstelle Use Cases für...", "bereite Feature X auf".
---

# Feature Editorial

Zielgruppe: Fachverantwortliche und Product Owner. Kein technischer Jargon, keine
Implementierungsdetails — was das Feature tut und warum es existiert.

## Schritt 1: Quelle klären

- **Feature benannt** (Nummer `FT(NN)`, Seiten-ID oder Titel) → Feature-Seite suchen (`list_wiki_pages`) und laden (`get_wiki_page`)
- **Name oder Beschreibung im Chat** → als Ausgangsmaterial verwenden
- **Unklar** → kurz nachfragen

Zusätzlich: relevante Teile der Codebase lesen um Fachregeln, betroffene Objekte
und Querverbindungen eigenständig zu ermitteln (im jeweiligen Repo ggf. zuerst
über den `exploration`-Skill, falls vorhanden).

## Schritt 2: Inhalt erarbeiten

1. **Zweck & Nutzen** — Was kann der Anwender tun? Welches Problem löst es?
2. **Fachregeln** — Pflichtfelder, Rollenbeschränkungen, Statusübergänge, Validierungen
3. **Betroffene Objekte** — Fachliche Namen, keine Tabellennamen
4. **Verwandte Features** — Abhängigkeiten und Querverbindungen

## Schritt 3: Dokument schreiben

Feste Gliederung — H2-Titel des ersten Abschnitts durch inhaltlich treffende Überschrift ersetzen:

```
## [Treffende Überschrift]

### Ziel / Zweck
1–3 Sätze: Mehrwert im Arbeitsalltag.

### Fachliche Beschreibung
Aus Anwendersicht: Was passiert bei typischen Aktionen? Welche Zustände gibt es?

### Regeln & Randbedingungen
Jede Regel als eigenständiger Punkt.


## Architektur & Kontext

### Betroffene Objekte
Fachliche Entitäten mit kurzer Rollenbeschreibung.
Mermaid-Diagramm optional bei mehr als 2 Objekten mit nicht-trivialen Beziehungen.

### Verwandte Features & Abhängigkeiten
Querverweise mit kurzer Erklärung.
```

## Schritt 4 (optional): Use Cases

```
### UC-[Nummer]: [Titel]
**Akteur:** ...  **Ziel:** ...
**Vorbedingungen:** ...
**Ablauf:** 1. ... 2. ...
**Alternativen / Sonderfälle:** ...
**Ergebnis:** ...
```

## Schritt 5: Ausgabe

Features und Use Cases werden als Wiki-Seiten im Projekt Manager gepflegt. Ablage, Nummerierung
und Werkzeuge: `${CLAUDE_PLUGIN_ROOT}/reference/wiki-ablage.md`.

Seiteninhalte sind HTML; Tabellen ausschließlich als `<table>`. `update_wiki_page` ersetzt den
Inhalt vollständig — vorher `get_wiki_page` lesen.

**Seite vorhanden:**
1. `update_wiki_page` mit dem vollständigen neuen Inhalt
2. Use Cases → `create_wiki_page` unter der Sammelseite `FT(NN) – Use Cases`, Titel `UC (NN/MM): Titel`
3. Kurze Rückmeldung was übertragen wurde, mit Seitentitel und Seiten-ID

**Seite noch nicht vorhanden:**
Fragen: neue Feature-Seite anlegen (`create_wiki_page` unter der Wurzelseite des Projekts) oder
zunächst nur Durchsicht im Chat?

## Stil
- Aktiv: „Der Anwender kann…", „Das System erlaubt…"
- Fachregeln als klare Einzelaussagen — keine Schachtelsätze
- Mermaid nur wenn es echten Mehrwert bringt

Quelle (Ebene 1): Skill Library, Plugin `pm-workflow-skills`, `reference/specification/01-feature-author.md`.
