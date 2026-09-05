# Browser- und E2E-Tests

Sichert kritische Nutzerabläufe über reale Oberfläche, Routen, API und Persistenz ab.
Nur einsetzen wenn das Risiko erst im Gesamtsystem sichtbar wird.

---

## Geeignete Fälle

- Kritische End-to-End-Abläufe
- Formulare und mehrstufige Dialoge
- Navigation und sichtbare Berechtigungswirkung
- Drag-and-drop und echte Browserinteraktionen
- Abläufe deren Risiko erst im Zusammenspiel von UI, API und Persistenz entsteht

## Nicht geeignet

- Wiederholung was bereits Integration vollständig absichert
- Reine Unit-Logik oder isolierte Komponentendarstellung
- Jede UI-Variante als vollständigen E2E-Test

---

## Pflichtablauf

1. Kritischen Nutzerablauf und beteiligte Rollen bestimmen.
2. Kontrollierte Testdaten über vorgesehene Schnittstellen vorbereiten.
3. Reale Anwendung gegen isolierte Testinstanz starten.
4. Aktionen über echte Browserinteraktion ausführen.
5. Mit robusten Selektoren auf beobachtbare Zustandsänderungen warten.
6. UI-Wirkung und relevanten Backend-Folgezustand prüfen.
7. Browserzustand, Daten und Artefakte zwischen Tests isolieren.
8. Bei Fehlern Screenshots, Traces oder Videos sichern.

---

## Selektoren und Wartestrategien

**Stabile Selektoren:**
- Semantische Rollen (button, heading, listitem)
- Aria-Labels und sichtbare Beschriftungen
- Test-IDs als letzter Ausweg — nur wenn keine semantische Alternative

**Warten:**
- Auf Zustandsänderungen warten — keine pauschalen Zeitverzögerungen
- Sichtbarkeit eines Elements ist oft nicht ausreichend — Zustand prüfen

---

## Mock-Regeln

- Keine API-Stubs wenn das Zusammenspiel Teil des Risikos ist
- Keine gestubbten UI-Hooks oder Berechtigungen
- Authentifizierung nicht stubben wenn Berechtigungen geprüft werden
- Echte Testdaten über reale Schnittstellen anlegen

---

## Verbotene Abkürzungen

- Direktes Setzen interner Frontend-Zustände
- Ausschließlich Textsichtbarkeit ohne fachliche Zustandsprüfung
- Abhängigkeit von vorhandenen oder vorher erzeugten Testdaten
- Tests die nur in bestimmter Reihenfolge funktionieren
- Pauschale `sleep`/`wait`-Aufrufe

---

## Ergebnis

- Neue oder angepasste Browser-Tests
- Abgesicherte Nutzerabläufe und Rollen
- Datenaufbau und Cleanup
- Verwendete Selektoren und Wartebedingungen
- Diagnoseartefakte bei Fehlern (Screenshots, Traces)
- Zuordnung zu Regeln und Szenarien
