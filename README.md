Configs
=======

Copy or link the .* files into ~ or %userprofile%.

Update the submodules:

```
git submodule init
git submodule update
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



