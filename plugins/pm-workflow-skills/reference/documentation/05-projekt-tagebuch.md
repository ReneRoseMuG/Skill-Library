# Projekt-Tagebuch

Pflegt pro Projekt genau einen fortlaufenden, lesbaren Tagebuchtext aus der jüngsten Aktivität.
Das Tagebuch ist eine absteigende Zeitleiste: aktuelle Ereignisse stehen oben, danach folgen ältere Abschnitte absteigend sortiert.

---

## Trigger

- "Aktualisiere das Tagebuch"
- "Schreibe das Projekt-Tagebuch fort"
- "Tagebuch für PROJ-x"
- "Tagebuch aktualisieren"
- Ein Projekt-Tagebuch soll aus Aktivität, Kommentaren, Aufgaben, Tickets, Meilensteinen oder Notizen fortgeschrieben werden

## Nicht-Trigger

- Fachliche Projektdaten sollen geändert werden
- Ein Wiki-Artikel oder eine Anwenderdokumentation soll geschrieben werden
- Es gibt keinen auflösbaren Projektbezug

---

## Quellen

1. Bestehender Tagebuch-Eintrag des Projekts
2. Aktivitäts-Delta seit dem letzten `coveredUntil`
3. Referenz- und Kontextauflösung für Aufgaben, Tickets, Meilensteine und andere indirekte Projektbezüge

Wenn die Aktivitäts- oder Tagebuch-API nicht erreichbar ist, kontrolliert abbrechen und den Blocker melden.
Keine Ereignisse erfinden.

---

## Pflichtablauf

### 1. Delta lesen

1. Für betroffene Projekte den bestehenden Tagebuch-Eintrag laden.
2. Als Startzeitpunkt das höchste `coveredUntil` verwenden.
3. Wenn noch kein Tagebuch existiert, ein bewusst begrenztes Anfangsfenster wählen.
4. Aktivität paginiert lesen, bis keine neuen Ereignisse mehr vorhanden sind.
5. Nur Ereignisse mit ID, Typ, Zusammenfassung, Akteur und Zeitstempel weiterverarbeiten.

### 2. Projektbezug bestimmen

1. Direkte Projekt-Kontexte unmittelbar dem Projekt zuordnen.
2. Indirekte Kontexte wie Aufgabe, Ticket, Feature, Use Case oder Meilenstein über Referenzkontext auf ihr Projekt zurückführen.
3. Auflösungen cachen, damit dieselbe Referenz nicht mehrfach abgefragt wird.
4. Ereignisse ohne auflösbares Projekt überspringen.
5. Projekte strikt getrennt halten.

### 3. Ereignisse sortieren

Je Projekt alle neuen Ereignisse nach `createdAt` ordnen:

| Sortierung | Regel |
|---|---|
| Primär | absteigend nach Zeitstempel |
| Darstellung | neueste Ereignisse oben |
| Chronologie | umgekehrt chronologisch |

Diese Sortierung ist verbindlich. Kein älterer Abschnitt darf vor einem neueren Abschnitt stehen.

### 4. Tagebuch erzählen

1. Bestehende Erzählung und neue Ereignisse dieses einen Projekts zusammenführen.
2. Für neue Vorgänge datierte Abschnitte bilden.
3. Jeden Abschnitt mit einer kurzen Datumsüberschrift im Format `dd.MM.yy` beginnen.
4. Unter der Überschrift zusammenhängenden Fließtext schreiben, keine lose Stichpunktliste.
5. Neue Abschnitte oben voranstellen, jüngstes Datum zuoberst.
6. Wenn ein neues Ereignis eine bereits beschriebene ältere Stelle korrigiert oder ergänzt, die bestehende Stelle anpassen statt widersprüchlich zu wiederholen.
7. Alte nach unten gewachsene Texte nicht zwangsweise umbauen; sie werden nur dort in datierte Abschnitte überführt, wo ohnehin eine Anpassung nötig ist.

### 5. Versioniert zurückschreiben

1. Wenn kein Tagebuch existiert, einen neuen Eintrag erstellen.
2. Wenn ein Tagebuch existiert, den bestehenden Eintrag versioniert aktualisieren.
3. `coveredUntil` auf den jüngsten verarbeiteten Ereigniszeitpunkt setzen.
4. `sourceCount` um die Zahl der neu eingearbeiteten Ereignisse erhöhen.
5. Bei Versionskonflikt den Eintrag neu laden und Zusammenführung wiederholen.

---

## Schreibregeln

- Neutral, sachlich und knapp erzählen.
- Inhalte als HTML zurückschreiben, wenn das Zielsystem HTML erwartet.
- Menschenlesbare Daten im Format `dd.MM.yy`, maschinenlesbare Zeitpunkte als ISO 8601 führen.
- Keine hartcodierten Projektnamen, IDs oder Pfade verwenden.
- Nur erzählend verdichten, keine fachlichen Daten ändern.
- Tagebuch-Schreibvorgänge dürfen nicht wieder als neue Quelle in dasselbe Tagebuch zurücklaufen.
- Pro Projekt genau ein lebender Tagebuch-Eintrag.
- Absteigende Zeitleiste beibehalten: neueste Abschnitte oben, ältere darunter.

---

## Ergebnis

| Feld | Inhalt |
|---|---|
| Aktualisierte Projekte | Projekt-IDs oder Projektnamen der fortgeschriebenen Tagebücher |
| Ereignisse | Anzahl der neu eingearbeiteten Ereignisse pro Projekt |
| Stand | Neuer `coveredUntil`-Zeitpunkt pro Projekt |
| Einschränkungen | Nicht auflösbare Referenzen, API-Probleme oder Versionskonflikte |

Kein ausführliches Schrittprotokoll ausgeben; der Abschluss nennt nur Ergebnis und Blocker.
