# Architektur- und Designregeln

Ermittelt und bewertet die für eine Änderung geltenden Architektur-, Komponenten-,
UI- und Interaktionsregeln. Trennt verbindliche Vorgaben von verbreitetem Bestand.

---

## Regelbereiche

**Struktur und Daten**
- Schichtengrenzen und Abhängigkeitsrichtung
- Verantwortlichkeiten von Komponenten, Services, Hooks und Stores
- Datenzugriff, Validierung, Berechtigungen und Fehlerbehandlung
- State Management, Events und Seiteneffekte
- Wiederverwendung, Erweiterungspunkte und Dateistruktur

**UI und Interaktion**
- Design-Token, Abstände, Größen und responsive Regeln
- Buttons, Icons, Menüs und Aktionsreihenfolge
- Auswahl-, Eingabe- und Validierungskomponenten
- Collapse, Expand, Tabs, Panels und Navigation
- Drag-and-drop, Drag-Handles und Drop-Zustände
- Lade-, Leer-, Erfolgs-, Warn- und Fehlerzustände
- Barrierefreiheit, Fokus, Tastatur und sichtbare Beschriftungen

---

## Quellenpriorität

1. Aktuelle explizite Architekturentscheidungen und verbindliche Leitplanken
2. Aktuelle Designregeln und offiziell benannte Referenzkomponenten
3. Freigegebene Spezifikationen, Use Cases und Akzeptanzkriterien
4. Zentrale Komponentenbibliothek, Design-Token und dokumentierte Varianten
5. Aktuelle mehrfach verwendete Referenzimplementierungen
6. Tests, Stories und visuelle Regressionen
7. Aktueller Code als letzte verfügbare Informationsquelle
8. Lokale Einzelimplementierungen nur als Indiz oder Driftverdacht

---

## Pflichtablauf

1. Relevante Regelquellen aus dem Bestandsanalyseergebnis laden.
2. Für jede betroffene Verantwortung konkrete Regeln bestimmen.
3. Regeln mit Quelle, Gültigkeitsbereich, zulässigen Varianten und Ausnahmen erfassen.
4. Gefundene Implementierungen gegen die Regeln prüfen.
5. Widersprüche zwischen Dokumentation und Code identifizieren.
6. Unklare oder fehlende Regeln als offene Fragen kennzeichnen.

---

## Leitplanken

- Vorhandener Code ist keine verbindliche Regel — er kann Drift sein.
- Mehrfach genutzter Code ist kein Beweis für Korrektheit.
- Fehlende Dokumentation einer Regel bedeutet nicht, dass keine gilt.
- UI-Regeln immer im gerenderten Zustand prüfen — nicht nur im Code.

---

## Ergebnisformat

| Feld | Inhalt |
|---|---|
| Regelbereich | Struktur, UI, Interaktion |
| Regel | Konkrete Vorgabe |
| Quelle | Architekturentscheidung, Spezifikation, Referenzkomponente |
| Varianten | Zulässige dokumentierte Abweichungen |
| Ausnahmen | Begründete Sonderfälle |
| Widersprüche | Konflikte zwischen Regeln oder zwischen Regel und Code |
