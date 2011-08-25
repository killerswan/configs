" Kevin's GVIM config

filetype off
call pathogen#runtime_append_all_bundles()

syntax on

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
set ruler

set nocompatible  "does this do anything? :P


"clojure
"let vimclojure#HighlightBuiltins = 1
"let vimclojure#ParenRainbow = 1



"stop pressing shift all the time
nnoremap ; :


"set background=dark
"colorscheme macvim
"colorscheme two2tango
colorscheme summerfruit


if has("gui_running")

   if has("gui_gtk2")
      set guifont=Inconsolata\ 14
      set printfont=Inconsolata:h9
   elseif has("gui_win32")
      set guifont=Consolas:h9
      set printfont=Consolas:h9
   endif
   
   "colorscheme macvim
   "set background=dark

   "colorscheme mod_tcsoft
   "set background=light
   
   colorscheme summerfruit

   " GUI OPTIONS
   set guioptions-=T    " no toolbars
   "set guioptions+=t   " tear-off menus
   "set guioptions+=b   " bottom scrollbar
   set guioptions-=r    " remove right scrollbar


   " filetypes in menu by default
   let do_syntax_sel_menu = 1|runtime! synmenu.vim|aunmenu &Syntax.&Show\ filetypes\ in\ menu

endif


" F# syntax highlighting
au BufRead,BufNewFile *.fs set filetype=fs
au BufRead,BufNewFile *.fsi set filetype=fs
au BufRead,BufNewFile *.fsx set filetype=fs


