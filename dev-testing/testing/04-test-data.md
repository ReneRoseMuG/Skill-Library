# Testdaten, Fixtures und Testimplementierung

Stellt fachlich gültige, reproduzierbare und isolierte Testdaten bereit.
Setzt den freigegebenen Testplan im Repository um.

---

## Testdaten-Verantwortlichkeiten

- Factories und Builder für Domänenobjekte
- Benutzer, Rollen und Berechtigungen
- Datenbankzustände (positive und negative Gegenbeispiele)
- Dateisystemstrukturen und Uploads
- Zeit-, Versions- und Statuszustände
- Konflikt- und Fehlerkonstellationen
- Cleanup, Reset und reproduzierbare Zufallsdaten

---

## Pflichtablauf — Testdaten

1. Benötigte fachliche Eigenschaften aus den Szenarien ableiten.
2. Minimalen, aber realistischen Datensatz entwerfen.
3. Positive und negative Beispiele sichtbar unterscheiden.
4. Wiederverwendbare Builder oder Fixtures nur ohne globale Kopplung erstellen.
5. Isolation pro Test oder Testsuite festlegen.
6. Cleanup und Fehlerfallverhalten prüfen.

**Leitplanken:**
- Keine produktiven Daten als Testgrundlage
- Keine fachlich unmöglichen Standard-Fixtures
- Keine versteckten Abhängigkeiten zwischen Fixtures
- Zufallsdaten nur mit reproduzierbarem Seed wenn Zufall tatsächlich Nutzen bringt
- Defaults müssen den Testzweck sichtbar lassen

---

## Pflichtablauf — Testimplementierung

1. Repository-Konventionen und vorhandene Muster prüfen.
2. Bestehende Tests bevorzugt gezielt erweitern wenn ihre Verantwortung klar bleibt.
3. Neue Tests an der vorgesehenen Ebene und Stelle anlegen.
4. Fixtures und Hilfen über diesen Skill erstellen oder anpassen.
5. Assertions, Isolation und Testnamen gegen den Testplan prüfen.
6. Keine nicht geplanten Produktivcode-Änderungen durchführen.
7. Betroffene Tests lokal ausführen.
8. Umgesetzte und bewusst nicht umgesetzte Punkte dokumentieren.

**Leitplanken:**
- Keine fachliche Erwartung erfinden um Implementierungslücken zu füllen
- Keine Tests abschwächen oder entfernen nur um Grün zu erreichen
- Keine unnötige Duplizierung vorhandener Hilfen
- Testcode muss lesbar erkennen lassen welche Regel geschützt wird

---

## Pflichtkommentar in Testdateien

```
Test Scope:

Test-Ebene:
- <Unit | Integration | Browser/E2E>

Realitätsgrad:
- <echte App/DB/FS/API/User/Rollen oder begründete Abgrenzung>

Mock-Entscheidung:
- <keine Mocks | Unit-Mocks: ... | Ausnahme ohne Einfluss: ...>

Isolation:
- <Temp-DB/In-Memory-DB/isolierter Test-Root>

Abgedeckte Regeln:
- <Regel 1>

Fehlerfälle:
- <Fehlerfall 1>

Ziel:
<Kurzbeschreibung der Absicherung>
```

---

## Ergebnis

- Factories, Builder oder Fixtures mit Beschreibung der fachlichen Eigenschaften
- Isolation und Cleanup
- Rollen- und Berechtigungsdaten
- Geänderte und neue Testdateien mit Zuordnung zu Szenarien
- Nicht umgesetzte Punkte und Gründe
