#! /bin/zsh

ls -alh ~/.atom

mkdir -p atom

echo "Saving packages in use..."
apm list --installed --enabled --bare > atom/apm-packages.txt

echo "Saving *.coffee and *.cson files from ~/.atom ..."
cp ~/.atom/*.cson atom/
cp ~/.atom/*.coffee atom/
