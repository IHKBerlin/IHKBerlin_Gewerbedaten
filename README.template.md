# {{ dataset.get('title', "{TITEL_DES_DATENSATZES}") }}

{{ dataset.get('author', "{VERÖFFENTLICHENDE_STELLE}")}}

{{ dataset.get('notes', "{Hier sollte eine Beschreibung des Datensatzes stehen}") }}

---

Dieser Datensatz ist Teil von [Berlin Open Data](https://daten.berlin.de), dem zentralen Portal für offene Daten des Landes Berlin.
Der Datensatz ist dort unter https://daten.berlin.de/datensaetze/{{ dataset.id }} eingetragen.

## Lizenz

Die [Daten](data) in diesem Repository sind unter [{{ dataset.get('license_title', "{LIZENZNAME}")}}]({{ dataset.get('license_url', "") }}) veröffentlicht.

