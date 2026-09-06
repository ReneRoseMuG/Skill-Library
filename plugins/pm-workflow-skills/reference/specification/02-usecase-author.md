# Use Case Author

Erstellt und pflegt Use Cases aus Anwendersicht.
Use Cases beschreiben konkrete Nutzerinteraktionen — sie sind Implementierungshilfe und Testbasis.

---

## Trigger

- Neuer Use Case soll angelegt werden
- Bestehender Use Case soll überarbeitet werden
- Use Cases passen nicht mehr zu den Feature-Regeln

---

## Grundprinzip bei Überarbeitung: verlustfrei

Eine Überarbeitung ist **keine Zusammenfassung und kein Neuschrieb**.

- Verändert werden dürfen: Satzbau, Wortwahl, Reihenfolge, Überschriften, Aufteilung in Fließtext/Listen.
- **Niemals** verändert wird der fachliche Bedeutungsumfang: Voraussetzungen, Abläufe, Entscheidungen, Regeln, Ausnahmen, Rollenunterschiede, Zustände, Folgen.
- Eine Aussage gilt nur als erhalten, wenn sie im neuen Text **ausdrücklich** erkennbar ist.
- Ähnlich klingende Schritte/Regeln nicht zusammenführen, wenn sie unterschiedliche Voraussetzungen oder Folgen haben.
- Bei Zweifeln bleibt die genauere Aussage erhalten.

---

## Pflichtabschnitte eines Use Cases

Nur tatsächlich relevante Abschnitte verwenden.

1. **Kurzbeschreibung** — Ziel des Anwenders, auslösender Vorgang, erwartetes Ergebnis. Verschweigt keine wesentlichen Voraussetzungen, Ausnahmen oder Folgen.
2. **Ziel** — Was will der Anwender erreichen, welcher fachliche Nutzen. Ein bis wenige Sätze.
3. **Beteiligte Rollen** — Wer führt aus oder ist von Folgen betroffen. Eigene Erläuterung nur bei abweichenden Rechten/Aufgaben/Entscheidungen.
4. **Voraussetzungen** — Bedingungen vor Start (Daten, zulässige Zustände, Berechtigungen, zeitliche/vorausgesetzte Schritte). Nicht mit den Ablaufschritten vermischen.
5. **Auslöser** — Aktion oder Ereignis, durch das der Use Case beginnt.
6. **Regulärer Ablauf** — Erwarteter Standardfall, nachvollziehbare Reihenfolge. Je Schritt: was Anwender/System tut, welche Prüfung erfolgt, welches Zwischenergebnis entsteht. Nummerierte Liste nur, wenn sie einen echten Ablauf wiedergibt.
7. **Entscheidungen und Rückfragen** — Dialoge/Warnungen/bewusste Entscheidungen: Anlass, angezeigte Information, Auswahlmöglichkeiten, Folge jeder Auswahl, Verhalten bei Abbruch. Entfällt ohne Entscheidung.
8. **Alternativabläufe** — Zulässige Varianten mit eigener Zwischenüberschrift: Abweichung, Voraussetzung, abweichende Schritte, Ergebnis.
9. **Konflikte und Fehlerfälle** — Ursache, betroffene Regel, Reaktion/Meldung des Systems, mögliche Handlung des Anwenders, Zustand der Daten nach Abbruch. Technische Fehler ohne fachliche Relevanz gehören nicht hierher.
10. **Ergebnis (Nachbedingung)** — Fachlicher Zustand nach erfolgreichem Abschluss: geänderte Daten/Zuordnungen, neue Zustände, ausgelöste Folgeaktionen, was sichtbar ist.
11. **Unveränderte Daten und Beziehungen** — Nur wenn ausdrücklich klarzustellen ist, was *nicht* verändert wird (z. B. wenn Anwender eine automatische Löschung/Übernahme vermuten könnten).
12. **Fachliche Regeln** — Regeln, die speziell für diesen Use Case gelten. Müssen mit den Feature-Regeln übereinstimmen; Abweichungen/Zusätze ausdrücklich kennzeichnen.
13. **Sonderfälle** — Seltene zulässige Abweichungen außerhalb von regulärem/alternativem Ablauf. Entfällt, wenn keine bestehen.
14. **Verwandte Themen** — Steht immer am Ende (siehe unten).

---

## Ablauf

1. Übergeordnetes Feature via MCP laden (`get_feature`) — Feature-Regeln sind maßgeblich.
2. Bestehenden Use Case via MCP laden (`get_use_case`) wenn vorhanden; relevante Beziehungen prüfen.
3. **Aussageinventar** erstellen — jede eigenständige Aussage erfassen (Ziel, Rollen, Voraussetzungen, Auslöser, Schritte, Entscheidungen, Regeln, Ausnahmen, Fehlerfälle, Folgen, unveränderte Daten, Verweise). Arbeitsmittel.
4. Hauptablauf aus Anwenderperspektive schreiben — nicht aus Systemperspektive.
5. Alternativabläufe und Fehlerfälle vollständig ergänzen; Fehlerfälle aus den Feature-Regeln ableiten, mit konkreter Systemreaktion.
6. Abweichungen oder Widersprüche zu den Feature-Regeln dokumentieren statt sie zu glätten.
7. Jede Inventar-Aussage einem Abschnitt zuordnen; Bereich „Verwandte Themen" recherchieren.
8. Neue Fassung gegen das Aussageinventar prüfen: ist jede Aussage ausdrücklich erhalten?
9. Use Case via MCP speichern (`update_use_case` oder MCP-Äquivalent).
10. Kurzen **Redaktionsnachweis** als Kommentar am Use Case veröffentlichen (`add_comment_to_parent`).

---

## Verwandte Themen

Nur fachlich begründete Beziehungen. Jeder Eintrag: **Referenz · Titel · Beziehungstyp · kurze fachliche Begründung**.

Beziehungstypen für Use Cases (zusätzlich zu den Feature-Typen):
`folgt auf` · `wird ausgelöst durch` · `löst aus` · `ist Alternative zu`

Übliche Verknüpfungen: übergeordnetes Feature, vorausgesetzte Use Cases, nachfolgende Use Cases, alternative/verwandte Use Cases, gemeinsame Regeln und Datenbeziehungen.

Muster:

```
**UC (xx): Titel**
**Beziehung:** folgt auf
**Zusammenhang:** Dieser Use Case kann ausgeführt werden, nachdem …
```

---

## Schreibregeln

- Abläufe in Anwendersprache — „Der Anwender wählt …" nicht „Das System setzt das Flag …"
- Schritte atomisch — ein Schritt = eine Aktion
- Fehlerfälle mit konkreter Reaktion: „Das System zeigt eine Fehlermeldung: Datum liegt in der Vergangenheit"
- Fehlerfälle vollständig — unvollständige Fehlerfälle machen Use Cases als Testbasis wertlos
- Voraussetzungen nicht mit Ablaufschritten vermischen
- Keine Architekturdetails, kein Datenbankdesign, keine API-Beschreibungen; unnötige Implementierungsdetails vermeiden
- Fließtext und Aufzählungen ausgewogen; vor längeren Listen ein Einleitungssatz
- Für denselben Gegenstand durchgehend dieselbe Bezeichnung; eindeutige Referenzen auf Feature, Rollen, Zustände erhalten

---

## Redaktionsnachweis (Kommentar am Use Case)

Kurz halten — kein Teil des Hauptinhalts. Mindestens:

- **Bearbeitungsumfang**
- **Zusammengeführte oder entfernte Aussagen** mit Begründung; sonst „Keine fachlichen Aussagen zusammengeführt/entfernt."
- **Erkannte Unklarheiten oder Widersprüche** (nicht eigenmächtig aufgelöst); sonst „Keine erkannt."
- **Geprüfte Verknüpfungen** und offene Punkte
- **Abschluss** — Bestätigung der Verlustfreiheit oder Benennung der dokumentierten Abweichungen

---

## Abnahmekriterien

- Alle relevanten Pflichtabschnitte vorhanden
- Bei Überarbeitung: jede Aussage des Aussageinventars ausdrücklich erhalten (verlustfrei)
- Ablauf nachvollziehbar für Anwender ohne Entwicklerhintergrund
- Fehlerfälle mit konkreter Systemreaktion dokumentiert
- Verknüpfung zum übergeordneten Feature vorhanden; „Verwandte Themen" mit Referenz, Titel, Beziehungstyp, Begründung
- Kein Widerspruch zu den Feature-Regeln (Abweichungen ausdrücklich gekennzeichnet)
- Unklarheiten/Widersprüche gekennzeichnet statt geglättet
- Redaktionsnachweis als Kommentar veröffentlicht
