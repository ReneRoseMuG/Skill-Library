# Skill Library

Plattformneutrale Skill-Dokumentation für KI-Agenten (Claude, Codex und andere).

Enthält strukturierte Arbeitsanweisungen für wiederkehrende Entwicklungs- und Dokumentationsaufgaben.
Jede Datei beschreibt einen Skill: Zweck, Ablauf, Leitplanken, Ergebnisformat.

---

## Inhalt

| Ordner | System | Skills | Status |
|---|---|---|---|
| `core/` | Gemeinsame Protokolle | 1 | Stabil |
| `exploration/` | Code Exploration & Impact | 4 | Neu |
| `architecture/` | Architektur & Design | 7 | Überarbeitet |
| `testing/` | Softwaretests | 5 | Verschlankt (war 10) |
| `specification/` | Spezifikationsredaktion | 3 | MCP-orientiert |
| `documentation/` | Anwenderdokumentation | 5 | Verschlankt (war 10) |
| `data-model/` | Datenmodell & Persistenz | 3 | Neu |

**Gesamt: 28 Skills** (vorher: ~40 .docx-Dokumente)

---

## Verwendung

### Als Wissensbasis (direkt lesen)
Ein Agent liest die relevante Datei und wendet den beschriebenen Ablauf an:

```
"Lies architecture/02-bestandsanalyse.md und analysiere die Änderung."
```

### Als Projekt-Skill (in .claude/skills/ einbinden)
Projektspezifische SKILL.md-Dateien referenzieren diese Bibliothek:

```markdown
---
name: exploration
description: Code-Exploration vor jeder Änderung
---
Lies und wende an: [Skill Library]/exploration/01-orchestrator.md
Projektkontext: .claude/project-context/
```

---

## Design-Prinzipien

**Plattformneutral** — kein Projektname, keine konkreten Pfade, keine Technologiestack-Abhängigkeiten.

**Graphify-first** — alle code-nahen Skills starten mit `core/graphify-protocol.md`. Graphify ist Pflicht, nicht Option.

**Solo-Developer-optimiert** — kein Übergabeformalismus, keine überflüssigen Orchestratoren, proportionaler Analyseumfang.

**MCP-aware** — Specification und Documentation sind auf Projekt-Manager-MCP ausgerichtet. Andere Projekte passen den Datenzugriff an.

**Drei-Ebenen-Modell** — diese Library ist Ebene 1 (neutral). Ebene 2 sind globale Claude-Skills. Ebene 3 sind projektspezifische Regeln. Siehe `ARCHITECTURE.md`.

---

## Beitragen

Neue Skills folgen dem bestehenden Format:
1. Zweck (1 Satz)
2. Trigger / Nicht-Trigger
3. Pflichtablauf (nummeriert)
4. Leitplanken
5. Ergebnisformat (Tabelle)

Keine Projektverweise, keine absoluten Pfade, kein Technologiestack.
