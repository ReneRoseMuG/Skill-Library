# Mustersuche

Findet ähnliche Implementierungen, etablierte Konventionen und wiederverwendbare Lösungen.
Verhindert Neuentwicklung wenn eine passende Lösung bereits existiert.

---

## Zweck

Beantwortet die Frage: **Gibt es das schon?**

- Ähnliche Komponenten mit gleicher fachlicher Aufgabe
- Etablierte Interaktionsmuster für die geplante UI
- Wiederverwendbare Services oder Hilfsfunktionen
- Vorhandene Konventionen für Datenstruktur oder Validierung

---

## Pflichtablauf

### Phase 1 — Fachliche Suche

```bash
graphify query "<fachlicher Begriff>"
graphify query "<alternative Bezeichnung>"
graphify query "<UI-Begriff oder Interaktionsname>"
```

Varianten des Suchbegriffs systematisch durchlaufen:
- Fachlicher Begriff (z.B. "Auswahl", "Selektion")
- Englische Entsprechung (z.B. "selection", "picker")
- UI-Begriff (z.B. "Dropdown", "Autocomplete")
- Domänenobjekt (z.B. "Mitarbeiter", "Termin")

### Phase 2 — Technische Suche

Ergänzend zur Graphsuche direkte Repository-Suche:
- Komponentennamen nach Konvention (z.B. `*Picker`, `*Select`, `*List`)
- Props und Event-Namen (z.B. `onSelect`, `selectedId`, `value`)
- Hook-Namen (z.B. `use*`, `with*`)
- Serviceoperationen (z.B. `find*`, `get*`, `create*`)

### Phase 3 — Kandidaten bewerten

Für jeden gefundenen Kandidaten:

```bash
graphify explain "<Kandidat>"
```

Dann im Quellcode prüfen:
- Fachliche Aufgabe — deckt sie das Ziel ab?
- Schnittstelle — ist sie erweiterbar oder konfigurierbar?
- Qualität — ist die Implementierung verlässlich?
- Wiederverwendung — wird sie bereits mehrfach genutzt?

### Phase 4 — Klassifikation

| Klasse | Bedeutung |
|---|---|
| Direkt verwendbar | Deckt Aufgabe vollständig, keine Anpassung nötig |
| Konfigurierbar | Props oder Varianten reichen für den Anwendungsfall |
| Erweiterbar | Eigene Verantwortung, kontrollierte Erweiterung möglich |
| Ähnlich, nicht passend | Andere Verantwortung — nicht erzwingen |
| Driftverdacht | Lokale Lösung mit gleicher Aufgabe wie eine zentrale |

---

## Suchmuster nach Kontext

### UI-Muster
- Vorhandene Picker, Selektoren, Listen, Formulare
- Dialog- und Modal-Implementierungen
- Navigation und Tab-Muster
- Drag-and-Drop-Implementierungen

### Service-Muster
- Vorhandene CRUD-Services für ähnliche Objekte
- Validierungslogik für ähnliche Regeln
- Authentifizierungs- und Berechtigungsmuster

### Daten-Muster
- Vorhandene Schemastrukturen für ähnliche Entitäten
- Filter-, Sortier- und Suchmuster
- Versionierungs- und Konfliktbehandlungsmuster

---

## Leitplanken

- Erst suchen, dann entscheiden — nicht sofort neu entwickeln.
- Ähnliche Aufgabe ≠ gleiche Verantwortung. Nicht erzwingen.
- Mehrfach vorhandene lokale Lösungen sind Hinweis auf fehlende Abstraktion — als Driftverdacht dokumentieren, nicht sofort bereinigen.
- Graphify zeigt Vernetzung, Quellcode zeigt Qualität — beides prüfen.

---

## Ergebnisformat

```
Suchziel: <Fachliche Aufgabe oder UI-Muster>

Gefundene Kandidaten:
- <Name> (<Datei>) — <Klasse> — <Begründung>

Empfehlung:
- Verwenden: <Name>, weil <Begründung>
- Alternativ: <Name>, wenn <Bedingung>
- Neu entwickeln: wenn <Begründung warum keine Kandidaten passen>

Driftverdächtige:
- <Name>: <hat gleiche Aufgabe wie Kandidat X, lokal implementiert>

Offenes: <Was unklar bleibt>
```
