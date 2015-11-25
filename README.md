# GitHub Label Maker

GitHub Label Maker is a small script set which you can use to add/update and remove issue labels in GitHub repositories. It uses GitHub's [Octokit library](https://github.com/octokit/octokit.rb) to manage repositories. Why? Because it's frustrating to always create missing labels to new repositories by hand.

## Setup

### Gems

You need couple of gems to use this script:

```
gem install octokit
gem install netrc
gem install json
```

### Personal access token

You need to create a Persional access token which is used in the ```.netrc``` file. You can create one in your profile settings: https://github.com/settings/tokens

The script is tested and it should work with only ```repo``` option selected.

### .netrc

You need .netrc file  which contains your authentication information. The .netrc file usage is explained in [Octokit's repo](https://github.com/octokit/octokit.rb#using-a-netrc-file), but the basic format is this:

```
machine api.github.com
  login <your-username>
  password <your 40 char token>
```

### labels.json

When using the add/update script you'll need to fill the labels to ```labels.json``` file. The repository contains our set of labels which is mostly copied from here: https://robinpowered.com/blog/best-practice-system-for-organizing-and-tagging-github-issues/

The structure of the json file uses following pattern:

```json
{
  "labelTypes" : [
    {
      "type" : "problem",
      "color" : "EE3F46",
      "labels" : [
        {
          "name" : "bug"
        },
        {
          "name" : "security"
        }
      ]
    },
    {
      "type" : "experience",
      "color" : "FFC274",
      "labels" : [
        {
          "name" : "copy"
        },
        {
          "name" : "design"
        },
        {
          "name" : "ux"
        }
      ]
    }
  ]
}
```

## Usage

There is two scripts included: one for creating/updating labels and one for deleting them. The scripts should be quite self explanatory. Just move to the directory where the scripts lie and run!

### labelmaker.rb

For creating/updating labels.
```
ruby labelmaker.rb
```

### labelremover.rb

For removing labels.
```
ruby labelremover.rb
```

## Contributing

All comments and any kind of contribution is useful. The best way is to open an issue or make a pull request.

## Licence

Do we even need one? If so, then it's going to be:

WTFPL – Do What the Fuck You Want to Public License: http://www.wtfpl.net
