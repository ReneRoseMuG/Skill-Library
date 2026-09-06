# Settings-Vorlage für Konsumenten-Repos

Diese Felder in `.claude/settings.json` jedes Repos ergänzen, das die Plugins dieser Bibliothek
nutzen soll (Projekt Manager, MuGPlan, künftige Repos mit vergleichbarem Stack). Repos ohne
Projekt-Manager-Anbindung lassen `pm-workflow-skills` weg und nehmen nur `dev-testing-skills`.
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
  "enabledPlugins": {
    "pm-workflow-skills@skill-library": true,
    "dev-testing-skills@skill-library": true
  },
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

Damit installieren sich beide Plugins bei jeder neuen Sitzung automatisch nach —
auf jedem Rechner (Homeoffice/Büro), ohne dass ein absoluter lokaler Pfad zur Bibliothek
übereinstimmen muss (GitHub-Quelle, kein lokaler Marketplace-Pfad).

**Einmalig pro Rechner nötig:** Beim allerersten Mal muss `claude` einmal mit Netzwerkzugriff
laufen, damit `claude plugin marketplace add`/`claude plugin install` das Plugin tatsächlich
von GitHub holen können. Danach reicht `git pull` in dieser Bibliothek + der SessionStart-Hook,
um beide Rechner auf demselben Stand zu halten.

**Nach inhaltlichen Änderungen an einem Plugin** muss dessen `version` in
`.claude-plugin/plugin.json` erhöht werden. Ohne Versionssprung übernimmt der lokale
Plugin-Cache die Änderung nicht und `claude plugin update` meldet „already at the latest
version".
