# Architektur- und UI-Implementierung

Setzt eine freigegebene Umsetzungsentscheidung im Repository um.
Bewahrt die festgelegten Verantwortungsgrenzen und verhindert parallele Lösungen.

---

## Eingaben

- Ergebnis der Bestands- und Regelanalyse
- Freigegebene Umsetzungsentscheidung
- Abnahmekriterien
- Repository-Konventionen und vorhandene Tests

---

## Pflichtablauf

1. Entscheidung, Referenzkomponente und Abnahmekriterien vor der Änderung prüfen.
2. Vorhandene öffentliche Schnittstellen und Erweiterungspunkte bevorzugen.
3. Änderungen auf den geplanten Verantwortungsbereich begrenzen.
4. Bei gemeinsamer Komponente: bestehende Varianten gegen Regressionen schützen.
5. Design-Token, zentrale Icons, etablierte Interaktionsmuster und Barrierefreiheitsregeln verwenden.
6. Fachlogik in den zuständigen Service, Hook oder Domänenbereich einordnen.
7. Keine lokale Kopie oder verdeckte Alternativimplementierung erzeugen.
8. Notwendige Unit-, Integrations-, Komponenten- oder Browser-Tests ergänzen.
9. Bei UI-Änderungen relevante Zustände und Varianten sichtbar prüfen.
10. Abweichungen von der Entscheidung sofort dokumentieren und neu bewerten.
11. Geänderte Regeln, Referenzbeispiele oder Stories nachziehen wenn die Änderung einen dauerhaften Standard verändert.

---

## UI-spezifische Leitplanken

- Buttons nach bestehender Hierarchie und Reihenfolge verwenden
- Nur die vorgesehene Icon-Bibliothek und etablierte Bedeutungen nutzen
- Collapse und Expand nicht mit abweichender Symbolik neu erfinden
- Drag-and-drop nur über vorgesehene Handles, Cursor und Drop-Zustände realisieren
- Leere, Lade-, Fehler- und deaktivierte Zustände vollständig berücksichtigen
- Keine eigenen Card-, Modal- oder Layout-Strukturen wenn zentrale Komponenten existieren
- Responsive Verhalten und Tastaturnavigation nicht als Nachgedanken behandeln

---

## Verbotene Abkürzungen

- Entscheidung während der Implementierung still ändern
- Neue Komponente erstellen weil die Anpassung der bestehenden aufwändiger erscheint
- Fachlogik in die Komponente verlegen statt in den zuständigen Service
- Tests weglassen oder abschwächen um schneller fertig zu werden
- UI-Zustände ignorieren die seltener auftreten

---

## Ergebnisformat

| Feld | Inhalt |
|---|---|
| Umsetzung | Geänderte Dateien und eingesetzte Komponenten |
| Abweichungen | Änderungen gegenüber der Entscheidung mit Begründung |
| Tests | Hinzugefügte oder geänderte Tests |
| Visuelle Prüfung | Geprüfte Zustände und Varianten |
| Offenes | Nachzuführende Regeln, Stories oder Dokumentation |
