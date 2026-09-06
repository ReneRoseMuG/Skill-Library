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

## Obsolete Skills entfernen

Skills die ein anderes Projekt betreffen oder durch Ebene-1-Inhalte ersetzt wurden:
- Im Claude-Manifest deaktivieren (über Claude-UI)
- Aus `PROJECT/.claude/skills/` löschen wenn nicht mehr benötigt
- Nie einfach liegenlassen — veraltete Skills triggern bei falschen Aufträgen

---

## Verteilungsmechanismus (seit 2026-09)

Ebene 1 zerfällt in zwei Verteilungsarten, je nachdem ob der Inhalt tatsächlich
projektunabhängig ist:

- **`dev-testing/`** — bleibt reine Lesequelle. Kein Plugin, weil der Inhalt beim
  Instantiieren zu Ebene 3 zwangsläufig Technologiestack-Spezifika bekommt (andere
  Schichten, andere Dateipfade je Repo). Sync-Mechanismus: manueller Abgleich —
  Ebene-3-Skill verweist per „Quelle (Ebene 1)"-Fußzeile zurück, Änderung an der
  Quelle ist ein Signal zum Nachziehen, kein automatischer Prozess.
- **`plugins/pm-workflow-skills/`** — echtes Claude-Code-Plugin (Marketplace-Manifest
  `.claude-plugin/marketplace.json` in diesem Repo). Wird von jedem Repo mit
  Projekt-Manager-Anbindung installiert und bleibt dadurch wortgleich synchron, auch
  über mehrere Rechner hinweg (`git pull` in dieser Bibliothek + `claude plugin
  update`, siehe `templates/`). Bundelt zusätzlich den `projekt-manager`-MCP-Server,
  damit dieser nicht mehr pro Repo einzeln registriert werden muss.

Ein zukünftiger Kandidat für ein eigenes Plugin ist jeder Inhalt, der wie
`pm-workflow-skills` ausschließlich gegen eine gemeinsame Schnittstelle (MCP,
API) statt gegen repo-eigenen Code arbeitet.
