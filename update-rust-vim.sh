#!/bin/sh

DEST=~/.vim/bundle/rust-vim

rm -rf "$DEST"
mkdir -p -v "$DEST"
cp -R ~/code/rust/src/etc/vim/ "$DEST"

