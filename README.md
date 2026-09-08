# Skill Library

Plattformneutrale Skill-Dokumentation für KI-Agenten (Claude, Codex und andere).

Enthält strukturierte Arbeitsanweisungen für wiederkehrende Entwicklungs- und Dokumentationsaufgaben.

---

## Struktur (seit der Plugin-Umstellung 2026-09)

Die Bibliothek trennt zwei grundsätzlich verschiedene Dinge:

| Bereich | Was | Verteilung |
|---|---|---|
| `dev-testing/` | Generische, technologiestack-freie Wissensbasis für Architektur, Datenmodell, Exploration, Testing (28 Dokumente) | Wird gelesen bzw. von einem projekteigenen, an den jeweiligen Stack angepassten Skill instantiiert — **kein** Plugin, da der Inhalt je Repo unterschiedlichen Code betrifft |
| `plugins/pm-workflow-skills/` | Projekt-Manager-MCP-Zugriff + Workflow-Skills (Doku, Spezifikation, Arbeitsauftrag, Tagebuch), die in jedem Repo identisch sein sollen | Echtes Claude-Code-Plugin über den Marketplace dieses Repos — installierbar in jedem Repo, synchron über `git pull` + Plugin-Update |

`templates/` enthält Vorlagen, damit ein Konsumenten-Repo `pm-workflow-skills` automatisch
(auch auf einem zweiten Rechner) installiert bekommt — und mit `templates/projekt-setup.md`
den Einstieg, der einen neuen Arbeitskontext an ein Projekt des Projekt Managers bindet
(siehe „Neues Projekt einrichten").

Warum diese Aufteilung: Dev/Testing-Skills verweisen zwangsläufig auf projekteigene Schichten,
Dateipfade und Konventionen (z. B. welches Frontend-Framework, welche Ordnerstruktur) — sie
können nicht wortgleich in zwei unterschiedlichen Anwendungen laufen. PM-Workflow-Skills
arbeiten dagegen ausschließlich gegen den MCP der Projekt-Manager-App und sind dadurch
tatsächlich projektunabhängig.

## Inhalt — dev-testing/ (28 Dokumente, 7 Kategorien)

| Ordner | System | Dokumente |
|---|---|---|
| `dev-testing/core/` | Gemeinsame Protokolle | graphify-protocol.md, code-discipline.md, planung.md |
| `dev-testing/exploration/` | Code Exploration & Impact | 4 |
| `dev-testing/architecture/` | Architektur & Design | 7 |
| `dev-testing/testing/` | Softwaretests | 5 |
| `dev-testing/data-model/` | Datenmodell & Persistenz | 3 |

## Inhalt — plugins/pm-workflow-skills/

MCP-Server `projekt-manager` + 7 Skills (`projekt-manager`, `projekt-setup`, `mcp-code-auftrag`,
`documentation`, `specification`, `feature-editorial`, `tagebuch`) + Stop-Hook für sitzungsweites
Kommentar-Logging. Referenzmaterial (Ebene-1-Fassung der Skills) liegt unter
`plugins/pm-workflow-skills/reference/`, die Vorlagen der Projekt-Einrichtung unter
`plugins/pm-workflow-skills/reference/setup/`.

---

## Verwendung

### dev-testing/ — als Wissensbasis (direkt lesen, projekteigenen Skill instantiieren)

```
"Lies dev-testing/architecture/02-bestandsanalyse.md und analysiere die Änderung."
```

Projektspezifische SKILL.md-Dateien (`PROJECT/.claude/skills/<name>/SKILL.md`) passen diesen
Inhalt an den Technologiestack des Repos an und verweisen am Ende auf ihre Ebene-1-Quelle
(„Quelle (Ebene 1): Skill Library `dev-testing/...`") — bei Änderung an der Bibliothek dort
zuerst ändern, dann im Repo nachziehen.

### plugins/pm-workflow-skills/ — als Plugin installieren

```bash
claude plugin marketplace add ReneRoseMuG/Skill-Library
claude plugin install pm-workflow-skills@skill-library
```

Für automatische Installation bei jeder Sitzung (auch nach einem Rechnerwechsel):
siehe `templates/settings-snippet.md`.

### Neues Projekt einrichten — von jedem Arbeitsplatz

Ein Repo (Claude Code) oder ein Claude-Projekt (Cowork) wird mit **einem** Auftrag an ein
Projekt des Projekt Managers gebunden:

```
"Lies https://raw.githubusercontent.com/ReneRoseMuG/Skill-Library/main/templates/projekt-setup.md
 und führe die Einrichtung aus."
```

Die Sitzung fragt `PROJ-<id>` und die Wiki-Wurzelseite ab, verifiziert beides per MCP,
erfasst den Arbeitsplatz (Gerätename, Nextcloud-Datenordner und Repo-Klon auf diesem
Rechner), schreibt die Bindung (`docs/projekt-kontext.md` bzw. Projekt-Doc
`claude/projekt-kontext.md` als Master, Spiegel `projekt-kontext.md` im Datenordner),
stellt die Skills bereit (Plugins bzw. Account-Skill `pm-workflow`), ergänzt
`agents.md`/`CLAUDE.md` bzw. die Projektanweisungen und loggt einen Startkommentar.
Ist das Plugin bereits installiert, genügt „richte das Projekt ein" (Skill `projekt-setup`).
Auf dem zweiten Rechner derselbe Auftrag: die Sitzung ergänzt nur die Arbeitsplatz-Zeile.
Ablauf und Vorlagen: `plugins/pm-workflow-skills/reference/setup/`; Modell „Master und
Spiegel" in `ARCHITECTURE.md`.

---

## Design-Prinzipien

**Plattformneutral** (dev-testing/) — kein Projektname, keine konkreten Pfade, keine Technologiestack-Abhängigkeiten.

**Graphify-first** — alle code-nahen Skills starten mit `dev-testing/core/graphify-protocol.md`, sofern das Repo Graphify nutzt.

**Solo-Developer-optimiert** — kein Übergabeformalismus, keine überflüssigen Orchestratoren, proportionaler Analyseumfang.

**MCP-aware** — `pm-workflow-skills` ist bewusst für die Projekt-Manager-MCP gebaut und dadurch tatsächlich teilbar, statt nur referenziert.

**Drei-Ebenen-Modell** — diese Library ist Ebene 1. Ebene 2 sind globale Claude-Skills. Ebene 3 sind projektspezifische Regeln. Siehe `ARCHITECTURE.md`.

---

## Beitragen

Neue **dev-testing**-Skills folgen dem bestehenden Format:
1. Zweck (1 Satz)
2. Trigger / Nicht-Trigger
3. Pflichtablauf (nummeriert)
4. Leitplanken
5. Ergebnisformat (Tabelle)

Keine Projektverweise, keine absoluten Pfade, kein Technologiestack.

Neue **pm-workflow-skills**-Inhalte müssen mit *beiden* aktuell angeschlossenen Repos
(Projekt Manager, MuGPlan) kompatibel bleiben — vor dem Commit gedanklich gegen beide prüfen.
