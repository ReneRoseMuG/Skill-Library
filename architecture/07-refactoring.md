# Refactoring und Vereinheitlichung

Beseitigt parallele Implementierungen, Altlasten und Architekturverstöße auf kontrollierte Weise.
Unterschied zu normaler Implementierung: das Verhalten bleibt gleich, die Struktur ändert sich.

---

## Trigger

- Mehrere lokale Implementierungen derselben fachlichen Aufgabe identifiziert
- Zentrale Komponente existiert, wird aber nicht überall genutzt (Komponentendrift)
- Veraltete Implementierung neben moderner Alternative
- Naming-Konventionen verletzt
- Schichtengrenze verletzt (Fachlogik in UI-Komponente, Datenzugriff im Service)

## Nicht-Trigger

- Feature-Änderung — dafür den normalen Implementierungsablauf nutzen
- Reine Code-Formatierung ohne strukturelle Wirkung
- Vorzeitige Optimierung ohne konkreten Drift-Nachweis

---

## Pflichtablauf

### Phase 1 — Bestandsaufnahme

1. Graphify-Protokoll anwenden:
   ```bash
   graphify query "<Bereich>"
   graphify explain "<verdächtige Komponente>"
   ```
2. Alle Implementierungen derselben fachlichen Aufgabe im Quellcode kartieren.
3. Aufrufer jeder Variante bestimmen.
4. Unterschiede zwischen den Varianten dokumentieren (fachlich relevante vs. zufällige Unterschiede).

### Phase 2 — Ziel bestimmen

1. Verbindliche Referenz oder Zielstruktur benennen.
2. Fachlich relevante Unterschiede identifizieren die erhalten bleiben müssen.
3. Umfang eingrenzen: welche Aufrufer werden migriert, welche nicht?
4. Reihenfolge festlegen: Referenz stabilisieren → Aufrufer migrieren → Altlast entfernen.

### Phase 3 — Schrittweise Umsetzung

Jeden Schritt einzeln und verifizierbar halten:
1. Referenz-Implementierung prüfen oder vervollständigen.
2. Einen Aufrufer auf die Referenz umstellen.
3. Tests ausführen — kein Verhalten darf sich ändern.
4. Nächsten Aufrufer migrieren.
5. Altlast erst entfernen wenn alle Aufrufer migriert sind.

### Phase 4 — Abschlussprüfung

- Konformitätsprüfung (`06-konformitaetspruefung.md`) durchführen.
- Graphify aktualisieren und Drift-Knoten prüfen:
  ```bash
  graphify update .
  ```
- Verbleibende Ausnahmen dokumentieren.

---

## Leitplanken

- Keine Verhaltensänderung unter dem Deckmantel Refactoring.
- Kein großflächiges Umbenennen ohne konkreten Drift-Nachweis.
- Keine Extraktion neuer Abstraktionen wenn nur ein Aufrufer existiert.
- Schritte klein genug halten dass Tests nach jedem Schritt grün sind.
- Altlasten erst entfernen wenn alle Aufrufer umgestellt sind.

---

## Ergebnisformat

| Feld | Inhalt |
|---|---|
| Auftrag | Welcher Drift wird behoben |
| Referenz | Verbindliche Zielimplementierung |
| Migrierte Aufrufer | Umgestellte Dateien |
| Entfernte Altlasten | Gelöschte Duplikate |
| Verbleibende Ausnahmen | Bewusst nicht migrierte Fälle mit Begründung |
| Tests | Ausgefühlte Testläufe und Ergebnis |
