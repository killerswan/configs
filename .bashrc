# .bashrc

# notes:
#   CTRL-A and CTRL-E move the cursor to front and end of a line

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

#PS1="[\u@\h \W]\$ "
PS1="[\W]\$ "

#alias ls="ls -F --color"  # (linux)
#alias ll="ls -alhF --color"  # (linux) F: @/
alias ls="ls -GF"  # (macos)
alias ll="ls -alhFGB"  # (macOS) F: @/, G: color, B: \x23423
alias dir="ll"
alias copy="cp"
alias move="mv"
function where() {
  echo "(Try which instead of where.)" >& 2
  which $@
}
function clip() {
  echo "(Try pbcopy instead of clip.)" >& 2
  pbcopy
}
function kubeclt() {
  echo "(Try kubectl instead of kubeclt.)" >& 2
  kubectl $@
}
function contour-port-forward() {
  jj=0;
	for ii in $(kubectl -n heptio-contour get pod -l app=contour -o jsonpath={..metadata.name}); do
	  ((jj++));
		(kubectl -n heptio-contour port-forward $ii "$((9000+jj))":9001 &);
  done
}

#export GO111MODULE="on"
#export GOFLAGS=-mod=vendor
GOPATH="$HOME/go"          # where exes get built (can be implicit)
GOROOT="/usr/local/go"     # where go is installed (can be implicit)

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$GOROOT/bin"
export PATH="$PATH:/Users/kevincantu/Library/Python/3.7/bin"

# brew install node@10
#export PATH="$PATH:/usr/local/opt/node@10/bin"

# EKS versions:
# https://docs.aws.amazon.com/eks/latest/userguide/platform-versions.html
#
# upgrade order:
# https://kubernetes.io/docs/setup/release/version-skew-policy/#supported-component-upgrade-order

# kubectl
# downloaded as described here: https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-binary-with-curl-on-macos
#
# query latest stable version:
#  curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt
#
# download kubectl
#  cd ~/bin
#  curl -L -o kubectl-v1.13.0 https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/darwin/amd64/kubectl
#  chmod +x kubect-v1.13.0
#  ln -s kubectl-v1.13.0 kubectl

# notable things installed:
#  Go from their website (from .tar.gz)
#  terraform from their website
#  python (python3 and pip3) from homebrew
#  awscli via pip3
#  ansible via pip3
#  octant from homebrew
#  kubectl (see above)
#  kops from homebrew
#  go get -u github.com/go-delve/delve/cmd/dlv                            # after commenting GO111MODULE and GOFLAGS
#  go get -u sigs.k8s.io/aws-iam-authenticator/cmd/aws-iam-authenticator  # after commenting GO111MODULE and GOFLAGS
#  Docker CE (Docker Desktop for macOS) from DockerHub
#  longer timeout in 'sudo visudo' in minutes (-1 for never):
#    Defaults timestamp_timeout=120

# for kubectl
#export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/eks-ops.yaml"

# for awscli
export AWS_DEFAULT_REGION="us-west-2"
export AWS_DEFAULT_PROFILE="mfa"
# alternatively to a MFA profile, e.g., for Travis, users need these set:
# * AWS_ACCESS_KEY_ID
# * AWS_SECRET_ACCESS_KEY

# for kops
export AWS_PROFILE="mfa"

# to copy the k8s dashboard bearer token
function kube-token() {
  kubectl -n kube-system get secret -o jsonpath='{.data.token}' \
    $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}') \
    | base64 --decode \
    | pbcopy
}

# added by travis gem
#[ -f /home/kevin/.travis/travis.sh ] && source /home/kevin/.travis/travis.sh

# define some envvars with secrets
. ~/.kevin_secrets.sh
