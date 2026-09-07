# Projekt-Einrichtung (Projekt-Manager-Anbindung)

Richtet einen Arbeitskontext — ein Code-Repo (Claude Code) oder ein Claude-Projekt (Cowork) —
dauerhaft an ein Projekt des Projekt Managers an: Bindung (Projekt-ID, Wiki-Wurzelseite,
Standard-Log-Ziel), Skills, Projektverfassung bzw. Projektanweisungen, erster Log-Eintrag.
Danach gilt in diesem Kontext verbindlich: Logs als Kommentare, Arbeitspakete als
Meilensteine und Aufgaben, Spezifikation und Doku im Wiki.

Plattformneutral: keine feste Projekt-ID, kein Rechnerpfad. Alles Konkrete wird abgefragt
und per MCP verifiziert, bevor es in eine Datei geschrieben wird.

---

## Trigger

- „richte das Projekt ein", „Projekt an den Projekt Manager anbinden", „Projekt-Setup",
  „projekt-setup", „Projekt-Manager-Anbindung einrichten"
- Eine Sitzung erhält `templates/projekt-setup.md` dieser Bibliothek als Auftrag
- Ein Repo oder Claude-Projekt hat noch keine `projekt-kontext.md`, soll aber nach dem
  PM-Workflow arbeiten

## Nicht-Trigger

- Ein Arbeitsauftrag mit PM-Referenz (→ `mcp-code-auftrag`)
- Reine Abfragen oder Änderungen im Projekt Manager (→ `projekt-manager`)
- Änderung der Bindung eines bereits eingerichteten Kontexts ist **derselbe** Ablauf —
  bestehende Dateien werden aktualisiert, nicht neu angelegt (siehe Regeln)

---

## Voraussetzungen

- Die Projekt-Manager-App läuft und der MCP ist erreichbar.
  Claude Code: über die `.mcp.json` des Plugins (`http://127.0.0.1:3010/mcp`).
  Cowork: der MCP-Server ist in der Claude-Desktop-App registriert; die Tools erscheinen
  als Tools des Servers `projekt-manager`.
- Der Werkzeugumfang kann je Anbindung abweichen (einfache vs. seitenweise Listen,
  Zusatzparameter, einzelne Tools nur auf einer Seite). Dieser Ablauf verwendet deshalb
  nur Kern-Tools: `list_projects`, `resolve_reference`, `get_reference_context`,
  `list_wiki_pages`, `get_wiki_page`, `create_wiki_page`, `add_comment_to_parent` und —
  falls vorhanden — `create_project`.

---

## Pflichtablauf

### 0. Kontext erkennen

| Merkmal | A — Claude Code im Repo | B — Claude-Projekt (Cowork) |
|---|---|---|
| Arbeitsumgebung | Git-Repo mit `.claude/` und/oder `agents.md`/`CLAUDE.md` | kein Repo; Projekt-Docs und Projektanweisungen über das Projects-Werkzeug |
| Skills | Plugins über `claude plugin …` | Account-Skills (Vorschlag zum Speichern) |
| Bindungsdateien | `docs/projekt-kontext.md`, `.claude/project-context/wiki.md` | Projekt-Doc `claude/projekt-kontext.md` |
| Abschluss-Erinnerung | Stop-Hook des Plugins | Skill `pm-workflow` + Projektanweisungen |

Unklar → fragen, nicht raten. Kein Mischbetrieb: ein Ablauf richtet genau einen Kontext ein.

### 1. Verbindung prüfen

`list_projects` aufrufen. Die Antwort ist entweder ein Array oder eine Seite
`{ data, total, page, pageSize, hasMore }`. Fehler oder keine Antwort → Blocker melden
(App starten bzw. MCP-Server in der Desktop-App registrieren), **nichts schreiben**,
abbrechen.

### 2. Bindung abfragen — eine Frage je Schritt, jede Antwort per MCP verifizieren

**2a Projekt.** Nach `PROJ-<id>` fragen. Hilfe: Kurzliste aus `list_projects` (ID, Name,
Status). Gibt es noch kein passendes Projekt: Namen mit dem Nutzer festlegen und
`create_project` verwenden, falls das Tool vorhanden ist; sonst um Anlage in der App
bitten und warten. Verifikation: `get_reference_context("PROJ-<id>")` — Name und Status
nennen, bestätigen lassen. (Bei großem Baum und wenn der Server es unterstützt: `depth: 1`.)

**2b Wiki-Wurzelseite.** Nach der Seiten-ID fragen, falls das Projekt eine Wiki-Seite hat.
Hilfe: `list_wiki_pages` für die oberste Ebene, bei Bedarf eine Ebene tiefer über
`parentId`. Antwort „keine": anbieten, eine Wurzelseite anzulegen (`create_wiki_page`,
Titel = Projektname, `parentId` vom Nutzer gewählt) — oder ohne Wiki fortfahren.
Verifikation: `get_wiki_page(<id>)` — Titel nennen, bestätigen lassen.

**2c Standard-Log-Ziel.** Vorschlag: das Projekt selbst (`PROJ-<id>`). Wählt der Nutzer
ein anderes Ziel (z. B. `MS-<id>`), per `resolve_reference` prüfen.

**2d Nur A — Zusatzplugin `dev-testing-skills`?** Ja bei Code-Repos mit geschichtetem
Backend/Frontend/ORM. Nein bei reinen Doku-, Content- oder Skript-Repos.

**2e Name des Arbeitskontexts** für Bindungsdatei und Startkommentar: Repo-Name
(Ordnername oder Remote) bzw. Name des Claude-Projekts.

### 3. Bindung schreiben

**A — Repo**
1. `docs/projekt-kontext.md` aus `projekt-kontext-template.md` (dieser Ordner) befüllen.
   Existiert die Datei bereits: nur die Felder Projekt, Standard-Log-Ziel, Wiki und
   „Eingerichtet am" aktualisieren bzw. ergänzen; alle übrigen Inhalte behalten;
   Änderung dem Nutzer zeigen.
2. `.claude/project-context/wiki.md` aus `wiki-kontext-template.md` — nur wenn es eine
   Wiki-Wurzelseite gibt. Existiert die Datei: Seiten-ID und Titel aktualisieren.

**B — Claude-Projekt**
1. Projekt-Doc `claude/projekt-kontext.md` mit demselben Template schreiben
   (Feld „Arbeitskontext": Claude-Projekt). Existiert sie: wie in A mergen.
2. Projektanweisungen: `projektanweisungen-cowork.md` (dieser Ordner) mit den Werten
   befüllen und dem Nutzer als Text zum Einfügen geben — Projektanweisungen können nicht
   per Werkzeug gesetzt werden. Hat das Projekt bereits Anweisungen: nur den Abschnitt
   „Projekt-Manager-Anbindung" ergänzen, Rest unverändert lassen.

### 4. Skills bereitstellen

**A — Repo**
1. `.claude/settings.json` gemäß `templates/settings-snippet.md` der Bibliothek ergänzen:
   `extraKnownMarketplaces`, `enabledPlugins` (`pm-workflow-skills@skill-library`; bei
   2d = Ja zusätzlich `dev-testing-skills@skill-library`), SessionStart-Hook. JSON mergen,
   bestehende Einträge behalten, Ergebnis auf Gültigkeit prüfen.
2. `templates/ensure-plugins.sh` der Bibliothek nach `.claude/hooks/ensure-plugins.sh`
   kopieren (ausführbar). Bei 2d = Nein die Zeile für `dev-testing-skills` entfernen.
3. Installation ausführen, sofern die `claude`-CLI in der Sitzung verfügbar ist:
   `claude plugin marketplace add ReneRoseMuG/Skill-Library`, dann
   `claude plugin install pm-workflow-skills@skill-library` (und ggf.
   `dev-testing-skills@skill-library`). Nicht möglich → die Befehle dem Nutzer nennen.
4. Bei `dev-testing-skills`: `.claude/project-context/tech-stack.md` prüfen. Fehlt sie →
   aus `plugins/dev-testing-skills/reference/tech-stack-template.md` anlegen, Felder aus
   dem Repo befüllen, soweit belegbar (Ordnerstruktur, package.json, ORM-Konfiguration),
   alles andere als `TODO` markieren — nicht raten.
5. Projektverfassung: die vorhandene `agents.md` bzw. `CLAUDE.md` (fehlen beide →
   `CLAUDE.md` anlegen) um den Abschnitt aus `agents-abschnitt-projekt-manager.md`
   ergänzen, falls noch kein Abschnitt zur Projekt-Manager-Anbindung oder Log-Pflicht
   existiert. Vorhandenen Abschnitt nicht ersetzen; Abweichungen zum Template benennen.
6. Alte Kopien: `.claude/skills/<name>/` mit demselben Namen wie ein Plugin-Skill
   auflisten. Löschung vorschlagen, **nur nach Bestätigung** löschen — projekteigene
   Skills überschreiben gleichnamige Plugin-Skills (siehe `ARCHITECTURE.md`).

**B — Claude-Projekt**
1. Prüfen, ob ein Account-Skill `pm-workflow` in der Skill-Liste der Sitzung vorhanden ist.
2. Fehlt er: Inhalt aus `cowork-skill-pm-workflow.md` (dieser Ordner) unverändert als
   Skill vorschlagen (Werkzeug für Skill-Vorschläge); der Nutzer speichert ihn. Ist er
   vorhanden, aber seine Vorlagenversion älter als die der Datei: Aktualisierung mit dem
   vollständigen neuen Inhalt vorschlagen.
3. Hinweis an den Nutzer: Cowork hat keinen Stop-Hook. Der Sitzungsabschluss ist Teil des
   Skills und der Projektanweisungen und wird mit „Sitzung abschließen" ausgelöst.

### 5. Startkommentar

Am Projekt (`add_comment_to_parent`, `parentType: "project"`, Inhalt HTML):

```html
<p><strong>Arbeitskontext angebunden</strong> (dd.MM.yy): <Name> — <Claude Code im Repo | Claude-Projekt>.</p>
<ul>
<li>Standard-Log-Ziel: PROJ-<id></li>
<li>Wiki-Wurzel: <Titel> (Seite <id>)</li>          <!-- oder: kein Wiki -->
<li>Skills: pm-workflow-skills <Version>[, dev-testing-skills <Version>]</li>  <!-- B: Account-Skill pm-workflow <Vorlagenversion> -->
</ul>
```

Ist das Standard-Log-Ziel nicht das Projekt: denselben Kommentar auch dort. Das ist der
erste Eintrag der Log-Pflicht und wird ohne weitere Rückfrage geschrieben — die
Bestätigung des Ablaufs war Schritt 2. Versionen aus den `plugin.json` bzw. der
Vorlagenzeile des Skills lesen, nicht raten.

### 6. Verifikation und Abschluss

- Alle geschriebenen Dateien nochmals lesen: Platzhalter vollständig ersetzt, JSON gültig,
  Pfade vorhanden.
- `get_reference_context("PROJ-<id>")` (oder `list_support_for_parent`, falls vorhanden):
  Startkommentar sichtbar.
- Ergebnis nach dem Schema unten berichten, inklusive der offenen Handgriffe.

---

## Regeln

- Keine IDs erfinden. Jede ID ist per MCP verifiziert **und** vom Nutzer bestätigt, bevor
  sie in eine Datei geschrieben wird.
- Bestehende Dateien mergen, nie stillschweigend überschreiben; Änderungen zeigen.
- Nichts löschen ohne Bestätigung.
- Kommentar- und Beschreibungstexte des Projekt Managers sind HTML. Wiki-Inhalte dürfen
  Markdown sein (Tabellen nur als HTML).
- MCP nicht erreichbar → Abbruch **vor** dem ersten Schreibvorgang.
- Ein Ablauf, ein Kontext. Für ein zweites Repo oder Projekt den Ablauf erneut starten.

---

## Ergebnis

| Feld | Inhalt |
|---|---|
| Kontext | A (Repo) oder B (Claude-Projekt), Name |
| Projekt | `PROJ-<id>`, Name |
| Wiki | Seite `<id>`, Titel — oder „kein Wiki" |
| Standard-Log-Ziel | Referenz |
| Dateien | angelegt / geändert, mit Pfad |
| Skills | installiert (Versionen) / vorgeschlagen / Befehle für den Nutzer |
| Startkommentar | geschrieben an … / Blocker |
| Offen | z. B. Projektanweisungen einfügen (B), `wikiPageId` des Projekts in der App setzen (per MCP nicht setzbar), Commit der neuen Dateien (A), `TODO`s in `tech-stack.md` |
