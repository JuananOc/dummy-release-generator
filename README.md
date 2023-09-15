# Introduction

This repository configure semantic-release with semantic-release-monorepo.

# Setup

```bash
# 1. create file with env variables required and modify the GITHUB with your token.
make env > .envrc
vim .envrc

# 2. export variables
source .envrc

# 3. Setup
make setup-release

# 4. generate releases
make release
```


# How it works and details
- The trick part is the version of conventional-changelog-conventionalcommits, that is failing silent without any error in after v7. rolling back to v6.1.0 works as intended.

- To use and create new modules inside your monorepo, create a package.json in the folder with the name of the module. Look child/module/package.json as example.

- The command make release is iterating under child folder looking for all the modules (that are folders inside 'child' folder with a 'package.json' file) and cd inside the module to execute the generate release command.

> Note that as this is the local test the --no-ci is harcoded
