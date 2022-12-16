# Berlin Dataset Template

This repository can be used as a template for new datasets for [Berlin Open Data](https://daten.berlin.de "The official Open Data portal of Berlin"), the official Open Data portal of the city of Berlin.
While the data portal is exclusively a metadata portal, repositories created on the basis of this template are meant to hold the actual data of a dataset.

The template provides a number of elements that are common to all datasets, as well as some code for the automation of common tasks:

- a `README.md` file with basic information about the dataset
- a [data](data) folder as the default location for the actual data files
- metadata for the dataset and other configuration in the [conf](conf) folder
- a [Makefile](Makefile) to help automate certain administration tasks
- [workflows](.github/workflows/) that will trigger these tasks under certain conditions:
  - initialising the new dataset repository when the metadata in [conf/updater.json](conf/updater.json) is changed for the first time
  - updating the dataset's metadata in [Berlin Open Data](https://daten.berlin.de "The official Open Data portal of Berlin") each time the [data](data) is changed

## Creating a New Dataset Repository

To create a new dataset repository from this template, do the following:

- Click the green <a href="../../generate">Use this template</a> button right below the main navigation.
- Enter the repository name and description. Make sure the repository is **public** and the **Include all branches** check box is not ticked!
- Once the new repository is created, create a new repository secret called `CKAN_TOKEN` in <a href="../../settings/secrets/actions">Settings > Secrets > Actions</a>.
This token is needed to communicate and write to the Datenregister (CKAN).
The token can either be found on your user profile page, or it can be generated there.
The token needs to belong to a user that has write access to the CKAN organization that the dataset belongs to.
Ideally the user that is responsible for the dataset.
_Important: don't enter an admin-level token here, as this would introduce serious security risks!_
- Finally, add collaborators to the new repository who will be adding the datafiles.
Collaborators can be added in <a href="../../settings/access">Settings > Access</a>.
Collaborators should have the **Write** role.

## Initialising the Dataset Repository

To initialise the repository, you can <a href="../../edit/master/conf/ckan_updater.json">edit the configuration file</a> in `conf/ckan_updater.json`.
This works both if the dataset already exists in CKAN and if it doesn't.
If it exists already, it's best to copy the relevant metadata from CKAN.
All attributes that are present in [conf/ckan_updater.json](conf/ckan_updater.json) should be edited.
The first time the file is edited, the workflow defined in [init.yml](.github/workflows/init.yml) will be triggered.
The workflow will …
  - … rename the current README.md to `admin.md` (so that it isn't lost).
  - … create a new README.md based on the template in [README.template.md](README.template.md) and the metadata in [conf/ckan_updater.json](conf/ckan_updater.json).
  - … add the URL of the repository as the URL of the dataset in [conf/ckan_updater.json](conf/ckan_updater.json).
  - … disable the init workflow (so that it doesn't get triggered each time the config file is changed).

## Updating the Data

All collaborators with **write** access can change data in or add data to the repository.
All data needs to reside in the [data](data) folder.
Adding or changing data is possible directly from the browser by navigating to the `data` folder and then clicking <a href="../../upload/master/data">Add file > Upload files</a>.

Any change to files in the `data` folder triggers the [dataset_update](.github/workflows/dataset_update.yml) workflow.
The main thing this workflow does is run the [CKAN Metadata Updater](https://github.com/berlinonline/ckan_metadata_updater) tool to modify the dataset's metadata in the Datenregister/CKAN.
Without further configuration, the updater will set `date_updated` to today's date and apply the `dataset` metadata patch in [conf/ckan_updater.json](conf/ckan_updater.json) (overwrite all common attributes with the values in the config file).
If you need additional changes when the dataset's data is updated, you can [add additional custom steps](https://github.com/berlinonline/ckan_metadata_updater#custom-steps) to the updater.
This requires adding Python code to the repository and potentially adjusting the [Makefile](Makefile).

## License

All software in this repository is published under the [MIT License](LICENSE).

