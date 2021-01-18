# Visual Studio Code

## Backing up configs 

Extensions can be listed like so, in the form of a script to re-install them:
```sh
code --list-extensions | xargs -L 1 echo code --install-extension > extensions-reinstall.sh
```

And user settings are copied from here, including the specific terraform env-xyz folders for linting:
```sh
cp ~/Library/Application\ Support/Code/User/settings.json .
```

## Installing

(1) Set up the `code` CLI command: SHIFT+CMD+P -> "Shell Command: install 'code' command".

(2) Copy `settings.json` back over.

(3) Run `extensions-reinstall.sh` to set up extensions.

(4) Enable key-press repeating (by disabling Apple's setting?):
```sh
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
```
