#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
#set -x

HERE="$(pushd "$(dirname "$0")" && pwd)"

### python 3 #########################################################
brew install python


### aws #########################################################
python3 -m pip install wheel --upgrade --user
python3 -m pip install awscli --upgrade --user
python3 -m pip install ansible --upgrade --user


### ansible #########################################################
#ln -s /Users/kevincantu/Library/Python/3.7/bin/ansible-playbook /usr/local/bin/ansible-playbook  # fix ansible weirdness


### kubectl #########################################################
mkdir -p $HOME/bin

KU_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
KU=kubectl-${KU_VERSION}

curl -L -o ~/bin/${KU} https://storage.googleapis.com/kubernetes-release/release/${KU_VERSION}/bin/darwin/amd64/kubectl

chmod +x ~/bin/$KU
rm ~/bin/kubectl
ln -s ~/bin/$KU ~/bin/kubectl


### other k8s tools #########################################################

#brew install octant
