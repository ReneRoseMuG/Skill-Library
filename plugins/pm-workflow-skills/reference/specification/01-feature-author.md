# Feature Author

Erstellt und pflegt Feature-Dokumente aus Anwendersicht.
Verwendet das Projekt-Manager-MCP als Datenquelle und Speicherziel.

---

## Trigger

- Neues Feature soll angelegt werden
- Bestehendes Feature soll überarbeitet oder vervollständigt werden
- Feature-Beschreibung ist zu technisch oder schwer verständlich

---

## Grundprinzip bei Überarbeitung: verlustfrei

Eine Überarbeitung ist **keine Zusammenfassung und kein Neuschrieb**, sondern eine kontrollierte Überführung des vorhandenen fachlichen Bestands in eine bessere Form.

- Verändert werden dürfen: Satzbau, Wortwahl, Reihenfolge, Überschriften, Aufteilung in Fließtext/Listen.
- **Niemals** verändert wird der fachliche Bedeutungsumfang: Ziele, Regeln, Bedingungen, Ausnahmen, Rollenunterschiede, Zustände, Folgen.
- Eine Aussage gilt nur als erhalten, wenn sie im neuen Text **ausdrücklich** erkennbar ist — nicht nur indirekt ableitbar.
- Ähnlich klingende Regeln dürfen **nicht** zusammengeführt werden, wenn sie unterschiedliche Voraussetzungen, Rollen, Zeitpunkte, Zustände oder Folgen haben.
- Bei Zweifeln bleibt die genauere, ausführlichere Aussage erhalten.

---

## Pflichtabschnitte eines Feature-Dokuments

Nur tatsächlich relevante Abschnitte verwenden; reine Pro-forma-Abschnitte weglassen.

1. **Kurzbeschreibung** — Gegenstand, Nutzen und zentrale Aufgabe in wenigen Sätzen. Verschweigt keine wesentlichen Einschränkungen, ist kein Ersatz für das Dokument.
2. **Ziel und Zweck** — Warum existiert das Feature, welches fachliche Problem löst es, wer arbeitet damit. Fließtext.
3. **Fachliche Beschreibung** — Zentrale Objekte, Beziehungen, Zustände, grundlegende Abläufe. Erklärt Zusammenhänge, nicht nur Aufzählung.
4. **Typische Nutzung** — Wie das Feature im Arbeitsalltag verwendet wird (fachliche Abläufe, keine Klickanleitung).
5. **Benutzerführung und Entscheidungen** — Relevante Dialoge, Warnungen, Bestätigungen: Auslöser, angezeigte Information, Möglichkeiten, Folgen, Verhalten bei Abbruch.
6. **Fachliche Regeln und Randbedingungen** — Nach Themen gegliedert, je Thema kurze Einleitung + abgegrenzte Regeln. Jede Regel lässt Voraussetzung und Folge erkennen; Ausnahmen direkt bei der Regel.
7. **Sonderfälle** — Fälle, die vom üblichen Ablauf abweichen (Ausgangssituation, abweichendes Verhalten, Folgen). Entfällt, wenn keine bestehen.
8. **Abgrenzungen** — Was ähnlich erscheint, aber ausdrücklich nicht Teil des Features ist, mit Verweis auf das zuständige Feature/den Use Case.
9. **Verwandte Themen** — Steht immer am Ende (siehe unten).

---

## Ablauf

1. Bestehendes Feature-Dokument via MCP laden (`get_feature`).
2. Fachliche Quellen laden: Spezifikationen, Tickets, verwandte Features, Kommentare, Anhänge (`get_feature` für Verwandte).
3. **Aussageinventar** erstellen — jede eigenständige fachliche Aussage erfassen (Ziel, Rollen, Objekte/Beziehungen, Voraussetzungen, Abläufe, Regeln/Verbote, Ausnahmen, Sonderfälle, Folgen, Abgrenzungen, Verweise). Arbeitsmittel, kein Teil des Dokuments.
4. Fehlende oder veraltete Abschnitte identifizieren; Unklarheiten und Widersprüche notieren statt sie zu glätten.
5. Abschnitte schreiben oder überarbeiten und jede Inventar-Aussage einem Abschnitt zuordnen.
6. Auf Lesbarkeit prüfen: versteht ein fachkundiger Anwender ohne Entwicklerhintergrund?
7. Bereich „Verwandte Themen" recherchieren und ergänzen (nur fachlich belegbare Beziehungen).
8. Neue Fassung gegen das Aussageinventar prüfen: ist jede Aussage ausdrücklich erhalten?
9. Dokument via MCP speichern (`update_feature`).
10. Kurzen **Redaktionsnachweis** als Kommentar am Feature veröffentlichen (`add_comment_to_parent`).

---

## Verwandte Themen

Nur fachlich begründete Beziehungen — keine Sammlung ähnlich klingender Titel.
Jeder Eintrag enthält: **Referenz · Titel · Beziehungstyp · kurze fachliche Begründung** (bei Bedarf betroffene Regeln/Teilbereiche).

Zulässige Beziehungstypen für Features:
`setzt voraus` · `wird verwendet von` · `verwendet Daten aus` · `ergänzt` · `konkretisiert` · `grenzt sich ab von` · `teilt Regeln mit` · `löst Folgeänderungen aus in` · `beschreibt den Anwendungsfall zu` · `ist technische Umsetzung von`

Muster:

```
**FT (xx): Titel**
**Beziehung:** wird verwendet von
**Zusammenhang:** Das verknüpfte Feature verwendet die hier verwalteten Daten für …
```

---

## Schreibregeln

- Anwenderorientierte Sprache — kein Datenbankdesign, keine API-Details, keine Variablennamen
- Erst den fachlichen Zusammenhang erklären, dann die einzelnen Regeln
- Fließtext und Aufzählungen ausgewogen — keine reinen Listen-Dokumente; vor jeder längeren Liste ein Einleitungssatz
- Aufzählungspunkte parallel aufbauen; ein Punkt mischt nicht mehrere unabhängige Regeln
- Regeln konkret und testbar: „Ein Termin kann nicht in der Vergangenheit liegen" statt „Datum wird validiert"
- Eindeutig benennen, wer handelt (Anwender / Rolle / System) und was verändert, geprüft oder verhindert wird
- Ausnahmen explizit benennen — nicht im Fließtext verstecken
- Werbliche Wertungen vermeiden („komfortabel", „intelligent", „optimal")
- Technische Begriffe nur bei Notwendigkeit; dann zuerst die fachliche Aussage, danach die technische Ergänzung
- Für denselben Gegenstand durchgehend dieselbe Bezeichnung

---

## Redaktionsnachweis (Kommentar am Feature)

Kurz halten — kein Teil des Hauptinhalts. Mindestens:

- **Bearbeitungsumfang** — was sprachlich/strukturell/fachlich geprüft wurde
- **Zusammengeführte oder entfernte Aussagen** — vollständig mit Begründung; sonst ausdrücklich „Keine fachlichen Aussagen zusammengeführt/entfernt."
- **Erkannte Unklarheiten oder Widersprüche** — nicht eigenmächtig aufgelöst; sonst „Keine erkannt."
- **Geprüfte Verknüpfungen** — ergänzt / geändert / verworfen, offene noch zu prüfende Punkte
- **Abschluss** — „Die überarbeitete Fassung enthält alle zuvor vorhandenen fachlichen Aussagen." oder Benennung der dokumentierten Abweichungen

---

## Abnahmekriterien

- Alle relevanten Pflichtabschnitte vorhanden und inhaltlich gefüllt
- Bei Überarbeitung: jede Aussage des Aussageinventars ausdrücklich erhalten (verlustfrei)
- Für einen fachkundigen Anwender ohne Entwicklerhintergrund verständlich
- Regeln konkret und testbar; Ausnahmen explizit
- Fließtext und Aufzählungen ausgewogen
- „Verwandte Themen" fachlich recherchiert, jeder Eintrag mit Referenz, Titel, Beziehungstyp und Begründung
- Unklarheiten/Widersprüche gekennzeichnet statt geglättet
- Redaktionsnachweis als Kommentar veröffentlicht
- Kein technischer Jargon ohne Nutzenbezug
