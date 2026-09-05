# Planungs-Gate

Gemeinsames Muster für das Planungs-Gate, das jedes Repo vor jeder Planung
anwendet (Feature, Fix, Audit, Test, Migration, API, UI, Architekturentscheidung).
Plattformneutral — Repos instantiieren daraus ihren eigenen `planungsleitplanken`-
Skill mit ihren eigenen Schichten, Datenquellen und Testkommandos.

Die Projektverfassung des Repos (`agents.md`/`CLAUDE.md`) bleibt die verbindliche
Quelle. Bei Widersprüchen zwischen diesem Dokument und der Projektverfassung gilt
die Projektverfassung; Abweichungen kurz benennen.

## Pflichtablauf

1. Auftrag gemäß der Auftragsklassifikation der Projektverfassung einordnen
2. Aktuellen Branch und Working Tree prüfen wenn Änderungen möglich sind
3. Bei Code-Bezug zuerst vorhandene Analysewerkzeuge (z. B. Graphify) nutzen, dann nur benötigte Repo-Abschnitte lesen — erst bei Bedarf erweitern
4. Betroffene Domänen, Schichten, Dateien, API, Datenmodell, Frontend-State, Tests, Logs und Abnahmekriterien identifizieren
5. Explizit entscheiden ob Auth, Rollen, Permissions, Migrationen, Fixtures und UI-Regeln betroffen sind
6. Annahmen und Blocker benennen — keine stillen Architektur-, Produkt- oder Scope-Entscheidungen. Mehrdeutige Aufträge mit allen plausiblen Interpretationen offenlegen statt still eine zu wählen; gibt es einen einfacheren Weg, ihn vorschlagen und begründet widersprechen
7. Beobachtbare Erfolgskriterien vorab festlegen — Auftrag in prüfbare Ziele übersetzen (z. B. „Bug fixen" → Test, der ihn reproduziert, dann grün; „Validierung" → Tests für ungültige Eingaben, dann grün)
8. Plan proportional zur Auftragsklasse — Sicherheit, Tests, Datenmigration nie weglassen wenn relevant

## Pflichtfragen vor jedem Plan

- Welche Domäne und welche Schichten sind betroffen?
- Welche Routen, Services, Repositories, Shared Types, Migrationen, Hooks, Komponenten, Seiten?
- Auth, Rollen, Permissions oder UI-Gating betroffen?
- UI-Visuals, Layout, Styling betroffen → projekteigenen Design-Leitfaden laden, falls vorhanden
- DB-Migration, Fixtures oder Seed-Änderung nötig?
- Skalierung/Zugriffsmuster: realistische Datenmenge, DB-Roundtrips je Anfrage, N+1-Risiko?
- Was bleibt bewusst unverändert?
- Was kann kaputtgehen — wie wird das Risiko begrenzt?
- Woran ist Erfolg beobachtbar — welcher Test oder welche Prüfung beweist die Umsetzung?

## Plan-Checkliste

- [ ] Auftragsklasse
- [ ] Branch-Strategie (nur bei explizitem Wunsch)
- [ ] Gelesene Dokumente und warum sie ausreichen
- [ ] Betroffene Domäne und Schichten
- [ ] Auth/Rollen/Permissions betroffen?
- [ ] DB-Migration nötig?
- [ ] Skalierung/N+1 geprüft?
- [ ] UI/Design-Leitfaden relevant?
- [ ] Was bleibt unverändert?
- [ ] Beobachtbare Erfolgskriterien / Verifikationsweg benannt
- [ ] Risiken und Schadenspotential

## Abnahmekriterien

**Definition of Done:**
- Geplanter Scope implementiert oder Blocker dokumentiert
- Keine unverwandten Refactorings oder Scope-Erweiterungen
- Migrationen, Seed, Fixtures und Shared Types enthalten wenn betroffen
- Auth-, Rollen- und Permission-Effekte implementiert und getestet
- Tests hinzugefügt oder fehlende Abdeckung als Blocker dokumentiert
- Abschlusskommentar/Log gemäß Logpflicht der Projektverfassung

**Plan gilt als akzeptabel wenn erkennbar ist:**
- Was sich ändert
- Warum jede betroffene Schicht angefasst wird
- Welche Workflows betroffen oder bewusst unberührt sind
- Welche Risiken am stärksten wiegen
- Wie die Änderung verifiziert wird

## Hard-Stop-Bedingungen

Abbrechen und Blocker dokumentieren wenn:
- Scope widerspricht der Projektverfassung
- Architekturentscheidung nicht spezifiziert und keine sichere lokale Konvention vorhanden
- Plan würde stille unverwandte Nutzeränderungen entfernen oder überschreiben
- Benötigte Task-Datei oder Schema-Quelle fehlt und alle abhängigen Schritte brauchen sie

## Projektspezifisch

Repo-eigene Schichtnamen, Datenquellen, Git-Kurzkommandos, Auth-/Permission-Mapping,
Testkommandos und Design-Leitfaden-Verweise gehören in den projekteigenen
`planungsleitplanken`-Skill, nicht in dieses Ebene-1-Dokument.
