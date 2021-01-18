#! /bin/zsh

HERE="$(pushd "$(dirname "$0")" && pwd)"

### cmd line tools #########################################################

#xcode-select --install
sudo xcodebuild -license accept


### atom #########################################################
# previously: install Atom for macOS

#mkdir ~/.atom

#cp "$HERE"/atom/*.coffee ~/.atom
#cp "$HERE"/atom/*.cson ~/.atom

#apm install --packages-file atom/apm-packages.txt



### vs code #########################################################

which code

VS_CODE_USER="$HOME/Library/Application Support/Code/User/"
mkdir -p "$VS_CODE_USER"
mv "$VS_CODE_USER/settings.json" "$VS_CODE_USER/settings-backup.json"
#ln -s "$HERE/vs-code/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
cp "$HERE/vs-code/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"

bash "$HERE/vs-code/extensions-reinstall.sh"

defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false


### .rc files #########################################################

mv ~/.zshrc ~/.zshrc-backup
ln -s "$HERE/.zshrc" ~/.zshrc
rm ~/.zlogin
ln -s "$HERE/.zlogin" ~/.zlogin

mv ~/.bashrc ~/.bashrc-backup
ln -s "$HERE/.bashrc" ~/.bashrc
rm ~/.bash_history
ln -s "$HERE/.bash_history" ~/.bash_history
rm ~/.inputrc
ln -s "$HERE/.inputrc" ~/.inputrc

mv ~/.gitconfig ~/.gitconfig-backup
ln -s "$HERE/.gitconfig" ~/.gitconfig

mkdir -p ~/.ssh
rm ~/.ssh/config-sample
ln -s "$HERE/ssh-config" ~/.ssh/config-sample
