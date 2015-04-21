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


Ack
===

On platforms with cpan, to set up Ack:

```
sudo cpan App::Ack
```

Ag
==

On OS X, to install Ag:
```
brew install the_silver_searcher
```

I also had to chown /usr/local/lib/pkgconfig, but that seems unrelated...


Pathogen setup
==============

Make sure that `.vimrc` points to this `bundle` directory,
and copy the `vim-pathogen/autoload/pathogen.vim` file into
`~/.vim/autoload/pathogen.vim`.


Vim: Tern
=========

To setup Tern, make sure an architecture-matched Python and Node.js are available, and run `npm install` in the package.


Vim: vimproc
============

Unite.vim requires this, which can be compiled with `make` or, e.g., `make ARCHS='i386 x86_64'`.


Vim: F# binding
===============

See [fsharpbinding's Vim README](https://github.com/fsharp/fsharpbinding/blob/master/vim/README.mkd).



