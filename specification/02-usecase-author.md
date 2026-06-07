# Use Case Author

Erstellt und pflegt Use Cases aus Anwendersicht.
Use Cases beschreiben konkrete Nutzerinteraktionen — sie sind Implementierungshilfe und Testbasis.

---

## Trigger

- Neuer Use Case soll angelegt werden
- Bestehender Use Case soll überarbeitet werden
- Use Cases passen nicht mehr zu den Feature-Regeln

---

## Pflichtabschnitte eines Use Cases

1. **Ziel** — Was will der Anwender erreichen? Ein Satz.
2. **Auslöser** — Was startet diesen Use Case?
3. **Voraussetzungen** — Welche Bedingungen müssen vor dem Start erfüllt sein?
4. **Hauptablauf** — Schritt-für-Schritt-Beschreibung des Normalfalls.
5. **Alternativabläufe** — Zulässige Abweichungen vom Hauptablauf.
6. **Fehlerfälle** — Was passiert wenn etwas schiefläuft? Mit konkreter Systemreaktion.
7. **Nachbedingungen** — Welcher Zustand gilt nach dem erfolgreichen Abschluss?

---

## Ablauf

1. Übergeordnetes Feature via MCP laden (`get_feature`) — Feature-Regeln sind maßgeblich.
2. Bestehenden Use Case via MCP laden (`get_use_case`) wenn vorhanden.
3. Hauptablauf aus Anwenderperspektive schreiben — nicht aus Systemperspektive.
4. Alternativabläufe für alle fachlich dokumentierten Varianten ergänzen.
5. Fehlerfälle aus den Feature-Regeln ableiten — mit konkreter Systemreaktion.
6. Abweichungen zwischen Use Case und Feature-Regeln dokumentieren.
7. Use Case via MCP speichern (`update_use_case` oder MCP-Äquivalent).

---

## Schreibregeln

- Abläufe in Anwendersprache — "Der Anwender wählt..." nicht "Das System setzt das Flag..."
- Fehlerfälle mit konkreter Reaktion: "Das System zeigt eine Fehlermeldung: Datum liegt in der Vergangenheit"
- Keine Architekturdetails, kein Datenbankdesign, keine API-Beschreibungen
- Schritte atomisch — ein Schritt = eine Aktion
- Fehlerfälle vollständig — unvollständige Fehlerfälle machen Use Cases als Testbasis wertlos

---

## Abnahmekriterien

- Alle Pflichtabschnitte vorhanden
- Ablauf nachvollziehbar für Anwender ohne Entwicklerhintergrund
- Fehlerfälle mit konkreter Systemreaktion dokumentiert
- Verknüpfung zum übergeordneten Feature vorhanden
- Kein Widerspruch zu den Feature-Regeln
