---
name: specification
description: >
  Feature- und Use-Case-Redaktion im Projekt-Manager-Wiki.
  Verwenden wenn Features oder Use Cases geschrieben, überarbeitet, geprüft oder
  aus Anwendersicht aufbereitet werden sollen.
  Auslöser: "schreibe Feature", "überarbeite Use Case", "Feature aus Anwendersicht",
  "Use Cases für Feature X", "redaktionell aufbereiten", "Spec prüfen",
  "Feature-Beschreibung", "UC-Review", Spezifikation einer Feature- oder Use-Case-Seite.
---

# Spezifikationsredaktion — Projekt Manager

Datenquelle und Speicherziel sind Wiki-Seiten im Projekt Manager. Die früheren Domänenobjekte
Feature und Use Case werden nicht mehr verwendet. Ablage, Nummerierung, Werkzeuge und Umgang mit
alten FEAT-/UC-Referenzen: `${CLAUDE_PLUGIN_ROOT}/reference/wiki-ablage.md` — vor der ersten
Schreiboperation lesen.

## Auftragsart

| Art | Operationen |
|---|---|
| Feature schreiben/überarbeiten | `get_wiki_page` → bearbeiten → `update_wiki_page` (neu: `create_wiki_page`) |
| Use Case schreiben/überarbeiten | `get_wiki_page` → bearbeiten → `update_wiki_page` (neu: `create_wiki_page` unter der Sammelseite) |
| Audit / Review | Feature-Seite + zugehörige Use-Case-Seiten lesen — kein Speichern |

## Feature schreiben

**Pflichtabschnitte:**
1. Ziel — was erreicht der Anwender? (1 Satz)
2. Nutzen — konkreter Mehrwert, kein Tech-Jargon
3. Beschreibung — Fließtext + Aufzählungen gemischt
4. Regeln — nummeriert, konkret und testbar formuliert
5. Ausnahmen — explizit benannt, nicht im Text versteckt
6. Verwandte Features — via MCP laden wenn betroffen
7. Use Cases — Referenzliste

**Schreibregeln:**
- Anwendersprache — kein Datenbankdesign, keine Variablennamen, keine API-Details
- Regeln konkret: "Ein Termin kann nicht in der Vergangenheit liegen" — nicht "Datum wird validiert"
- Für fachkundige Anwender ohne Entwicklerhintergrund verständlich

## Use Case schreiben

Use Cases beschreiben konkrete Nutzerinteraktionen — sie sind Implementierungshilfe und Testbasis, nicht nur Beschreibung.

**Pflichtabschnitte** (nur die tatsächlich relevanten verwenden):
1. Kurzbeschreibung — Ziel, auslösender Vorgang, erwartetes Ergebnis
2. Ziel — fachlicher Nutzen für den Anwender
3. Beteiligte Rollen — nur bei abweichenden Rechten eigens erläutern
4. Voraussetzungen — Bedingungen vor Start, **nicht** mit Ablaufschritten vermischen
5. Auslöser — Aktion oder Ereignis, das den Use Case startet
6. Regulärer Ablauf — Standardfall, je Schritt Aktion + Prüfung + Zwischenergebnis
7. Entscheidungen und Rückfragen — Anlass, Auswahl, Folge je Auswahl, Abbruchverhalten
8. Alternativabläufe — zulässige Varianten mit eigener Zwischenüberschrift
9. Konflikte und Fehlerfälle — Ursache, betroffene Regel, **konkrete Systemreaktion im Wortlaut**, Datenzustand nach Abbruch
10. Ergebnis (Nachbedingung) — fachlicher Zustand nach erfolgreichem Abschluss
11. Unveränderte Daten und Beziehungen — nur wenn ausdrücklich klarzustellen
12. Fachliche Regeln — müssen mit den Feature-Regeln übereinstimmen
13. Sonderfälle — seltene zulässige Abweichungen
14. Verwandte Themen — immer am Ende, mit Referenz, Titel, Beziehungstyp, Begründung

**Schreibregeln:**
- Abläufe in Anwendersprache: "Der Anwender wählt …" — nicht "Das System setzt das Flag …"
- Ein Schritt = eine Aktion
- Fehlerfälle vollständig und mit konkreter Reaktion — unvollständige Fehlerfälle machen Use Cases als Testbasis wertlos
- Kein Widerspruch zu den Feature-Regeln; Abweichungen ausdrücklich kennzeichnen statt glätten

**Überarbeitung ist verlustfrei:** keine Zusammenfassung, kein Neuschrieb. Verändert werden dürfen Satzbau, Wortwahl, Reihenfolge und Gliederung — nie der fachliche Bedeutungsumfang. Vor der Redaktion ein Aussageinventar erstellen und die neue Fassung dagegen prüfen.

Vollständiges Verfahren inkl. Aussageinventar, Beziehungstypen, Redaktionsnachweis und Abnahmekriterien: `${CLAUDE_PLUGIN_ROOT}/reference/specification/02-usecase-author.md` lesen.

## Audit / Review

Prüft Features und Use Cases auf Qualität, Konsistenz und Vollständigkeit. Analysiert — erstellt oder verändert nichts, außer explizit beauftragt.

Prüfpunkte:
- Alle Pflichtabschnitte vorhanden und ausgefüllt?
- Regeln konkret und testbar formuliert (keine vagen Aussagen)?
- Verwandte Features/Use Cases korrekt verknüpft?
- Widersprüche zwischen Feature und seinen Use Cases?
- Fehlerfälle mit konkreter Systemreaktion dokumentiert?
- Decken die Use Cases die Feature-Regeln vollständig ab?

**Ergebnis:** Freigegeben | Freigegeben mit Hinweisen | Überarbeitung erforderlich — jeweils mit konkreter Fundstelle und Empfehlung.

Seiteninhalte sind HTML. Beim Ändern zuerst `get_wiki_page` lesen und den vollständigen neuen Inhalt übergeben — `update_wiki_page` ersetzt, es ergänzt nicht. Tabellen ausschließlich als `<table>`.

Quelle (Ebene 1): Skill Library, Plugin `pm-workflow-skills`, `reference/specification/` — dort zuerst ändern, dann hier nachziehen.
