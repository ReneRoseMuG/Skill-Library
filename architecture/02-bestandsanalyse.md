# Änderungs-, Pfad- und Bestandsanalyse

Bestimmt was geändert werden soll, welche Anwendungspfade und Schichten betroffen sind
und welche bestehenden Komponenten, Muster und technischen Anknüpfungspunkte bereits vorhanden sind.

---

## Eingaben

- Ticket, Bugbeschreibung, Featurebeschreibung oder Nutzerauftrag
- Git-Diff, geänderte Dateien oder geplanter Zielbereich
- Architektur- und Designleitplanken
- Repository-Struktur und vorhandene Suchwerkzeuge

---

## Pflichtablauf

1. Beabsichtigte Änderung und erwartetes Nutzerverhalten bestimmen.
2. Graphify-Protokoll anwenden (`core/graphify-protocol.md`):
   ```bash
   graphify query "<Fachbegriff der Änderung>"
   graphify path "<UI-Einstieg>" "<Service oder Persistenz>"
   ```
3. Einstiegspunkte, Seiten, Dialoge, Komponenten, Services, APIs und Persistenzbereiche ermitteln.
4. Direkte Aufrufer, Abhängigkeiten und alternative Wege zur gleichen Funktion untersuchen.
5. Vorhandene Komponenten mit gleicher fachlicher Aufgabe suchen.
6. Ähnliche Interaktionen, Darstellungen, Props, Hooks, Services und Hilfsfunktionen suchen.
7. Relevante Kandidaten im Quellcode lesen; bei UI-Themen tatsächliche Darstellung prüfen.
8. Gefundene Varianten vorläufig klassifizieren und Unterschiede dokumentieren.
9. Seiteneffekte, unklare Verantwortlichkeiten und offene Fragen benennen.

---

## Suchstrategie

### Fachliche Suche
- Fachbegriff und sichtbare Bezeichnungen
- Datenfelder, IDs und Domänenobjekte
- Use Cases und Spezifikationsbegriffe
- API-Endpunkte und Serviceoperationen

### Technische Suche
- Komponenten- und Dateinamen
- Imports, Exporte und Aufrufer
- Props, Events, Hooks und Stores
- CSS-Klassen, Design-Token und Icon-Imports
- Tests, Stories und Fixtures

### Graphgestützte Suche
- Nachbarschaft eines bekannten Einstiegsknotens
- Pfad zwischen UI-Einstieg und Service oder Persistenz
- Alternative Knoten mit gleichem fachlichem Begriff
- Stark vernetzte gemeinsame Komponenten
- Isolierte lokale Komponenten als mögliche Driftkandidaten

---

## Klassifikation gefundener Varianten

| Klasse | Merkmal |
|---|---|
| Verbindliche Referenz | Explizit als Standard definiert |
| Zulässige dokumentierte Variante | Bewusste, begründete Abweichung |
| Aktuelle zentrale Implementierung | Verbreitet, nicht explizit benannt |
| Historische Lösung oder Altlast | Veraltet, nicht gepflegt |
| Begründeter Sonderfall | Technisch abweichend mit gültigem Grund |
| Nicht klassifizierbarer Drift | Parallel entstanden ohne erkennbaren Grund |

---

## Leitplanken

- Nicht allein aus Dateinamen oder Grep-Ergebnissen auf Verantwortung schließen.
- Häufigkeit beweist keine Korrektheit.
- Driftverdächtige benennen, nicht stillschweigend ignorieren.
- Analyseumfang eng halten — nur bei echtem Bedarf ausweiten.

---

## Ergebnisformat

| Feld | Inhalt |
|---|---|
| Änderung | Beabsichtigte Änderung und erwartetes Verhalten |
| Anwendungspfad | Einstieg, betroffene Ansichten, Dialoge, Services, Folgewirkungen |
| Bestandskandidaten | Gefundene Komponenten, Dateien, Muster und Varianten mit Klassifikation |
| Abhängigkeiten | Direkte Aufrufer, alternative Pfade, Seiteneffekte |
| Offenes | Unklare Verantwortlichkeiten, Widersprüche, fehlende Quellen |
