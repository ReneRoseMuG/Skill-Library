---
name: test-entwurfsleitplanken
description: >
  Testentwurfs-Gate für dieses Repository. IMMER verwenden wenn Tests
  geplant, geschrieben, geändert, bewertet oder ausgeführt werden. Auslöser:
  Testsuite, Testabdeckung, Integrationstest, E2E, Fixtures, Testdaten,
  Datenbankisolation, Mock-Entscheidung, Berechtigungstest, Abnahmekriterien.
  Gilt auch bei Code-Änderungen die bestehende Tests berühren.
---

# Test-Entwurfsleitplanken

`agents.md`/`CLAUDE.md` bleibt die verbindliche Quelle. Bei Widersprüchen gilt die
Projektverfassung.

Konkrete Isolationsmechanismen, Testkommandos und Safety-Gates dieses Repos stehen
in `.claude/project-context/tech-stack.md`, Abschnitt „Tests" — dort nachschlagen
statt zu raten.

## Grundsatz

Ein Test muss eine fachliche oder technische Funktion beweisen. Aussagekraft und Sicherungscharakter haben Vorrang vor Bequemlichkeit und kurzer Implementierungszeit.

Ein Test ist nur tragfähig wenn er:
- einen echten Ausgangszustand aufbaut
- eine reale Aktion ausführt
- ein beobachtbares Ergebnis prüft
- relevante Negativ- oder Gegenbeispiele enthält
- keine produktiven Daten, Uploads, Inhalte oder Backups berührt
- seine Testebene ehrlich benennt

## Schutzregeln

- In einer Code-Test-Fix-Session keinen Produktivcode ändern, der nicht ausdrücklich beauftragt ist.
- Keine vollständigen oder breiten Testläufe ohne ausdrückliche Beauftragung — standardmäßig nur die direkt betroffenen Tests.
- Falls in `tech-stack.md` ein Safety Gate benannt ist (z. B. Testmodus-Umgebungsvariable, DB-Allowlist, Guard-Funktionen): vor jeder Testausführung prüfen.

## Pflichtablauf vor dem Testentwurf

Bei Code-Bezug zuerst Graphify anwenden (`graphify query` für den geänderten Bereich, `graphify path` zur Persistenz/zum Service), falls laut `tech-stack.md` verfügbar, dann:

1. Testebene festlegen: Unit, Integration oder Browser/E2E
2. Bei Oberflächenkomponenten zusätzlich die Testumgebung festlegen: mit oder ohne Dokumentmodell. Ohne Dokumentmodell sind nur erstes Rendern, abgeleitete Werte und weitergereichte Eigenschaften prüfbar; sobald das Verhalten eine Nutzeraktion voraussetzt — Klick, Eingabe, Auswahl, Effekt, bedingtes Nachladen, Meldung nach einer Aktion — ist die Umgebung mit Dokumentmodell zwingend. Welche Umgebungen das Projekt kennt und wie sie aktiviert werden, steht in `tech-stack.md`, Abschnitt „Tests".
3. Zu beweisendes Verhalten in einem Satz: Ausgangszustand → Aktion → erwartetes Ergebnis
4. Echte Objekte und Daten bestimmen die für den Beweis nötig sind
5. Mock-Entscheidung treffen und begründen
6. Isolation festlegen gemäß `tech-stack.md` (Temp-DB, In-Memory-DB, benannte Test-DB, `.runtime`/`os.tmpdir()`)
7. Positive Fälle, Negativfälle, Berechtigungsfälle und Konfliktfälle benennen
8. Prüfen ob der Test nur Sichtbarkeit oder Implementierungsdetails testet — falls ja, Testziel verschärfen oder verwerfen
9. Bei Oberflächentests prüfen ob die Bedienelemente selbst gemockt wurden — falls ja, prüft der Test nur noch die Platzhalter und ist zu verwerfen

## Mock-Regeln

### Unit-Tests
Mocks erlaubt für: externe Seiteneffekte (Netzwerk, Uhrzeit, Zufall, Dateizugriff), klar begrenzte Collaborators, Fehlerdoubles für seltene Fehlerpfade. Keine Wunschzustände vortäuschen die im echten System nicht entstehen können.

Bei Oberflächenkomponenten verläuft die Grenze zwischen Datenschicht und Bedienoberfläche: Netzwerkaufrufe, geteilte Caches und Benachrichtigungen dürfen ersetzt werden, Dialoge, Eingabefelder und Schaltflächen nicht. Werden Bedienelemente durch Platzhalter ersetzt, prüft der Test am Ende nur noch die Platzhalter. Wiederkehrende Rüstarbeit — Provider, fehlende Browser-Schnittstellen der Testumgebung, Vorbelegung geteilter Zustände — gehört in einen gemeinsamen Testhelfer, nicht in jede Testdatei.

### Integrationstests
Keine Mocks. Echte Objekte, echte Daten, echte Services, Repositories, DB-Clients, Auth-Hooks und API-Antworten. Falls das Repo einen zentralen Testdaten-Einstieg oder eine Test-App-Factory kennt (siehe `tech-stack.md`), immer darüber.

Einzige Ausnahme: technisch nötiger Parameter ohne nachweislichen Einfluss auf die geprüfte Funktion — muss im Testkommentar explizit stehen.

Ist ein Mock unvermeidlich → kein Integrationstest schreiben, Blocker dokumentieren und echte Testinfrastruktur herstellen.

### Browser/E2E-Tests
Echte Browserinteraktion, echte Routen, echte API-Antworten aus isolierter Testinstanz, echte Testdaten. Keine gestubbten UI-Hooks, API-Clients oder Berechtigungen.

## Echte Daten und Isolation

**Datenbank:**
- Nie produktive Datenbank oder produktive Datendateien (Pfade siehe „Verbotene Pfade in Tests" in `tech-stack.md`)
- Isolationsmechanismus aus `tech-stack.md` verwenden (Temp-DB, In-Memory-DB, benannte Test-DB, `.runtime`)
- Schema/Migrationen passend zum Produktivcode initialisieren
- Zuverlässiges Cleanup vor/nach dem Test
- Gegenbeispiele explizit anlegen — nicht nur positive Treffer prüfen

**Dateisystem:**
- Echtes Dateisystem, eindeutiger Temp-Root pro Test/Suite
- Nie produktive Upload-, Content- oder Backup-Pfade (siehe `tech-stack.md`)
- Dateien, Verzeichnisse, Kollisionen und Löschpfade real prüfen
- Robustes Cleanup in `afterEach`/`afterAll`

## Aussagekräftige Assertions

**Gut:** HTTP-Status + Fehlerformat + persistierter DB-Zustand, erzeugte/geänderte/gelöschte Dateien oder Datensätze in der Test-Isolation, Rollen-/Permission-Wirkung mit echten Usern und Sessions, Versionskonflikte mit echter aktueller und veralteter Version (falls das Projekt Versionierung verwendet).

**Schwach (vermeiden):**
- Nur Element vorhanden oder Button sichtbar
- Nur Mock-Aufruf ausgelöst
- Snapshot ohne fachliche Aussage
- Filtertest nur mit positiven Treffern
- Permission-Test mit gestubbtem Auth
- Integrationstest mit gemocktem Repository oder Service
- Testdaten die einen fachlich unmöglichen Zustand herstellen

## Datengetriebene Tests

Mengen, Filter, Suchen, Sortierung, Berechtigungsgrenzen und Statuslogik brauchen immer Gegenbeispiele:
- Datensätze die enthalten sein müssen
- Datensätze die ausgeschlossen sein müssen
- Einen Randfall (leer, anderer Status, andere Rolle, anderer Owner, anderer Zeitraum)
- Assertion auf die komplette Ergebnismenge — nicht nur auf einzelne Elemente

## Auth, Rollen und Permissions

Mindestpflicht für geschützte Workflows:
- Erlaubter Zugriff mit passender Permission
- Abgelehnter Zugriff ohne ausreichende Permission
- Bei Schreiboperationen: Negativfall mit unzureichender Rolle
- Bei UI-Flows: unzulässige Aktionen nicht angeboten oder serverseitig `FORBIDDEN`

Frontend-Gating ersetzt nie die API-Prüfung.

## Pflichtkommentar in Testdateien

```ts
/**
 * Test Scope:
 *
 * Test-Ebene:
 * - <Unit | Integration | Browser/E2E>
 *
 * Realitätsgrad:
 * - <echte App/DB/FS/API/User/Rollen oder begründete Abgrenzung>
 *
 * Mock-Entscheidung:
 * - <keine Mocks | Unit-Mocks: ... | Ausnahme ohne Einfluss: ...>
 *
 * Isolation:
 * - <Isolationsmechanismus aus tech-stack.md>
 *
 * Abgedeckte Regeln:
 * - <Regel 1>
 *
 * Fehlerfälle:
 * - <Fehlerfall 1>
 *
 * Ziel:
 * <Kurzbeschreibung der Absicherung>
 *
 * Rot-Probe: <was absichtlich gebrochen wurde>
 * Ergebnis: <welcher Test daraufhin fehlschlug, und mit welcher Meldung>
 */
```

**Rot-Probe statt Selbsteinschätzung.** Für jede neu angelegte oder wesentlich geänderte
**fachliche** Testdatei gilt: Die geprüfte Regel wird im Produktivcode einmal absichtlich
gebrochen, der rote Lauf beobachtet und die Änderung zurückgenommen. Was gebrochen wurde und was
daraufhin fehlschlug, steht in den zwei Zeilen `Rot-Probe:` und `Ergebnis:`.

Der Grund: Eine Behauptung über die eigene Testqualität ist kein Beweis — wer nachlässig testet,
schreibt auch einen nachlässigen Nachweis. Die Probe beantwortet dieselbe Frage empirisch und
schließt zugleich den False-Positive-Fall ein: Ein Test, der nur grün ist, weil vorhandene Daten
zufällig passen, bleibt auch bei gebrochener Regel grün — dann schlägt die Probe fehl und der
Mangel fällt auf.

**Reine Smoke- und Strukturtests sind ausgenommen**, weil es dort keine Fachregel zu brechen gibt.
Sie tragen stattdessen eine Zeile, die benennt, was sie *nicht* beweisen, zum Beispiel:
`Smoke-Test: prüft nur, dass die Seite ohne Fehler rendert — keine Aussage über Datenrichtigkeit
oder Rollenwirkung.` Damit ist die Kennzeichnungspflicht für Smoke-Tests erfüllt.

Ob das Repo den Nachweis maschinell absichert und wie, steht in `tech-stack.md`. Eine solche
Prüfung kann nur den Bestand schützen — kein Werkzeug kann entscheiden, ob eine Testdatei
fachlich ist oder ein Smoke-Test.

## Plan-Checkliste für Tests

Jeder Testplan benennt konkret:
- Welches Verhalten bewiesen wird
- Welche Testebene verwendet wird
- Welche echten Objekte und Daten beteiligt sind
- Welche Mocks nicht verwendet werden dürfen
- Welche Negativ- und Randfälle nötig sind
- Wie DB- oder FS-Isolation hergestellt wird
- Welche Rollen- und Permission-Fälle betroffen sind
- Welches beobachtbare Ergebnis die Abnahme trägt

Wenn diese Punkte nicht beantwortbar sind: nicht raten — Blocker dokumentieren.

Quelle (Ebene 1): Skill Library `dev-testing/testing/01-test-skill.md` + `dev-testing/core/graphify-protocol.md` — dort zuerst ändern, dann hier nachziehen.
