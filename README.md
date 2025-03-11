# Overview

This GitHub Action can be used to validate Victoria 3 mod files using [ck3-tiger](https://github.com/amtep/ck3-tiger).

ck3-tiger is developed by [amtep](https://github.com/amtep).

> **NOTE:** This action is incomplete and needs to be set up before it can be used. This is because of copyright issues with publishing game files on the internet. Publishing the GitHub Action with game files amounts to **PIRACY!**

## Setup

To set this GitHub Action up for yourself, you will need to do the following steps:

1. **Download the Repository**
   - First, download the repository as a whole.
  
2. **Create a New PRIVATE Repository**
   - Create a new **PRIVATE** repository on GitHub and upload the downloaded files into it.
  
3. **Copy Game Files**
   - Copy the whole of your own game files into the `vic3` or `ck3` (depending on which game you want to validate) folder.
  
4. **Clean Game Files**
   - So you do not need to upload all game files, run the [clean-vic3.sh](clean-vic3.sh) or [clean-ck3.sh](clean-ck3.sh) script (On Windows, I recommend using WSL).
  
5. **Commit and Push**
   - Finally, commit and push the stripped-down game files into your **PRIVATE** repository.
   - **Optional Step: Use `add-files.sh` to Commit and Push Files**
     - If you have a large number of files (CK3 is >30k files) to commit and push, use the [add-files.sh](add-files.sh) script to make it easier. This script commits a maximum of 100 files at a time and ensures that each commit does not exceed 100 Mb to avoid timeout issues.

## Usage

To use the GitHub Action in another of your repositories, you will need to do the following steps:

1. **Create an Access Token**
   - Create an access token for the repository. This [guide](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens) can help you. I recommend using a fine-grained token that can only access the repositories' contents as read-only.
  
2. **Add Token to Mod Repository**
   - Add the token to your mod repository as a workflow secret like described in this [guide](https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions).

3. **Set Up Validation Workflow**
   - Set up the validation as a workflow. Here is an [example](https://github.com/kaiser-chris/gate-mod/blob/master/.github/workflows/validate.yml) from my own mod where I run the validation on pull requests and on commits on the master branch. The Community Mod Framework part is an example of how to work with dependencies.

## Action Parameters
 - `mod-directory`: Defines where your mod located inside the repository (Default: `.`)
 - `action-directory`: Defines where this action is located inside the repository (Default: `.`)
 - `game`: Defines game used to verify (Default: `vic3`)
   - `vic3`: Victoria 3
   - `ck3`: Crusader Kings 3
 - `update-tiger`: Activate whether tiger should check for an update before running (Boolean, Default: `false`)

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
        # If your repository uses lfs include this property
        with:
          lfs: 'true'

      - name: Checkout Validation
        uses: actions/checkout@v4
        with:
          repository: your-github-name/tiger-action-repository
          ref: 'main'
          path: 'validation'
          # Validation token defined in the usage instructions
          token: ${{ secrets.VALIDATION_TOKEN }}

      - name: Validate
        uses: ./validation/
        with:
          # Relative path to the mod directory from repository root (defaults to repository root directory)
          mod-directory: 'mod'
          # Relative path to the validation action repository root (defaults to repository root directory)
          action-directory: 'validation'
          # Which game files should be used for validation (ck3 or vic3 but defaults to vic3) 
          game: 'vic3'
```