Copy the .* files into ~ or %userprofile%.

Update the submodules:
```
git submodule init
git submodule update
```

Make sure that `.vimrc` points to this `bundle` directory,
and copy the `vim-pathogen/autoload/pathogen.vim` file into
`~/.vim/autoload/pathogen.vim`.

Then, if you want, copy the latest Rust syntax files
into `~/.vim/bundle/rust-vim` or elsewhere.

To set up Ack, on a system with cpan:
```
sudo cpan App::Ack
```
