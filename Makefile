.DEFAULT_GOAL := help

.PHONY: help tests tests-verbose
help: Makefile
	  @printf "\nChoose a command run in $(shell basename ${PWD}):\n"
	  @sed -n 's/^##//p' $< | column -t -s ":" |  sed -e 's/^/ /' ; echo

## setup: Setup the repository configuration, reviewing that have all the required things to run.
setup:
	  @echo "Checking pre-requisites"
	  @echo "NPM version: $(shell npm --version)"
	  @echo "NPX version: $(shell npx --version)"


## setup-release: install dependencies for the semantic release
setup-release:
	  @npm install -D semantic-release-monorepo semantic-release@v19.0.5 @semantic-release/changelog conventional-changelog-conventionalcommits@v6.1.0

## release: creates a new release, generating the Changelog.md and the tag. The tag will be created in the commit of the branch, and will be added to master after the merge
release:
	  @npx semantic-release --debug --no-ci
