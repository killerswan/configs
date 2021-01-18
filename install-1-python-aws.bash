#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
#set -x

HERE="$(pushd "$(dirname "$0")" && pwd)"

### python 3 #########################################################
brew install python@3.8


### aws #########################################################
python3 -m pip install pip --upgrade --user
python3 -m pip install wheel --upgrade --user
python3 -m pip install awscli --upgrade --user
python3 -m pip install black --upgrade --user
python3 -m pip install pyflakes --upgrade --user
python3 -m pip install virtualenv --upgrade --user
python3 -m pip install flake8 --upgrade --user

# clang issues?
python3 -m pip install ansible --upgrade --user

# Make sure our ~/.aws/credentials is set up with a user who has ForceMFA
# https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_users-self-manage-mfa-and-creds.html
# https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_aws_my-sec-creds-self-manage.html


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
