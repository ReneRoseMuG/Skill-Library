# Code-Disziplin

Gemeinsames Disziplin-Gate vor jedem Implementierungsauftrag. Plattformneutral —
kein Technologiestack, keine konkreten Dateipfade. Jedes Repo instantiiert daraus
einen eigenen `code-discipline`-Skill und ergänzt einen projektspezifischen
Abschnitt (siehe „Projektspezifisch" unten).

## Prinzip 1: Zuerst lesen, dann ändern

Vor jeder Dateiänderung:
- Bei Code-Bezug zuerst den vorhandenen Wissensgraphen/Suchwerkzeug nutzen (z. B. Graphify, falls im Repo vorhanden), dann gezielt lesen
- Ganze Komponente oder Modul verstehen wie es heute funktioniert
- Alle UI-Elemente identifizieren: Buttons, Inputs, Icons, Event-Handler, conditional Renders
- Bei CSS: welche anderen Komponenten teilen dieselben Klassen oder Parent-Selektoren
- Bei Service-/Logik-Änderungen: welche Aufrufer hängen von der geänderten Funktion ab

## Prinzip 2: Code ist die Wahrheit

Wenn Spezifikation und bestehender Code sich widersprechen → Code gilt als aktuelle Wahrheit, außer der Auftrag sagt ausdrücklich etwas anderes.
- Funktionierenden Code nicht zurücksetzen weil ein Spec-Dokument etwas anderes beschreibt
- Diskrepanz als Beobachtung melden — nicht still „fixen"

## Prinzip 3: Auswirkungen durchdenken

Vor der ersten Änderung:
- Welche anderen Dateien werden direkt oder indirekt betroffen?
- Trifft die CSS-Änderung eine geteilte Klasse?
- Betrifft die Funktionsänderung andere Aufrufer?
- Ist die Komponente in andere eingebettet die von ihrer Struktur abhängen?

## Prinzip 4: Nur ändern was der Auftrag verlangt

- Keinen benachbarten Code refactorn der nur anders sauberer wäre
- Nichts umbenennen das nicht kaputt ist
- Keine Dateien außerhalb des Auftrags reorganisieren
- Nötige Nebenänderungen explizit benennen
- In einer Test- oder Fix-Session keinen über den Auftrag hinausgehenden Produktivcode ändern
- Bestehenden Stil im berührten Code übernehmen, auch wenn man es selbst anders machen würde
- Verwaiste Imports/Variablen/Funktionen entfernen, die erst durch die eigene Änderung ungenutzt wurden; schon vorher vorhandenen toten Code nicht löschen, sondern als Beobachtung melden
- Jede geänderte Zeile muss sich direkt auf den Auftrag zurückführen lassen

## Prinzip 5: Einfachheit zuerst — kein Over-Engineering

Minimaler Code, der den Auftrag löst — nichts Spekulatives.
- Keine Features über das Gefragte hinaus, keine Abstraktion für Einmal-Code
- Keine „Flexibilität" oder „Konfigurierbarkeit", die nicht verlangt wurde
- Kein Error-Handling für unmögliche Szenarien
- Selbsttest: Würde ein erfahrener Entwickler das als überkompliziert bezeichnen? Wenn ja — vereinfachen. Entstehen z. B. 200 Zeilen, wo 50 genügen: neu schreiben.

## Prinzip 6: Preservation Checklist vor dem Abschluss

### UI
- [ ] Alle Buttons, Inputs, interaktive Elemente noch vorhanden und funktional
- [ ] Alle Event-Handler noch korrekt verdrahtet
- [ ] Layout ohne unbeabsichtigten Overflow oder Überlappung
- [ ] Style-Änderung auf beabsichtigten Scope begrenzt

### Logik / Service
- [ ] Alle Aufrufer der geänderten Funktion arbeiten noch korrekt
- [ ] Alle bisher gültigen Zustände noch korrekt behandelt
- [ ] Nichts entfernt das ein anderer Teil noch braucht

### Scope & Einfachheit
- [ ] Keine ungefragte Flexibilität, Abstraktion oder spekulatives Error-Handling (Prinzip 5)
- [ ] Bestehender Stil im berührten Code beibehalten; nur Auftragsbezogenes geändert (Prinzip 4)
- [ ] Schon vorher vorhandener toter Code nicht gelöscht, sondern gemeldet (Prinzip 4)
- [ ] Bestehende Tests die die geänderten Stellen abdecken wurden nachgeführt

### Projektspezifisch

Hier ergänzt jedes Repo seine eigenen, technologiestack-gebundenen Prüfpunkte
(z. B. bevorzugte State-Management-Muster, verbindliche gemeinsame Komponenten,
Label-/Übersetzungs-Konventionen, Berechtigungsprüfungen für neue Routen). Diese
gehören bewusst NICHT in dieses Ebene-1-Dokument, sondern in den projekteigenen
`code-discipline`-Skill bzw. dessen Projektkontext.

Bei Befund: sofort korrigieren, außer der Auftrag erlaubt ausdrücklich das Offenlassen.
