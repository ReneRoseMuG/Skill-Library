# Architektur: Drei-Ebenen-Modell

Beschreibt wo Skill-Inhalte abgelegt werden und wie die Ebenen zusammenwirken.

---

## Übersicht

```
EBENE 1 — Skill Library (dieses Repo)
  Plattformneutrale Skill-Templates
  Kein Projektbezug, keine konkreten Pfade
  Dient als Wissensbasis für alle Agenten

EBENE 2 — Globale Agent-Skills (~/.claude/skills/)
  Aufrufbare Skills ohne Projektbindung
  Referenzieren oder adaptieren Ebene-1-Inhalte
  Erscheinen in der globalen Skill-Liste des Agenten

EBENE 3 — Projektspezifische Skills (PROJECT/.claude/)
  Projekt-Kontext-Dateien (Regeln, Schema, Conventions)
  Projektspezifische SKILL.md-Dateien
  Erscheinen in der Skill-Liste wenn das Projekt aktiv ist
```

---

## Ebene 1 — Skill Library

**Inhalt:** Generische Skill-Definitionen in Markdown.

**Regeln:**
- Kein Projektname, kein Unternehmensname
- Keine absoluten Pfade
- Keine Technologiestack-Spezifika (kein "React", "SQLite", "TanStack Query")
- Plattformneutral: funktioniert für Claude, Codex, andere Agenten

**Verwendung:**
- Agenten lesen Dateien direkt als Kontext
- Projektspezifische Skills (Ebene 3) referenzieren Ebene-1-Dateien

---

## Ebene 2 — Globale Agent-Skills

**Ort:** `~/.claude/skills/<skill-name>/SKILL.md`

**Inhalt:** Aufgerufene Skills die über Projekte hinweg gelten.

**Beispiele:**
- `projekt-manager` — MCP-Zugriff auf den Projekt Manager (projektübergreifend nützlich)
- `codex-aufgabe` — Erstellt Codex-Arbeitsaufträge (projektübergreifend)

**Regeln:**
- Dürfen Ebene-1-Dateien referenzieren
- Kein hartkodierter Projektkontext
- Werden im Claude-Manifest aktiviert/deaktiviert

---

## Ebene 3 — Projektspezifische Skills

**Ort:** `PROJECT/.claude/`

```
PROJECT/.claude/
├── settings.json
├── skills/
│   ├── planungsleitplanken/SKILL.md    ← Projektspezifische Regeln
│   ├── code-discipline/SKILL.md        ← Projektspezifische Checks
│   ├── test-entwurfsleitplanken/SKILL.md
│   └── exploration/SKILL.md            ← Adaptiert Ebene-1 + Projektpfade
└── project-context/
    ├── ui-rules.md                      ← UI/UX Regeln für dieses Projekt
    ├── data-schema.md                   ← Aktuelles Datenbankschema
    └── architecture-rules.md           ← Projektspezifische Architekturentscheidungen
```

**Regeln:**
- Dürfen projektspezifische Pfade, Technologien und Konventionen enthalten
- Referenzieren oder adaptieren Ebene-1-Inhalte
- Überschreiben Ebene-2-Skills wenn gleichnamig

---

## Was wohin gehört

| Inhalt | Ebene |
|---|---|
| Allgemeines Explorations-Protokoll | 1 — Skill Library |
| Graphify-Protokoll | 1 — Skill Library |
| Allgemeine Test-Qualitätsprinzipien | 1 — Skill Library |
| Spezifische Test-Konventionen (TanStack Query) | 3 — Project-Context |
| UI-Konsistenz-Regeln | 3 — Project-Context |
| Datenbankschema | 3 — Project-Context |
| Architekturentscheidungen | 3 — Project-Context |
| MCP-Zugriff (allgemein) | 2 — Globale Skills |
| MCP-Zugriff (projektspezifisch konfiguriert) | 3 — Projektskills |
| Naming-Konventionen des Projekts | 3 — Project-Context |

---

## Graphify-Integration

Graphify-Ausgaben (`graphify-out/`) leben im Projektrepository — nicht in der Skill Library.
Die Skill Library definiert wie Graphify verwendet wird (`core/graphify-protocol.md`).
Projektspezifische Skills wenden dieses Protokoll auf den lokalen Graphen an.

---

## Orchestrierung

Der Einstieg über `core/00-auftrags-orchestrator.md` ist verbindlich: Er klassifiziert den Auftrag, aktiviert nur die nötigen Spezialisierungsskills und sichert die Reihenfolge Analyse → Planung → Umsetzung → Abschluss. `core/work-order.md` ergänzt ihn für Aufträge, die aus einem Vorgangssystem stammen.

Ebene-3-Skills **referenzieren** diese Ebene-1-Dateien, statt ihren Inhalt zu kopieren. Kopieren erzeugt Drift: Die Projektfassung veraltet gegenüber der Vorlage, ohne dass es auffällt.

---

## Obsolete Skills entfernen

Skills die ein anderes Projekt betreffen oder durch Ebene-1-Inhalte ersetzt wurden:
- Im Claude-Manifest deaktivieren (über Claude-UI)
- Aus `PROJECT/.claude/skills/` löschen wenn nicht mehr benötigt
- Nie einfach liegenlassen — veraltete Skills triggern bei falschen Aufträgen
