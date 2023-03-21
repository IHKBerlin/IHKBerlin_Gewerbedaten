# IHK Berlin Gewerbedaten

This repository contains open-source datasets from [IHK Berlin](https://www.ihk.de/berlin/).


## What kind of data?
The data comes primarily from the database of IHK Berlin and is additionally combined with [LOR](https://www.berlin.de/sen/sbw/stadtdaten/stadtwissen/sozialraumorientierte-planungsgrundlagen/lebensweltlich-orientierte-raeume/).
The dataset is updated every month, and the folder archivedData contains the historical datasets. All datasets contain a unique and consistent ID. 


## What can you do with it?
The data is for you to explore, visualize and to create combinations with other datasets. We are very interested what you can do and what you use it for.


## Contacts us
opendata@berlin.ihk.de


## Dataset description


| Column        | Description |
| ------------- | ------------- |
| opendata_id  | Primary key |
| longitude    | Geolocation of the business, described by the longitude (Format: EPSG 4326) |
| latitude     | Geolocation of the business, described by the latitude (Format: EPSG 4326) |
| postcode     | Postcode of the business |
| city         | City of the business |
| Bezirk       | Bezirk of the business |
| Ortsteil     | Ortsteil of the business |
| Prognoseraum    | LOR Prognoseraum  |
| Bezirksregion  | LOR Bezirksregion |
| Planungsraum    | LOR Planungsraum |
| planungsraum_id    | LOR Planungsraum ID |
| ihk_branch_id  | Branch ID of the business as defined by IHK classification of economic activities (finest granuality of distinction) |
| ihk_branch_desc    | Branch description of the business as defined by IHK classification of economic activities|
| nace_id  | Branch ID of the business as defined by EU classification of economic activities, see [NACE-Codes](https://nacev2.com/de) |
| nace_desc    | Branch description of the business as defined by EU classification of economic activities|
| branch_top_level_id  | Branch ID of the business as a broad classification of economic activities|
| branch_top_level_desc    | Branch description of the business as a broad classification of economic activities |
| employees_range  | The reported number of employees as range  |
| business_age    | Current age of the business |
| business_type  | "Kleingewerbetreibender" = the business is a small trader, "im Handelsregister eingetragen" = the business is registered in the Commercial Register  |

---

## Lizenz

The [data](data) in this repository is published under [Creative Commons Zero](https://opendefinition.org/licenses/cc-zero/).

