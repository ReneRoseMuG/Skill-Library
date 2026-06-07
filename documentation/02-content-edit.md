# Inhaltsredaktion

Schreibt und überarbeitet Doku-Inhalte für Features, Use Cases und Wiki-Artikel.
Quellen: Feature- und Use-Case-Daten via MCP, ergänzt durch Code-Verifikation.

---

## Zweck

Übersetzt Spezifikationen und Use Cases in verständliche Anwenderdokumentation.
Der Leser ist ein Anwender — kein Entwickler, kein Datenbankadministrator.

---

## Ablauf

### 1. Quellen laden
```
get_feature(<Feature-ID>)
get_use_case(<Use-Case-ID>)
```
Verwandte Features identifizieren und bei Bedarf nachladen.

### 2. Code-Verifikation (wenn nötig)
Prüfen ob die Doku durch den tatsächlichen Code gestützt wird:
- UI-Pfade: existieren die beschriebenen Menüpunkte und Dialoge?
- Rollen: stimmen beschriebene Berechtigungen mit der Implementierung überein?
- Regeln: werden alle beschriebenen Regeln tatsächlich durchgesetzt?
- Sonderfälle: sind beschriebene Ausnahmen tatsächlich implementiert?

### 3. Inhalte schreiben

**Feature-Artikel:**
- Einstieg: Was kann der Anwender damit tun? (1-2 Sätze)
- Schritt-für-Schritt-Anleitung für den Hauptablauf
- Wichtige Regeln und Einschränkungen
- Häufige Fehlersituationen und Lösungen
- Verwandte Themen

**Use-Case-Artikel:**
- Ausgangssituation und Ziel
- Vollständiger Ablauf als nummerierte Schritte
- Alternativwege mit Bedingungen
- Was bei Fehlern passiert und was zu tun ist

### 4. Widersprüche dokumentieren
Konflikte zwischen Feature-Doku und tatsächlichem Code immer explizit benennen.
Nie stillschweigend die falsche Quelle bevorzugen.

---

## Schreibregeln

- Direkte Anrede: "Sie klicken auf..." oder "Klicken Sie auf..."
- Aktive Formulierungen: "Das System speichert..." nicht "Die Daten werden gespeichert"
- Konkrete Labels aus der echten UI — nicht abstrakte Beschreibungen
- Fehlermeldungen im Wortlaut zitieren wenn bekannt
- Keine technischen Interna ohne direkten Nutzerbezug
- Abschnitte kurz — maximal 3-4 Sätze Fließtext, dann Aufzählung

---

## Ergebnis

- Fertige Doku-Inhalte bereit für Stil-Prüfung und Veröffentlichung
- Liste der Code-Verifikationsbefunde (Bestätigt / Abweichung / Nicht prüfbar)
- Dokumentierte Widersprüche zwischen Quellen
