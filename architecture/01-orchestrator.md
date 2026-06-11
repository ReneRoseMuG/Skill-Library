# Architektur- und Design-Orchestrator

Einstiegspunkt für mehrstufige Architektur- und Designaufträge.
Bestimmt die Auftragsart, aktiviert nur die erforderlichen Skills und stellt sicher,
dass vor einer Implementierung eine belastbare Bestands- und Regelanalyse vorliegt.

---

## Trigger

- Neues Feature oder neue UI-Funktion
- Bugfix mit struktureller oder visueller Änderung
- Neue oder geänderte Komponente
- Änderung eines Nutzerablaufs
- Refactoring oder Vereinheitlichung
- Architektur- oder Designaudit
- Wiederkehrender Drift an vergleichbaren Stellen

## Nicht-Trigger

- Reine Textänderung ohne Code- oder UI-Auswirkung
- Mechanische Formatierung mit eindeutig begrenztem Umfang
- Ausdrücklich isolierter Analyseauftrag wenn bereits klar ist, welcher Spezialisierungsskill zuständig ist

---

## Auftragsarten

| Art | Beschreibung |
|---|---|
| Analyse | Keine Codeänderung — nur verstehen |
| Entscheidung | Analyse + Umsetzungsentscheidung, aber keine Implementierung |
| Implementierung | Vollständiger Ablauf: Analyse → Entscheidung → Umsetzung → Prüfung |
| Audit | Bestandsaufnahme und Driftbewertung ohne automatische Bereinigung |
| Vereinheitlichung | Geplante Beseitigung paralleler Lösungen |

---

## Pflichtablauf

1. Auftragsart, Ziel und zulässige Änderungen bestimmen.
2. Änderungsreichweite zunächst eng abgrenzen.
3. Graphify-Protokoll anwenden (`core/graphify-protocol.md`).
4. Bestandsanalyse durchführen (`02-bestandsanalyse.md`).
5. Relevante Regeln ermitteln (`03-designregeln.md`) — Architektur-, Daten- und Designregeln gleichermaßen.
6. Wiederverwendungs- und Umsetzungsentscheidung treffen (`04-umsetzungsentscheidung.md`).
7. Bei Implementierungsauftrag: umsetzen (`05-implementierung.md`).
8. Konformitätsprüfung durchführen (`06-konformitaetspruefung.md`).
9. Ergebnisse konsolidieren und eindeutiges Abschlussurteil liefern.

Bei Analyse- oder Auditaufträgen: Schritte 6–8 entfallen.

---

## Leitplanken

- Keine Detailanalyse doppelt durchführen wenn ein nachgelagerter Skill sie vollständig übernimmt.
- Keine vorhandene Implementierung automatisch als Referenz behandeln.
- Keine neue Komponente allein deshalb erlauben weil sie lokal schneller zu bauen ist.
- Ein reiner Analyse- oder Auditauftrag verändert keinen Produktivcode.
- Fehlende Werkzeuge sind kein Blocker — klassische Repository-Suche reicht für eine belastbare Analyse.

---

## Abbruchbedingungen

- Gleichrangige Quellen verlangen unvereinbare Architektur oder UI-Verhalten.
- Zuständige Komponenten oder geltende Regeln sind ungeklärt und die Unsicherheit beeinflusst die Lösung wesentlich.
- Scope widerspricht dokumentierten Architekturentscheidungen.

Bei Abbruch: Blocker und offene Fragen dokumentieren — keine Schätzung als Entscheidung ausgeben.
