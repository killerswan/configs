Configs
=======

Confirm that [.vimrc](.vimrc) refers to the bundle directory.  Then update the submodules and copy or link config files into `~` or `%userprofile%`:

```bash
git submodule update --init

ln -s $(pwd)/.vimrc        ~/.vimrc
ln -s $(pwd)/.ackrc        ~/.ackrc
ln -s $(pwd)/.gitconfig    ~/.gitconfig
ln -s $(pwd)/.hgrc         ~/.hgrc
ln -s $(pwd)/.bashrc       ~/.bashrc
ln -s $(pwd)/.bash_profile ~/.bash_profile
ln -s $(pwd)/.inputrc      ~/.inputrc

ln -s $(pwd)/vim-pathogen/autoload/pathogen.vim  ~/.vim/autoload/pathogen.vim
# on Windows, try `%userprofile%\vimfiles` instead of `~/.vim`
```


[Ack](http://beyondgrep.com/install/)
===

On platforms with cpan, to set up Ack:

```
sudo cpan App::Ack
```

Or on OS X:
```
brew install ack
```

[Ag](https://github.com/ggreer/the_silver_searcher)
==

On OS X, to install Ag:
```
brew install the_silver_searcher
```

I also had to chown /usr/local/lib/pkgconfig, but that seems unrelated...


Vim: Tern
=========

Run `npm install` in the package, and make sure Node.js and Python (matching Vim's architecture) are available.


Vim: vimproc
============

Compile this with `make` or, e.g., `make ARCHS='i386 x86_64'`.  (Required for grepping in Unite.vim.)


Vim: F# binding
===============

See [fsharpbinding's Vim README](https://github.com/fsharp/fsharpbinding/blob/master/vim/README.mkd).



