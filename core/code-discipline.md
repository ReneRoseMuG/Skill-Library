# Code-Disziplin

Disziplin-Gate vor jeder Dateiänderung. Verhindert ungewolltes Entfernen von Verhalten, unterbrochene Verdrahtung und Seiteneffekte in benachbartem Code.

---

## Trigger

- Vor jeder Änderung an Quelldateien — besonders bei UI, Stilen, Event-Handlern, geteilter Logik und Code in der Nähe bestehenden Verhaltens.

## Nicht-Trigger

- Reines Lesen oder Analysieren ohne Änderungsabsicht.

---

## Prinzipien

1. **Zuerst lesen, dann ändern.** Bei Code-Bezug vorab `graphify-protocol.md`. Betroffene Komponente vollständig verstehen: alle interaktiven Elemente, Event-Handler und bedingten Darstellungen erfassen; bei geteilten Stilen die Mitnutzer, bei Logik die Aufrufer.
2. **Code ist die aktuelle Wahrheit.** Widerspricht eine Spezifikation dem laufenden Code, gilt der Code — die Diskrepanz wird gemeldet, nicht still „gefixt".
3. **Auswirkungen durchdenken.** Welche Dateien sind direkt oder indirekt betroffen? Trifft eine Stiländerung eine geteilte Klasse? Hängt anderer Code von der Struktur ab?
4. **Nur ändern, was der Auftrag verlangt.** Kein benachbartes Refactoring, kein Umbenennen von Funktionierendem, keine unbeauftragte Reorganisation. In einer Test- oder Fix-Sitzung keinen über den Auftrag hinausgehenden Produktivcode ändern.
5. **Preservation-Check vor Abschluss.** Alle interaktiven Elemente vorhanden und verdrahtet; alle Aufrufer der geänderten Funktion arbeiten weiter; alle bisher gültigen Zustände behandelt; nichts entfernt, das ein anderer Teil braucht.

---

## Leitplanken

- Nötige Nebenänderungen ausdrücklich benennen, nicht still mitnehmen.
- Bei Befund aus dem Preservation-Check sofort korrigieren, außer der Auftrag erlaubt das Offenlassen ausdrücklich.

---

## Ergebnisformat

| Feld | Inhalt |
|---|---|
| Gelesen | Verstandene Komponenten und Abhängigkeiten |
| Geändert | Was geändert wurde, im Auftragsscope |
| Erhalten | Bestätigte interaktive Elemente, Aufrufer, Zustände |
| Nebenänderungen | Bewusst nötige, benannte Zusatzänderungen |
