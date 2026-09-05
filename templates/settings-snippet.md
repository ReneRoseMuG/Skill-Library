# Settings-Vorlage für Konsumenten-Repos

Diese Felder in `.claude/settings.json` jedes Repos ergänzen, das `pm-workflow-skills`
nutzen soll (Projekt Manager, MuGPlan, künftige Repos mit Projekt-Manager-Anbindung).
Bestehende `permissions`/`hooks`-Einträge des Repos bleiben erhalten — diese Felder nur
ergänzen, nicht die Datei ersetzen.

```json
{
  "extraKnownMarketplaces": {
    "skill-library": {
      "source": {
        "source": "github",
        "repo": "ReneRoseMuG/Skill-Library"
      }
    }
  },
  "enabledPlugins": [
    "pm-workflow-skills@skill-library"
  ],
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          { "type": "command", "command": "bash .claude/hooks/ensure-plugins.sh" }
        ]
      }
    ]
  }
}
```

Zusätzlich `templates/ensure-plugins.sh` aus dieser Bibliothek nach
`.claude/hooks/ensure-plugins.sh` im Konsumenten-Repo kopieren.

Damit installiert sich `pm-workflow-skills` bei jeder neuen Sitzung automatisch nach —
auf jedem Rechner (Homeoffice/Büro), ohne dass ein absoluter lokaler Pfad zur Bibliothek
übereinstimmen muss (GitHub-Quelle, kein lokaler Marketplace-Pfad).

**Einmalig pro Rechner nötig:** Beim allerersten Mal muss `claude` einmal mit Netzwerkzugriff
laufen, damit `claude plugin marketplace add`/`claude plugin install` das Plugin tatsächlich
von GitHub holen können. Danach reicht `git pull` in dieser Bibliothek + der SessionStart-Hook,
um beide Rechner auf demselben Stand zu halten.
