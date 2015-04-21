" Kevin's GVIM config

" default .vim/bundle/
execute pathogen#infect()
execute pathogen#infect('~/code/configs/bundle/{}')
execute pathogen#infect('C:/code/configs/bundle/{}')

filetype off
syntax on
filetype plugin on

set softtabstop=4
set shiftwidth=4
set tabstop=4
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
"set spell

" ctags: tags file in current dir, dir of file, then walk up to root
set tags=tags,./tags;/

"stop pressing shift all the time
"nnoremap ; :

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
      set guifont=Consolas:h14  " 10 usually...  12 is pretty, though
      set printfont=Consolas:h9

      source $VIMRUNTIME/mswin.vim
      behave mswin "CTRL X, CTRL C, CTRL V
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

" window split navigation (append <Bar> to maximize)
nnoremap <c-h> <c-w>h<c-w>
nnoremap <c-j> <c-w>j<c-w>
nnoremap <c-k> <c-w>k<c-w>
nnoremap <c-l> <c-w>l<c-w>

" selection sorting: SHIFT-V, then highlight with j, then :sort

let NERDTreeShowBookmarks=1
let NERDTreeIgnore = ['\.pyc$']
" saving a bookmark: `:Bookmark XYZ`

"NERDTree by default
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"To use :E instead of :NERDTree by default:
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | E | endif

" Tern needs this and Node on the path
"let g:ycm_path_to_python_interpreter = 'C:\Python27-32bit\python.exe'

" Tern shortcuts after <leader> (AKA \): td, tb, tt, td, tpd, tsd, ttd, ttd,
" tr, tR
let g:tern_map_keys=1

" Tern function hints
let g:tern_show_argument_hints="on_hold"

" CtrlP options
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPLastMode'
" toggle between extensions with <c-f>
let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']

" grep.vim options
let Grep_Path       = '"C:\Program Files (x86)\Git\bin\grep.exe"'
let Grep_Find_Path  = '"C:\Program Files (x86)\Git\bin\find.exe"'
let Grep_Xargs_Path = '"C:\Program Files (x86)\Git\bin\xargs.exe"'
let Grep_Egrep_Path = '"C:\Program Files (x86)\Git\bin\egrep"'
let Grep_Skip_Dirs  = 'out .git Output .venv *.egg-info RCS CVS SCCS'
let Grep_Skip_Files = 'tags *.swp *.swo *.exe *~ *,v s.* *.o *.so *.tmp *.lock .DS_Store *.dSYM *.dylib *.rlib *.pyc *.pyo'



call unite#custom#profile('source/file,source/file_rec,source/grep,source/gtags', 'context', {'no_quit': 1, 'ignorecase': 1, 'keep_focus': 1 })

"SPACE-/ to grep
nnoremap <space>/ :Unite grep:.<cr>

"\/ to grep
nnoremap <silent><leader>/ :<c-u>Unite grep:.<cr>

"CTRL-F to find files (and use insert mode to narrow results)
nnoremap <silent><c-f> :<c-u>Unite file_rec:.<cr>

"\ll to resume
nnoremap <silent><leader>ll :<c-u>UniteResume<cr>

" background :Ack
let g:ack_use_dispatch = 1

