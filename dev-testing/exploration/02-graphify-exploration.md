# Graphify-gestützte Strukturerkundung

Ermittelt was in einem Codebereich existiert: Komponenten, Schichten, Muster, Abhängigkeiten.
Graphify ist das primäre Werkzeug. Quellcodeprüfung verifiziert die Ergebnisse.

---

## Zweck

Beantwortet die Frage: **Was ist hier?**

- Welche Komponenten, Services, Repositories existieren in diesem Bereich?
- Wie sind sie verbunden?
- Welche Schichten sind beteiligt?
- Welche Konventionen und Muster dominieren?

---

## Pflichtablauf

### Phase 1 — Graphify-Erkundung

```bash
# Einstieg über Fachbegriff
graphify query "<Zielbereich>"

# Nachbarn erkunden
graphify explain "<gefundener Knoten>"

# Zentrale Knoten identifizieren
graphify query "<verwandter Begriff>"
```

Suche systematisch durch: Fachbegriffe, Komponentennamen, Servicenamen, API-Endpunkte.

### Phase 2 — Klassifikation der Graphfunde

Jeden gefundenen Knoten vorläufig klassifizieren (siehe `core/graphify-protocol.md`):
- Verbindliche Referenz, zulässige Variante, Driftverdacht, Altlast?
- Stark vernetzt vs. isoliert?
- Zentral exportiert vs. lokal verwendet?

### Phase 3 — Quellcodeprüfung

Für jeden relevanten Knoten:
1. Datei öffnen und vollständige Verantwortung verstehen
2. Exporte und öffentliche Schnittstellen prüfen
3. Imports und Aufrufer prüfen
4. Ähnliche Dateien im selben Verzeichnis prüfen

### Phase 4 — Konsolidierung

- Verbindliche Referenzen identifizieren
- Varianten und ihre Unterschiede dokumentieren
- Driftverdächtige Implementierungen benennen
- Schichtengrenzen kartieren

---

## Suchmuster

### Fachliche Suche
- Sichtbare Bezeichnungen und Labels
- Domänenobjekte und Feldnamen
- Use-Case-Begriffe und Fachterminologie
- API-Endpunkte und Operationsnamen

### Technische Suche
- Komponentennamen und Dateinamen
- Import- und Exportpfade
- Props, Events, Hooks, Stores
- CSS-Klassen und Design-Token-Namen

---

## Leitplanken

- Häufigkeit im Graph beweist keine Korrektheit — Code entscheidet.
- Isolierte Knoten sind Driftverdächtige, keine automatischen Altlasten.
- Nicht in Implementierungsdetails abtauchen — Verantwortung und Schnittstelle reichen für Exploration.
- Umfang klein halten und nur bei echtem Bedarf ausweiten.

---

## Ergebnisformat

```
Bereich: <Name>

Zentrale Komponenten:
- <Name> (<Datei>) — <Verantwortung> [Klasse: Referenz|Variante|Drift|Altlast]

Schichten:
- <Schicht>: <beteiligte Dateien>

Muster:
- <Muster>: <Beschreibung>

Driftverdächtige:
- <Komponente>: <Begründung>

Offenes:
- <Unklare Zuständigkeit oder fehlende Quelle>
```
