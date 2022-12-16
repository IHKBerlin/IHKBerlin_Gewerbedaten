# Makefile to automate various administration tasks related to
# dataset repositories

# extract some values from the ckan_updater config
license_id = `jq -r '.dataset.license_id' conf/ckan_updater.json`
ckan_base = `jq -r '.connection.ckan_base' conf/ckan_updater.json`
license_def = $(ckan_base)/licenses/berlin-od-portal.json
config_location = conf/ckan_updater.json

# high-level targets
.PHONY: repository-init
repository-init: README.md

dataset-update:
	@metadata_updater

# create the real new README
README.md: temp/README.md admin.md
	@echo "generating $@ from $< ..."
	@cp $< $@

# create a new README in temp based on the template and the config file
temp/README.md: temp/ckan_updater.json
	@echo "generating $@ ..."
	@j2 README.template.md $< > $@

# rename the original README.md to admin.md to keep it in the new repository
.PHONY: admin.md
admin.md:
	@echo "generating $@ ..."
	@mv README.md $@

.PHONY: conf/ckan_updater.json
conf/ckan_updater.json: temp/repository.json
	@echo "merging $@ with $< ..."
	@jq -s '.[0] * .[1]' $@ $< > temp/_ckan_updater.json
	@echo "copying merged file to $@ ..."
	@mv temp/_ckan_updater.json $@

# download the license definition file, make each license accessible 
# by its id
temp/licenses.json: temp
	@echo "getting license list from $(license_def) ..."
	@curl -s $(license_def) | jq 'map( { (.id): . } ) | add' > $@

# extract the details of the license specified in config
temp/license_details.json: temp/licenses.json
	@echo "writing license details to $@ ..."
	@jq --arg license_id "$(license_id)" '.[$$license_id] | { dataset: { license_title: .title, license_url: .url } }' $< > $@

# create a json file with the URL of the github repository
# GITHUB_REPOSITORY is a default environment variable available in GitHub Actions:
# https://docs.github.com/en/actions/learn-github-actions/environment-variables#default-environment-variables
temp/repository.json: temp
	@echo "writing repository URL to $@ ..."
	@jq -n --arg github_repository "https://github.com/$(GITHUB_REPOSITORY)" '{ dataset: { url: $$github_repository } }' > $@

# merge config with license details into an updated config
temp/ckan_updater.json: conf/ckan_updater.json temp/license_details.json
	@echo "merging $^ ..."
	@jq -s '.[0] * .[1]' $^ > $@

# housekeeping
clean: clean-temp

clean-temp:
	@echo "deleting temp folder ..."
	@rm -rf temp

temp:
	@echo "creating temp directory ..."
	@mkdir -p temp

