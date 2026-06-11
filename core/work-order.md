# Arbeitsauftrags-Orchestrator

Orchestriert Aufträge, die aus einem Vorgangs- oder Tracking-System stammen und ein verwaltetes Objekt als Quelle referenzieren. Lädt dessen Kontext, leitet den Auftrag ab und regelt den Abschluss.

---

## Trigger

- Der Auftrag nennt eine Referenz auf ein verwaltetes Objekt (z. B. Projekt, Meilenstein, Aufgabe, Ticket) als Auftragsquelle.

## Nicht-Trigger

- Freier Auftrag ohne Bezug zu einem verwalteten Objekt.

---

## Pflichtablauf

1. Referenz und Typ bestimmen: Parent (Auftragsquelle) und Arbeitsgegenstand (Ziel) unterscheiden.
2. Kontext laden: das referenzierte Objekt mit Kindern, Kommentaren, Notizen, Anhängen und Relationen — rekursiv, soweit für den Auftrag relevant.
3. Kontext in die Analyse einbinden: offene Kommentare, verknüpfte Vorgänge, Abhängigkeiten, Reihenfolge und erkennbare Blocker auswerten.
4. Auftrag daraus ableiten — keine fehlenden Anforderungen erfinden; bei Widersprüchen nachfragen oder Blocker benennen.
5. Vor der Umsetzung klären, ob direkt ausgeführt oder zuerst geplant werden soll.
6. Umsetzung über den `00-auftrags-orchestrator.md`.
7. Abschluss **erst nach Ende der gesamten Aufgabe**: ein zusammenfassender, menschenlesbarer Abschlussbericht am Auftrags-Parent.
8. Status des bearbeiteten Objekts auf einen „wartet auf Prüfung"-Zustand setzen — **nicht** schließen. Das Schließen ist eine ausdrückliche Nutzerentscheidung.

---

## Leitplanken

- Großen Kontextbaum nicht roh ausgeben — nach Relevanz verdichten.
- Zwischenstände dürfen intern protokolliert werden; der Bericht an das Vorgangssystem erfolgt **einmal, am Ende**.
- Das bearbeitete Objekt niemals eigenständig abschließen oder schließen.
- Konkrete Statuswerte, Feldnamen und Zugriffstools sind projektspezifisch (Ebene 3) — hier wird nur das Muster festgelegt.

---

## Ergebnisformat

| Feld | Inhalt |
|---|---|
| Referenz | Parent und Arbeitsgegenstand |
| Kontext | Relevante Kinder, Kommentare, Relationen |
| Abgeleiteter Auftrag | Was umzusetzen ist + Abnahmekriterien |
| Abschluss | Bericht am Ende, gesetzter Wartestatus |
| Offenes | Blocker, Rückfragen, bewusst Ausgelassenes |
