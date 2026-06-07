# Impact-Analyse

Ermittelt was betroffen ist wenn Komponente, Service, Schema oder API geändert wird.
Beantwortet: Was bricht? Was muss angepasst werden? Welche Tests sind betroffen?

---

## Zweck

Beantwortet die Frage: **Was passiert wenn X verändert wird?**

- Direkte Aufrufer
- Indirekte Abhängigkeiten über mehrere Schichten
- Betroffene Tests
- Betroffene Dokumentation
- Betroffene Features und Use Cases

---

## Pflichtablauf

### Phase 1 — Zielkomponente verstehen

```bash
graphify explain "<Zielkomponente>"
```

Danach im Quellcode:
- Vollständige öffentliche Schnittstelle lesen (Props, Exports, API-Verträge)
- Alle Verwendungsarten verstehen

### Phase 2 — Direkte Aufrufer ermitteln

```bash
graphify path "<Aufrufer>" "<Zielkomponente>"
```

Ergänzend: Symbol- und Importsuche im Repository für nicht im Graph erfasste Aufrufer.

### Phase 3 — Indirekte Abhängigkeiten

Für jeden direkten Aufrufer: prüfen ob dieser wiederum aufgerufen wird.
Relevante Schichten in der Analyse:
- UI-Komponenten (Rendering, Props, Events)
- Hooks und State-Management
- Services und Business-Logik
- Repositories und Datenzugriff
- API-Routen und Contracts
- Persistenz und Schema

### Phase 4 — Tests und Dokumentation

**Tests:**
- Welche Testdateien referenzieren die Zielkomponente direkt?
- Welche Tests testen Aufrufer, die betroffen sind?
- Welche E2E-Flows laufen durch die betroffene Komponente?

**Dokumentation:**
- Welche Feature- oder Use-Case-Dokumente beschreiben das betroffene Verhalten?
- Welche Wiki-Artikel sind betroffen?

### Phase 5 — Risikobewertung

| Risiko | Merkmale |
|---|---|
| Hoch | Viele Aufrufer, zentrale Schnittstelle, breit getestete Komponente |
| Mittel | Einige Aufrufer, klar abgegrenzter Bereich |
| Niedrig | Wenige Aufrufer, isoliert, gut getestet |

---

## Seiteneffekte — was zu prüfen ist

- Shared State: Zustandsänderungen die andere Komponenten lesen
- Events und Callbacks: Vertragsänderungen die Aufrufer brechen
- API-Contracts: Breaking Changes in Requests/Responses
- Datenbankschema: Migrations- oder Kompatibilitätsanforderungen
- CSS/Styles: Geteilte Klassen die andere Layouts beeinflussen
- Typen: Shared-Type-Änderungen die andere Pakete betreffen

---

## Leitplanken

- Aufrufer-Analyse endet nicht bei direkten Aufrufen — mindestens eine Ebene tiefer prüfen.
- "Kein Aufrufer im Graph" ≠ kein Aufrufer im Code — Symbol-/Textsuche zusätzlich durchführen.
- Tests und Doku sind vollständige Teile der Impact-Analyse, keine Nachgedanken.
- Risikobewertung ist Eingabe für Architektur- und Umsetzungsentscheidung, nicht für diese Analyse.

---

## Ergebnisformat

```
Zielkomponente: <Name> (<Datei>)
Geplante Änderung: <Typ der Änderung>

Direkte Aufrufer (<Anzahl>):
- <Datei>: <Art der Verwendung>

Indirekte Abhängigkeiten:
- <Schicht>: <betroffene Dateien>

Betroffene Tests:
- <Testdatei>: <was getestet wird>

Betroffene Dokumentation:
- <Dokument>: <relevanter Abschnitt>

Seiteneffekte:
- <Typ>: <Beschreibung>

Risiko: Hoch | Mittel | Niedrig
Begründung: <warum>

Offenes: <Unklares oder fehlende Quellen>
```
