# Overview

This github-action can be used to validate Victoria 3 mod files using [ck3-tiger](https://github.com/amtep/ck3-tiger).

ck3-tiger is developed by [amtep](https://github.com/amtep).

**NOTE: This action is incomplete and needs to be set up before it can be used.
This is because of copyright issues with publishing game files on the internet.
Publishing the github-action with game files amounts to PIRACY!**

## Setup
To set this github-action up for yourself, you will need to do the following steps:

- First, you need to download the repository as a whole.
- Next, create a new **PRIVATE** repository on GitHub and upload the downloaded files into it.
- Then you copy the whole of your own game files into the `vic3` or `ck3` (depending on which game you want to validate) folder.
- So you do not need to upload all game files, you will then need to run the [clean-vic3.sh](clean-vic3.sh) or [clean-ck3.sh](clean-ck3.sh) script (On windows I recommend using WSL).
- Finally, you can commit and push the stripped down game files into your **PRIVATE** repository.

### Optional Step: Use `add_files.sh` to Commit and Push Files
- If you have a large number of files to commit and push, you can use the `add_files.sh` script to make it easier. This script commits a maximum of 100 files at a time and ensures that each commit does not exceed 100 Mb to avoid timeout issues.

## Usage
To use the github-action in another of your repositories, you will need to do the following steps:

- First, you will need to create an access token for the repository. This [guide](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens) can help you. I recommend using a fine-grained token that can only access the repositories' contents as read-only.
- Then you need to add the token to your mod repository as a workflow secret like described in this [guide](https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions).
- Lastly, you will need to set up the validation as workflow. Here is an [example](https://github.com/kaiser-chris/gate-mod/blob/master/.github/workflows/validate.yml) from my own mod where I run the validation on pull-requests and on commits on master. The Community Mod Framework part is an example of how to work with dependencies.

## Example Workflow
This example validates every pull request and commits into the main branch:
```yaml
name: Validation
permissions:
  contents: read
  packages: write
  checks: write

on:
  pull_request:
    branches:
      - main
  push:
    branches:
      - main

jobs:
  validate:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          lfs: 'true'

      - name: Checkout Validation
        uses: actions/checkout@v4
        with:
          repository: your-github-name/tiger-action-repository
          ref: 'main'
          path: 'validation'
          token: ${{ secrets.VALIDATION_TOKEN }}

      - name: Validate
        uses: ./validation/
        with:
          mod-directory: 'mod'
          action-directory: 'validation'
          game: 'vic3' # Also supports ck3
