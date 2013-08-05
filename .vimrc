" Kevin's GVIM config

" default .vim/bundle/
execute pathogen#infect()

" custom
execute pathogen#infect('~/code/configs/bundle/{}')

filetype off
syntax on
filetype plugin on

set softtabstop=3
set shiftwidth=3
set tabstop=3
set expandtab
set noautoindent

"set visualbell
"set noerrorbells
set number
set hlsearch
set ignorecase
"set nowrap
set fileformat=unix
set display=uhex
set ruler " otherwise, ctrl-g should show it
set laststatus=2 " show statusline even for single buffer

" ctags: tags file in current dir, dir of file, then walk up to root
set tags=tags,./tags;/

"stop pressing shift all the time
nnoremap ; :

if has("gui_running")

   if has("gui_gtk2")
      set guifont=Inconsolata\ 14
      set printfont=Inconsolata\ 9
   endif

   if has("gui_macvim")       "possibly also with gtk2, hence not elseif?
      set guifont=Menlo:h15
      set printfont=Menlo:h9
   endif

   if has("gui_win32")
      set guifont=Consolas:h10
      set printfont=Consolas:h9
   endif
   
   colorscheme summerfruit

   set guioptions-=T    " no toolbars
   "set guioptions+=t   " tear-off menus
   "set guioptions+=b   " bottom scrollbar
   "set guioptions-=r   " remove right scrollbar

   " filetypes in menu by default
   let do_syntax_sel_menu = 1|runtime! synmenu.vim|aunmenu &Syntax.&Show\ filetypes\ in\ menu
else
   behave xterm " from cygwin .vimrc
endif

" UTF-8
if has("multi_byte")
   if &termencoding == ''
      let &termencoding = &encoding
   endif
   set encoding=utf-8
   set fileencodings=ucs-bom,utf-8,default,latin1
   setglobal fileencoding=utf-8
   "setglobal bomb
else
   echomsg 'Warning: Multibyte support is not compiled-in.'
endif

if has("statusline")
   set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
endif

