# Wiederverwendungs- und Umsetzungsentscheidung

Trifft vor der Implementierung eine nachvollziehbare Entscheidung über den Lösungsweg.
Verhindert unnötige Neuentwicklung und überladene Universalkomponenten.

---

## Zulässige Entscheidungsarten

| Entscheidung | Wann |
|---|---|
| **A. Unverändert verwenden** | Vorhandene Lösung deckt Aufgabe und Regeln vollständig ab |
| **B. Konfigurieren** | Vorhandene Props, Slots oder Varianten reichen aus |
| **C. Kontrolliert erweitern** | Neue Anforderung gehört zur Verantwortung der bestehenden Komponente |
| **D. Abstraktion extrahieren** | Mehrere Lösungen besitzen dieselbe stabile Verantwortung ohne gemeinsamen Kern |
| **E. Neue spezialisierte Komponente** | Keine bestehende Lösung ist fachlich und technisch passend |
| **F. Bewusst lokale Lösung** | Reine lokale Darstellung ohne wiederverwendbare Verantwortung, keine parallele Fachlogik |

---

## Entscheidungskriterien

- Gleiche fachliche Aufgabe?
- Gleiche Nutzerinteraktion?
- Gleiche Datenquelle und Auswahlregeln?
- Gleiche Validierung und Berechtigungswirkung?
- Gleiche visuelle Bedeutung?
- Vorhandene Konfigurations- und Erweiterungspunkte?
- Erwartete Wiederverwendung?
- Risiko einer überladenen Komponente?
- Auswirkung auf bestehende Nutzerpfade?
- Testbarkeit und Barrierefreiheit?
- Migrations- und Rückwärtskompatibilitätsaufwand?

---

## Pflichtablauf

1. Bestandskandidaten und geltende Regeln aus vorheriger Analyse übernehmen.
2. Jeden realistischen Kandidaten gegen die Entscheidungskriterien prüfen.
3. Verwerfen begründen wenn eine naheliegende zentrale Komponente nicht verwendet wird.
4. Bei Erweiterung prüfen ob sie innerhalb der bestehenden Verantwortung bleibt.
5. Bei Extraktion mindestens zwei Bestandsnutzer mit stabiler gemeinsamer Verantwortung nachweisen.
6. Bei Neuentwicklung prüfen ob eine lokale Lösung ausreicht oder Wiederverwendung absehbar ist.
7. Entscheidung dokumentieren — ein Satz reicht wenn die Begründung klar ist.

---

## Leitplanken

- Verwerfen ohne Begründung ist nicht zulässig.
- Erweiterung darf die Verantwortung der bestehenden Komponente nicht sprengen.
- Extraktion nur wenn die gemeinsame Verantwortung stabil und klar ist.
- Neuentwicklung ist keine Abkürzung — sie muss begründet werden.
- Lokale Lösung für Fachlogik ist eine technische Schuld, keine zulässige Option.

---

## Ergebnisformat

| Feld | Inhalt |
|---|---|
| Entscheidung | A–F mit einzeiliger Begründung |
| Referenzkomponente | Gewählte Lösung oder Basis für Erweiterung |
| Abnahmekriterien | Was die Implementierung erfüllen muss |
| Verworfene Alternativen | Warum andere Kandidaten nicht gewählt wurden |
| Offenes | Annahmen, Risiken, Fragen |
