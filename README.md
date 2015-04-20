Configs
=======

Copy or link the .* files into ~ or %userprofile%.

Update the submodules:

```
git submodule init
git submodule update
```


Ack and Ag
==========

To set up Ack, on a system with cpan:

```
sudo cpan App::Ack
```

On OS X, to install Ag:
```
brew install the_silver_searcher
```

I also had to chown /usr/local/lib/pkgconfig, but that seems unrelated...


VIM Pathogen setup
==================

Make sure that `.vimrc` points to this `bundle` directory,
and copy the `vim-pathogen/autoload/pathogen.vim` file into
`~/.vim/autoload/pathogen.vim`.


VIM packages
============

If you want, copy the latest Rust syntax files
into `~/.vim/bundle/rust-vim` or elsewhere.

To setup Tern, make sure an architecture-matched Python, and Node.js are available, and run `npm install` in the package.

To setup Unite and vimproc, compile the package with `make ARCHS='i386 x86_64'`.




