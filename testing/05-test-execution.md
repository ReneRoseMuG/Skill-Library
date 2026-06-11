# Testausführung und Abschlussbewertung

Führt die vorgesehenen Tests kontrolliert aus, klassifiziert Fehlschläge
und bewertet ob die beabsichtigte fachliche Absicherung erreicht wurde.

---

## Pflichtablauf

1. Testumgebung und Voraussetzungen prüfen.
2. Testbefehle aus Repository-Konfiguration und Dokumentation ermitteln.
3. Zunächst direkt betroffene Tests ausführen.
4. Größere oder vollständige Suiten nur auf ausdrückliche Beauftragung ausführen — sonst bei den direkt betroffenen Tests bleiben.
5. Ergebnisse, Laufzeiten, übersprungene Tests und Diagnoseartefakte erfassen.
6. Fehler nach Ursache klassifizieren.
7. Bei jedem Fehlschlag prüfen: Regression, veraltete Erwartung, Testfehler oder Infrastrukturproblem?
8. Regeln und Szenarien den bestandenen Tests zuordnen.
9. Verbleibende Lücken, nicht ausgeführte Bereiche und Annahmen benennen.
10. Abnahmefähigkeit aus Testsicht bewerten.

---

## Fehlerklassen

| Klasse | Merkmal |
|---|---|
| Echte Regression | Produktivcode-Änderung hat Verhalten gebrochen |
| Veraltete Testerwartung | Test bildet altes Verhalten ab, neue Spezifikation gilt |
| Fehlerhafte Testimplementierung | Testcode selbst ist fehlerhaft |
| Instabiler Test | Flackert abhängig von Reihenfolge, Timing oder Umgebung |
| Fehlende Testdaten | Fixtures oder Datenbankzustand fehlt |
| Infrastrukturproblem | DB-Verbindung, Port, Schema-Mismatch |
| Fachlicher Widerspruch | Test und Spec widersprechen sich — Klärung nötig |

---

## Leitplanken

- Während eines reinen Testlaufs weder Test- noch Produktivcode ändern.
- Vollständige oder breite Testläufe nur auf ausdrückliche Beauftragung.
- Keine fehlgeschlagene Erwartung automatisch anpassen.
- Nicht ausgeführte oder blockierte Tests ausdrücklich nennen.
- Grüne Tests nicht automatisch als ausreichenden Beweis behandeln.
- Aussagekraft, Isolation und realitätsnahe Testdaten in die Bewertung einbeziehen.

---

## Abschlussfragen

- Welche Regeln und Szenarien sind bewiesen?
- Welche Testebenen wurden verwendet und warum?
- Welche Tests wurden geändert oder ergänzt?
- Welche Gegenbeispiele und Fehlerfälle sind enthalten?
- Welche Tests konnten nicht ausgeführt werden?
- Welche Lücken, Annahmen oder Risiken bleiben?
- Sind die Tests realitätsnah, isoliert und hinreichend aussagekräftig?
- Ist die Änderung aus Testsicht abnahmefähig?

---

## Ergebnisformat

| Feld | Inhalt |
|---|---|
| Ausgeführte Befehle | Testkommandos und Umfang |
| Ergebnis | Bestanden / Fehlgeschlagen / Übersprungen (Anzahl) |
| Klassifizierte Fehler | Fehlerklasse, Datei, Beschreibung |
| Bewiesene Regeln | Regeln die durch bestandene Tests abgesichert sind |
| Verbleibende Lücken | Nicht abgesicherte Szenarien |
| Abnahme | Ja / Nein / Bedingt + Begründung |
