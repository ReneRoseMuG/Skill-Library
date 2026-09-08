# Projekt-Einrichtung (Projekt-Manager-Anbindung)

Richtet einen Arbeitskontext — ein Code-Repo (Claude Code) oder ein Claude-Projekt (Cowork) —
dauerhaft an ein Projekt des Projekt Managers an: Bindung (Projekt-ID, Wiki-Wurzelseite,
Standard-Log-Ziel), Arbeitsplätze (Datenordner und Repo je Rechner), Skills,
Projektverfassung bzw. Projektanweisungen, erster Log-Eintrag. Danach gilt in diesem Kontext
verbindlich: Logs als Kommentare, Arbeitspakete als Meilensteine und Aufgaben, Spezifikation
und Doku im Wiki.

Plattformneutral: keine feste Projekt-ID, kein Rechnerpfad in diesem Ablauf. Alles Konkrete
wird abgefragt, per MCP bzw. Dateisystem verifiziert und landet ausschließlich in der
Bindungsdatei.

**Modell:** Ein Projekt existiert an vier Orten — Projekt-Manager-Projekt (gemeinsames
Gedächtnis aller Rechner), Claude-Projekt, lokaler Datenordner (über Nextcloud auf jedem
Rechner synchronisiert) und ggf. Git-Repo (lokaler Klon je Rechner). Die Bindung beschreibt
alle vier und hat genau einen **Master**: die Projekt-Doc `claude/projekt-kontext.md` des
Claude-Projekts, sonst `docs/projekt-kontext.md` des Repos. Datenordner (`projekt-kontext.md`)
und Repo (`docs/projekt-kontext.md`) führen **Spiegel** mit identischem Inhalt.

---

## Trigger

- „richte das Projekt ein", „Projekt an den Projekt Manager anbinden", „Projekt-Setup",
  „projekt-setup", „Projekt-Manager-Anbindung einrichten"
- „neuer Rechner", „Arbeitsplatz ergänzen" — oder ein eingerichteter Kontext wird erstmals
  auf einem Rechner geöffnet, dessen Gerätename nicht in der Tabelle „Arbeitsplätze" steht
  (→ Kurzablauf „Nur Arbeitsplatz ergänzen")
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
  als Tools des Servers `projekt-manager`. Cowork erreicht MCP **und** Rechner nur, solange
  die Sitzung mit dem Rechner verbunden ist (Desktop-App geöffnet).
- Der Werkzeugumfang kann je Anbindung abweichen (einfache vs. seitenweise Listen,
  Zusatzparameter, einzelne Tools nur auf einer Seite). Dieser Ablauf verwendet deshalb
  nur Kern-Tools: `list_projects`, `resolve_reference`, `get_reference_context`,
  `list_wiki_pages`, `get_wiki_page`, `create_wiki_page`, `add_comment_to_parent` und —
  falls vorhanden — `create_project`.
- Rechnerzugriff in Cowork: `get_device_info` (Gerätename, verbundene Ordner),
  `device_list_dir` (Existenz prüfen), `device_request_folder_access` (Ordner verbinden —
  kostet eine Bestätigung des Nutzers, deshalb sparsam), `device_stage_files` /
  `device_commit_files` (Datei lesen / schreiben). In Claude Code: `hostname` und die
  gewöhnlichen Dateiwerkzeuge.
- Vorlagen aus dieser Bibliothek werden **wörtlich** gelesen (lokaler Klon oder
  `git clone --depth 1` im Arbeitsbereich der Sitzung). Web-Abrufe, die Seiten
  zusammenfassen, sind für Vorlagen ungeeignet.

---

## Pflichtablauf

### 0. Kontext erkennen

| Merkmal | A — Claude Code im Repo | B — Claude-Projekt (Cowork) |
|---|---|---|
| Arbeitsumgebung | Git-Repo mit `.claude/` und/oder `agents.md`/`CLAUDE.md` | kein Repo; Projekt-Docs und Projektanweisungen über das Projects-Werkzeug |
| Skills | Plugins über `claude plugin …` | Account-Skills (Vorschlag zum Speichern) |
| Bindungsdateien | `docs/projekt-kontext.md`, `.claude/project-context/wiki.md` | Projekt-Doc `claude/projekt-kontext.md` |
| Rechnererkennung | `hostname` | `get_device_info` → `deviceName` |
| Datenordner-Spiegel | `projekt-kontext.md` im Datenordner (Pfad aus der Arbeitsplatz-Zeile) | dito, nach `device_request_folder_access` |
| Abschluss-Erinnerung | Stop-Hook des Plugins | Skill `pm-workflow` + Projektanweisungen |

Unklar → fragen, nicht raten. Kein Mischbetrieb: ein Ablauf richtet genau einen Kontext ein.

**Kurzablauf „Nur Arbeitsplatz ergänzen":** Der Kontext ist bereits eingerichtet (Bindungsdatei
vorhanden, IDs bestätigt), nur der aktuelle Rechner fehlt in der Tabelle. Dann: Schritt 1 →
Master lesen → Schritt 2f → Zeile im Master ergänzen → Spiegel aktualisieren (Schritt 3,
nur Arbeitsplatz-Tabelle) → Kommentar am Standard-Log-Ziel „Arbeitsplatz ergänzt (dd.MM.yy):
<Gerätename> — Datenordner, Repo" → Schritt 6. IDs werden **nicht** erneut abgefragt.

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

**2f Arbeitsplatz (dieser Rechner).** Gerätename ermitteln (A: `hostname`; B:
`get_device_info` → `deviceName`) und dem Nutzer nennen. Dann abfragen:
- **Datenordner** — rechnerunabhängiger Name innerhalb von Nextcloud (z. B.
  „Projekte/<Projektname>") und der absolute lokale Pfad auf diesem Rechner. Hilfe B:
  `device_list_dir` auf `~` liefert die Ordnernamen der obersten Ebene, ohne Zugriff
  anzufordern; Pfad Ebene für Ebene aus gesehenen Namen aufbauen. Antwort „keinen": Feld
  „kein Datenordner", kein Spiegel.
- **Repo** — Remote-URL (A: `git remote -v`; B: aus `.git/config` im Klon, falls der Ordner
  verbunden ist, sonst vom Nutzer) und lokaler Klon-Pfad auf diesem Rechner. Antwort „kein
  Repo": Feld „kein Repo", Spalte „—".
- **Bemerkung** (optional, z. B. „Homeoffice", „Büro").

Verifikation: jeder Pfad muss auf diesem Rechner existieren (A: Verzeichnis lesen; B:
`device_list_dir`, bei Bedarf `device_request_folder_access`). Nicht vorhanden → nicht
eintragen, Nutzer fragen. Pfade anderer Rechner werden nie übernommen — Benutzername und
Ordnerstruktur unterscheiden sich je Rechner.

**2g Master der Bindung.** Hat das Projekt ein Claude-Projekt (B, oder A mit bekanntem
Claude-Projekt): Master = dessen Projekt-Doc `claude/projekt-kontext.md`. Sonst Master =
`docs/projekt-kontext.md` des Repos. Wird in der Bindungsdatei eingetragen (Feld „Master
dieser Bindung"). Existiert bereits ein Master mit anderen Werten als den soeben
bestätigten: Abweichung zeigen, Nutzer entscheidet, welcher Stand gilt.

### 3. Bindung schreiben

**A — Repo**
1. `docs/projekt-kontext.md` aus `projekt-kontext-template.md` (dieser Ordner) befüllen —
   inklusive Tabelle „Arbeitsplätze" mit der Zeile aus 2f. Existiert die Datei bereits: nur
   die Felder Projekt, Standard-Log-Ziel, Wiki, Datenordner, Repo, Master, „Eingerichtet am"
   und die Zeile des aktuellen Rechners aktualisieren bzw. ergänzen; alle übrigen Inhalte
   (andere Rechner, Projektspezifisches) behalten; Änderung dem Nutzer zeigen.
   Ist das Repo öffentlich und sollen lokale Pfade nicht hinein: Tabelle „Arbeitsplätze"
   im Repo-Spiegel durch den Verweis „siehe Master bzw. `projekt-kontext.md` im
   Datenordner" ersetzen — der Nutzer entscheidet.
2. `.claude/project-context/wiki.md` aus `wiki-kontext-template.md` — nur wenn es eine
   Wiki-Wurzelseite gibt. Existiert die Datei: Seiten-ID und Titel aktualisieren.

**B — Claude-Projekt**
1. Projekt-Doc `claude/projekt-kontext.md` mit demselben Template schreiben
   (Feld „Arbeitskontext": Claude-Projekt; Master: diese Doc). Existiert sie: wie in A mergen.
2. Projektanweisungen: `projektanweisungen-cowork.md` (dieser Ordner) mit den Werten
   befüllen und dem Nutzer als Text zum Einfügen geben — Projektanweisungen können nicht
   per Werkzeug gesetzt werden. Hat das Projekt bereits Anweisungen: nur den Abschnitt
   „Projekt-Manager-Anbindung" ergänzen, Rest unverändert lassen.

**A und B — Datenordner-Spiegel** (entfällt ohne Datenordner)
1. `projekt-kontext.md` im Datenordner dieses Rechners mit dem vollständigen Inhalt des
   Masters schreiben (B: `device_request_folder_access` für den Datenordner, dann
   `device_commit_files`). Über Nextcloud erreicht der Spiegel alle anderen Rechner.
2. Existiert dort bereits eine `projekt-kontext.md`: mit dem Master vergleichen. Identisch →
   nichts tun. Abweichend → Unterschiede zeigen; der Nutzer entscheidet, welcher Stand der
   neuere ist (in der Regel der Master; ein Spiegel kann neuer sein, wenn er auf einem
   anderen Rechner zuletzt ergänzt wurde). Danach Master und Spiegel angleichen.
3. A mit Claude-Projekt als Master: `docs/projekt-kontext.md` ist ebenfalls Spiegel — gleicher
   Abgleich; die Projekt-Doc kann aus Claude Code nicht gelesen werden, dann gilt der
   Datenordner-Spiegel als Referenz und die Abweichung wird im Abschluss genannt.

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
<li>Datenordner: <Name in Nextcloud>; Repo: <Remote></li>   <!-- oder: kein Datenordner / kein Repo -->
<li>Arbeitsplatz: <Gerätename> (<Bemerkung>) — Datenordner <Pfad>, Repo <Pfad></li>
<li>Master der Bindung: <Projekt-Doc des Claude-Projekts „…" | docs/projekt-kontext.md></li>
<li>Skills: pm-workflow-skills <Version>[, dev-testing-skills <Version>]</li>  <!-- B: Account-Skill pm-workflow <Vorlagenversion> -->
</ul>
```

Ist das Standard-Log-Ziel nicht das Projekt: denselben Kommentar auch dort. Das ist der
erste Eintrag der Log-Pflicht und wird ohne weitere Rückfrage geschrieben — die
Bestätigung des Ablaufs war Schritt 2. Versionen aus den `plugin.json` bzw. der
Vorlagenzeile des Skills lesen, nicht raten. Der Kommentar ist zugleich der Steckbrief des
Projekts im gemeinsamen Gedächtnis: welche Kontexte und Rechner angebunden sind. Beim
Kurzablauf „Nur Arbeitsplatz ergänzen" nur die Arbeitsplatz-Zeile als Kommentar.

### 6. Verifikation und Abschluss

- Alle geschriebenen Dateien nochmals lesen: Platzhalter vollständig ersetzt, JSON gültig,
  Pfade vorhanden.
- Master und Spiegel inhaltlich identisch (Datenordner, ggf. Repo).
- `get_reference_context("PROJ-<id>")` (oder `list_support_for_parent`, falls vorhanden):
  Startkommentar sichtbar.
- Ergebnis nach dem Schema unten berichten, inklusive der offenen Handgriffe.

---

## Regeln

- Keine IDs erfinden. Jede ID ist per MCP verifiziert **und** vom Nutzer bestätigt, bevor
  sie in eine Datei geschrieben wird.
- Keine Pfade erfinden. Jeder Pfad ist auf dem aktuellen Rechner geprüft; Pfade eines
  anderen Rechners werden nie übernommen. Schlüssel jeder Arbeitsplatz-Zeile ist der
  Gerätename.
- Master vor Spiegel: Änderungen an der Bindung zuerst im Master, dann in den Spiegeln.
  Ein Spiegel wird nie stillschweigend in den Master zurückgeschrieben — Abweichung zeigen,
  Nutzer entscheidet.
- Bestehende Dateien mergen, nie stillschweigend überschreiben; Änderungen zeigen.
- Nichts löschen ohne Bestätigung.
- Ordnerzugriff (Cowork) nur anfordern, wenn der Schritt ihn braucht — jede Anfrage
  kostet eine Bestätigung des Nutzers.
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
| Arbeitsplatz | Gerätename, Datenordner-Pfad, Repo-Pfad — oder „ergänzt" beim Kurzablauf |
| Master / Spiegel | Master (Ort), Spiegel geschrieben / abgeglichen / abweichend |
| Dateien | angelegt / geändert, mit Pfad |
| Skills | installiert (Versionen) / vorgeschlagen / Befehle für den Nutzer |
| Startkommentar | geschrieben an … / Blocker |
| Offen | z. B. Projektanweisungen einfügen (B), `wikiPageId` des Projekts in der App setzen (per MCP nicht setzbar), Commit der neuen Dateien (A), `TODO`s in `tech-stack.md`, Zeile für den zweiten Rechner beim ersten Aufruf dort |
