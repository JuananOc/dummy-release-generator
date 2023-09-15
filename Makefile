.DEFAULT_GOAL := help

.PHONY: help tests tests-verbose
help: Makefile
	  @printf "\nChoose a command run in $(shell basename ${PWD}):\n"
	  @sed -n 's/^##//p' $< | column -t -s ":" |  sed -e 's/^/ /' ; echo

export GITHUB_TOKEN ?= "dummy-value"

## unset: remove variables from terminal session `source <(make unset)`
.PHONY: unset
unset:
	@echo 'unset GITHUB_TOKEN'

## env: print required variables
.PHONY: env
env:
	@echo 'export GITHUB_TOKEN=${GITHUB_TOKEN}'

## show-env: Show passed environment to targets
.PHONY: show-env
show-env:
	@env

## setup: Setup the repository configuration, reviewing that have all the required things to run.
setup:
	@echo "Checking pre-requisites"
	@echo "NPM version: $(shell npm --version)"
	@echo "NPX version: $(shell npx --version)"


## setup-release: install dependencies for the semantic release
setup-release:
	@npm install -D semantic-release-monorepo semantic-release@v19.0.5 @semantic-release/changelog conventional-changelog-conventionalcommits@v6.1.0

## release: iterate over all folders inside childs with a package.json and execute-release process
release:
	-@for module in $(shell find child -type f -name "package.json" -exec dirname {} \;); do \
		make release-module-$${module}/; \
	done

release-module-%/:
	cd $* && npx semantic-release --debug --no-ci && cd -
