# Feature Author

Erstellt und pflegt Feature-Dokumente aus Anwendersicht.
Verwendet das Projekt-Manager-MCP als Datenquelle und Speicherziel.

---

## Trigger

- Neues Feature soll angelegt werden
- Bestehendes Feature soll überarbeitet oder vervollständigt werden
- Feature-Beschreibung ist zu technisch oder schwer verständlich

---

## Pflichtabschnitte eines Feature-Dokuments

1. **Ziel** — Was erreicht der Anwender mit diesem Feature? Ein Satz.
2. **Nutzen** — Warum ist das wertvoll? Konkreter Mehrwert, nicht technische Beschreibung.
3. **Beschreibung** — Wie funktioniert es aus Anwendersicht? Fließtext + Aufzählungen gemischt.
4. **Regeln** — Welche Bedingungen und Einschränkungen gelten? Nummeriert, testbar formuliert.
5. **Ausnahmen** — Welche Sonderfälle gibt es?
6. **Verwandte Features** — Welche anderen Features sind betroffen oder ergänzend?
7. **Use Cases** — Liste der zugehörigen Use Cases (via MCP-Referenz)

---

## Ablauf

1. Bestehendes Feature-Dokument via MCP laden (`get_feature`).
2. Fehlende oder veraltete Abschnitte identifizieren.
3. Fachliche Quellen laden: Spezifikationen, Tickets, verwandte Features (`get_feature` für Verwandte).
4. Abschnitte schreiben oder überarbeiten.
5. Auf Lesbarkeit prüfen: versteht ein fachkundiger Anwender ohne Entwicklerhintergrund?
6. Verwandte Features und Use Cases aktualisieren.
7. Dokument via MCP speichern (`update_feature`).

---

## Schreibregeln

- Anwenderorientierte Sprache — kein Datenbankdesign, keine API-Details, keine Variablennamen
- Fließtext und Aufzählungen ausgewogen gemischt — keine reinen Listen-Dokumente
- Regeln konkret und testbar formulieren: "Ein Termin kann nicht in der Vergangenheit liegen" statt "Datum wird validiert"
- Ausnahmen explizit benennen — nicht im Fließtext verstecken
- Verwandte Features nennen wenn sie dasselbe Domänenobjekt oder denselben Nutzerablauf betreffen

---

## Abnahmekriterien

- Alle Pflichtabschnitte vorhanden und inhaltlich gefüllt
- Für einen fachkundigen Anwender ohne Entwicklerhintergrund verständlich
- Regeln konkret und testbar
- Verwandte Features und Use Cases aktuell verknüpft
- Kein technischer Jargon ohne Nutzenbezug
