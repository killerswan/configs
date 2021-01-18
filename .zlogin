
clear  # dismiss last login message

if [[ "$(which kubectl)" != "$HOME/bin/kubectl" ]]; then
  echo "Something has installed an unwanted kubectl!"
  ls -alh "$(which kubectl)"
fi
