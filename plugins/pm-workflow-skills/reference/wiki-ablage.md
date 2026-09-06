# Wiki-Ablage

Verbindliche Ablage für Spezifikation und Anwenderdokumentation. Das Wiki des Projekt
Managers ist die **einzige** Quelle. Die früheren Domänenobjekte Feature und Use Case
werden nicht mehr verwendet.

---

## Warum

Feature- und Use-Case-Objekte und das Wiki wurden parallel gepflegt und liefen
auseinander. Die Objekte gelten als veraltet und werden entfernt. Jede
Spezifikations- und Dokumentationsarbeit läuft deshalb ausschließlich über Wiki-Seiten.

**Nicht mehr verwenden:** `get_feature`, `update_feature`, `create_feature`,
`get_use_case`, `create_use_case`, `update_use_case`, `delete_feature`,
`delete_use_case`, `link_feature_to_parent`, `add_task_to_use_case`,
`add_ticket_to_use_case`, `list_features`, `list_use_cases`.

Trifft ein Auftrag auf eine FEAT- oder UC-Referenz aus alten Dokumenten, Tickets oder
Kommentaren: als historischen Verweis behandeln, die zugehörige Wiki-Seite über den
Titel suchen und dort weiterarbeiten. Keine neuen Objekte anlegen.

---

## Werkzeuge

| Zweck | Operation |
|---|---|
| Seiten einer Ebene auflisten | `list_wiki_pages(parentId)` — ohne `parentId` die obersten Seiten |
| Seite mit Inhalt und Version lesen | `get_wiki_page(id)` |
| Neue Seite anlegen | `create_wiki_page(title, content, parentId, sortOrder)` |
| Seite ändern, verschieben, umsortieren | `update_wiki_page(id, …)` — nur übergebene Felder ändern sich |

Es gibt keine Operation zum Löschen von Wiki-Seiten. Überholte Seiten werden inhaltlich
als überholt gekennzeichnet, nicht entfernt — Löschung ist Sache des Nutzers.

---

## Seitenstruktur

Die Wurzelseite unterscheidet sich je Projekt und steht im Projektkontext (siehe unten).
Darunter gilt einheitlich:

```
<Wurzelseite des Projekts>
└── FT(NN): Titel                  ← Feature-Seite
    └── FT(NN) – Use Cases         ← Sammelseite
        └── UC (NN/MM): Titel      ← einzelne Use-Case-Seite
```

- `NN` ist die Feature-Nummer, `MM` die laufende Use-Case-Nummer innerhalb des Features.
- `sortOrder` hält die Reihenfolge stabil: Feature-Seiten in Tausenderschritten,
  Use-Case-Seiten nach dem Muster `NNMM` (z. B. `2901` für UC (29/01)).
- Vor dem Anlegen einer neuen Feature-Seite die vorhandenen Nummern über
  `list_wiki_pages` prüfen und die nächste freie Nummer verwenden — Nummern werden nie
  wiederverwendet, auch nicht nach dem Überholen einer Seite.
- In Altbeständen liegen Use-Case-Seiten vereinzelt direkt unter der Feature-Seite statt
  unter der Sammelseite. Bestehende Ablage nicht umbauen, aber neue Seiten immer unter
  die Sammelseite hängen.

---

## Projektkontext

Welche Seite die Wurzel des jeweiligen Projekts ist, steht in
`.claude/project-context/wiki.md` des Repos, in dem gearbeitet wird — mit Seiten-ID und
Titel. Fehlt die Datei, wird die Wurzel über `list_wiki_pages` gesucht und beim Nutzer
bestätigt, bevor geschrieben wird. Niemals raten: eine Seite im falschen Projektbaum ist
für den Nutzer schwer zu finden und schwer zu bereinigen.

---

## Inhaltsformat

Seiteninhalte sind HTML. Markdown wird beim Schreiben umgewandelt, Tabellen jedoch nur
als HTML — Tabellen deshalb direkt als `<table>` übergeben.

Beim Ändern einer Seite immer zuerst `get_wiki_page` lesen und den vollständigen neuen
Inhalt übergeben. `update_wiki_page` ersetzt den Inhalt, es fügt nichts an.

---

## Verweise zwischen Seiten

Verwandte Themen werden als Seitentitel mit Seiten-ID angegeben, nicht als FEAT-/UC-Referenz:

```
**FT(27): Produktverwaltung und Auftragspositionen** (Wiki-Seite 86)
**Beziehung:** wird verwendet von
**Zusammenhang:** Die dort verwalteten Positionen greifen auf …
```

Querverweise sind beidseitig zu pflegen: wird auf einer Seite ein Verweis ergänzt, wird
er auf der Gegenseite nachgezogen.

---

## Redaktionsnachweis

Der Redaktionsnachweis gehört an die Wiki-Seite selbst: `add_comment_to_parent` mit
`parentType: "wikiPage"` und der Seiten-ID. Damit steht er dort, wo die Änderung
stattgefunden hat, und muss nicht mehr über Seitentitel und Seiten-ID zugeordnet werden.
Notizen (`add_note_to_parent`) und Anhänge (`add_attachment_to_parent`) sind an Wiki-Seiten
ebenfalls möglich.

Soll der Nachweis zusätzlich am Projekt sichtbar sein, kann er dort ergänzt werden
(`parentType: "project"`, Seitentitel und Seiten-ID im ersten Satz). Ist die Seite nicht
erreichbar, wird der Nachweis im Chat ausgegeben und das im Abschlussbericht vermerkt.
