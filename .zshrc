################################################################
# envvars with secrets
################################################################

source ~/.kevin_secrets.sh


################################################################
# dev tools
################################################################

#export GO111MODULE="on"
#export GOFLAGS=-mod=vendor
GOPATH="$HOME/go"          # where exes get built (can be implicit)
GOROOT="/usr/local/go"     # where go is installed (can be implicit)

path+=("$HOME/.local/bin")
path+=("$HOME/bin")
path+=("$GOPATH/bin")
path+=("$GOROOT/bin")
path+=("$HOME/Library/Python/3.7/bin")

# in zsh, path and PATH are implicitly bound
# as in:
#   typeset -T LD_LIBRARY_PATH ld_library_path :
export PATH

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
#  curl -L -o kubectl-v1.17.0 https://storage.googleapis.com/kubernetes-release/release/v1.17.0/bin/darwin/amd64/kubectl
#  chmod +x kubect-v1.17.0
#  ln -s kubectl-v1.17.0 kubectl

# notable things installed:
#  Go from their website (from .tar.gz)
#  terraform from their website
#  python (python3 and pip3) from homebrew
#  awscli via pip3
#  ansible via pip3
#    brew install python
#    pip3 install awscli --upgrade --user
#    pip3 install ansible --upgrade --user
#    ln -s /Users/kevincantu/Library/Python/3.7/bin/ansible-playbook /usr/local/bin/ansible-playbook  # fix ansible weirdness
#  octant from homebrew
#  kubectl (see above)
#  kops from homebrew
#  OPTIONAL: go get -u github.com/go-delve/delve/cmd/dlv                            # after commenting GO111MODULE and GOFLAGS
#  UNTESTED: go get -v github.com/aquasecurity/kubectl-who-can/cmd/kubectl-who-can
#  Docker CE (Docker Desktop for macOS) from DockerHub
#  longer timeout in 'sudo visudo' in minutes (-1 for never):
#    Defaults timestamp_timeout=120

# for awscli
export AWS_DEFAULT_REGION="us-west-2"
export AWS_DEFAULT_PROFILE="mfa"
# alternatively to an MFA profile, e.g., for Travis, users need these set:
# * AWS_ACCESS_KEY_ID
# * AWS_SECRET_ACCESS_KEY

# for kops
export AWS_PROFILE="mfa"
export KOPS_STATE_STORE="s3://..."

# for kubectl
#export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/eks-ops.yaml"


################################################################
# aliases and PS1
################################################################

# left-prompt like PS1
# numeric colors here: https://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
# wish we had #FF0F83 but we do have {198}

PROMPT='%2~ %# '
#PROMPT='%(?..%F{red}[^error] %f)%2~ %# '

# show exit codes in right-prompt
RPROMPT='%(?..%F{198}err:%?%f'

# like $? (which still works in scripts but not as a single expression)
function ok() {
  print -P '%(?.ok.oops)'
}

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

alias ku="kubectl"

function contour-port-forward() {
  jj=0;
	for ii in $(kubectl -n heptio-contour get pod -l app=contour -o jsonpath={..metadata.name}); do
	  ((jj++));
		(kubectl -n heptio-contour port-forward $ii "$((9000+jj))":9001 &);
  done
}

# to copy the k8s dashboard bearer token
function ku-token() {
  kubectl -n kube-system get secret -o jsonpath='{.data.token}' \
    $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}') \
    | base64 --decode \
    | pbcopy
}
# services available through `kubeclt proxy`:
# http://localhost:8001/api/v1/namespaces/${NAMESPACE}/services/[${PROTOCOL}:]${SERVICE_NAME}[:${SERVICE_PORT}]/proxy
# As described here: https://kubernetes.io/docs/tasks/administer-cluster/access-cluster-services/#manually-constructing-apiserver-proxy-urls

function aws-decode() {
  aws sts decode-authorization-message --encoded-message "$1" \
  | jq ".DecodedMessage" -r \
  | jq
}

function raise-limits() {
  # in case we're hitting the maximum number of open files, let's raise it!
  # somehow this is invisible to ulimit, but who cares, it works on Mojave
  sudo launchctl limit maxfiles 65536 200000
  sysctl -a | grep files
}

# to list parameter groups:
#    aws rds describe-db-parameter-groups --query 'DBParameterGroups[*].[DBParameterGroupName]' --output text
# to compare a couple of them:
function aws-db-param-diff() {
  DB_QUERY='Parameters[*].[ParameterName,ParameterValue]'
  diff -u \
    <(aws rds describe-db-parameters --db-parameter-group-name $1 --query $DB_QUERY --output text) \
    <(aws rds describe-db-parameters --db-parameter-group-name $2 --query $DB_QUERY --output text)
}


################################################################
# zsh options and notes
################################################################

# reset options
#emulate -LR zsh

# make globbing case-insensitive
setopt NO_CASE_GLOB

# disable tab-substitution in globbing
# setopt GLOB_COMPLETE

# history setup from https://scriptingosx.com/2019/06/moving-to-zsh-part-3-shell-options/
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

setopt EXTENDED_HISTORY

SAVEHIST=5000
HISTSIZE=2000

# share history across multiple running zsh sessions
#setopt SHARE_HISTORY

# append to history
setopt APPEND_HISTORY

# append commands as they are typed, not at shell exit
#setopt INC_APPEND_HISTORY

# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST
# do not store duplications
setopt HIST_IGNORE_DUPS
#ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS

# make !! show the command
setopt HIST_VERIFY

# search history using CTRL+R, return (built-in)

# search history via up and down arrows
# https://unix.stackexchange.com/a/97844
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# correction
#setopt CORRECT
#setopt CORRECT_ALL

# comments with '#'
setopt interactivecomments

# replace spaces with %20, etc.
urlencode_a_string() {
   setopt localoptions extendedglob
   input=( ${(s::)1} )
   print ${(j::)input/(#b)([^A-Za-z0-9_.\!~*\'\(\)-\/])/%${(l:2::0:)$(([##16]#match))}}
}

# keep same directory on CMD-T in Terminal
autoload -U add-zsh-hook
if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]] && [[ -z "$INSIDE_EMACS" ]]; then
  # Emits the control sequence to notify Terminal.app of the cwd
  # Identifies the directory using a file: URI scheme, including
  # the host name to disambiguate local vs. remote paths.
  function update_terminalapp_cwd() {
    emulate -L zsh

    # Percent-encode the pathname.
    #local URL_PATH="$(omz_urlencode -P $PWD)"
    local URL_PATH="$(urlencode_a_string "$PWD")"
    [[ $? != 0 ]] && return 1

    # Undocumented Terminal.app-specific control sequence
    printf '\e]7;%s\a' "file://$HOST$URL_PATH"
  }

  # Use a precmd hook instead of a chpwd hook to avoid contaminating output
  add-zsh-hook precmd update_terminalapp_cwd
  # Run once to get initial cwd set
  update_terminalapp_cwd
fi

# note you can trace functions with `functions -t fnname`
#
# see here for more function and splitting tips and tricks:
# https://scriptingosx.com/2019/08/moving-to-zsh-part-8-scripting-zsh/


################################################################
# zsh auto-completion
################################################################

# enable the more advanced completion system
autoload -Uz compinit && compinit

# load bashcompinit for some old bash completions
autoload bashcompinit && bashcompinit

# autocompletion for kubectl (broken on 1.15.5)
#source <(kubectl completion zsh)


################################################################
# ...
################################################################
