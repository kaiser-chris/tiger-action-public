# Overview

This github-action can be used to validate Victoria 3 mod files using [ck3-tiger](https://github.com/amtep/ck3-tiger).

ck3-tiger is developed by [amtep](https://github.com/amtep).

**NOTE: This action is incomplete and needs to be set up before it can be used.
This is because of copyright issues with publishing game files on the internet.
Publishing the github-action with game files amounts to PIRACY!**

## Setup
To set this github-action up for yourself, you will need to do the following steps:

 - First, you need to download the repository as a whole
 - Next, create a new **PRIVATE** repository on GitHub and upload the downloaded files into it
 - Then you copy the whole of your own game files into the `vic3` or `ck3` (depending on which game you want to validate) folder
 - So you do not need to upload all game files, you will then need to run the [clean-vic3.sh](clean-vic3.sh) or [clean-ck3.sh](clean-ck3.sh) script (On windows I recommend using WSL)
 - Finally, you can commit the stripped down game files into your **PRIVATE** repository

## Usage
To use the github-action in another of your repositories, you will need to do the following steps:

 - First, you will need to create an access token for the repository this [guide](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens) can help you. I recommend using a fine-grained token that can only access the repositories' contents as read-only.
 - Then you need to add the token to your mod repository as a workflow secret like described in this [guide](https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions)
 - Lastly, you will need to set up the validation as workflow. Here is an [example](https://github.com/kaiser-chris/gate-mod/blob/master/.github/workflows/validate.yml) from my own mod where I run the validation on pull-requests and on commits on master. The Community Mod Framework part is an example of how to work with dependencies
