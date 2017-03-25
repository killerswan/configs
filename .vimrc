" Kevin's GVIM config

" note: to see a config as already set: `echo &name`

" note: if on Windows the vim stuff resides at %userprofile%\vimfiles,
" it may be necessary from Git Bash to link ~/.vim to that dir

" default .vim/bundle/
execute pathogen#infect()
execute pathogen#infect('~/code/configs/bundle/{}')
execute pathogen#infect('C:/code/configs/bundle/{}')

filetype off
syntax on
filetype plugin on


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
      set guifont=Menlo:h17
      set printfont=Menlo:h9
      set lines=50
      set columns=120
   endif

   if has("gui_win32")
      set guifont=Consolas:h12  " 10 usually... 12 is pretty, and 14 needs glasses
      set printfont=Consolas:h9

      source $VIMRUNTIME/mswin.vim
      behave mswin "CTRL X, CTRL C, CTRL V

      " Tern needs this and Node on the path
      "let g:ycm_path_to_python_interpreter = 'C:\Python27-32bit\python.exe'
      "let g:ycm_path_to_python_interpreter = 'C:\Python27\python.exe'
      "let g:ycm_path_to_python_interpreter = '/usr/bin/python'

   endif
   
   colorscheme summerfruit

   set guioptions-=T    " no toolbars
   "set guioptions+=t   " tear-off menus
   "set guioptions+=b   " bottom scrollbar
   "set guioptions-=r   " remove right scrollbar

   " filetypes in menu by default
   let do_syntax_sel_menu = 1|runtime! synmenu.vim|aunmenu &Syntax.&Show\ filetypes\ in\ menu
else
   behave xterm
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
    set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k
    set statusline+=\ %-14.(%l,%c%V%)
    set statusline+=\ %P
    "set statusline+=\ %#warningmsg#
    "set statusline+=%{SyntasticStatuslineFlag()}
    "set statusline+=%*

endif

" window split navigation (append <Bar> to maximize)
" CTRL-...
nnoremap <c-h> <c-w>h<c-w>
nnoremap <c-j> <c-w>j<c-w>
nnoremap <c-k> <c-w>k<c-w>
nnoremap <c-l> <c-w>l<c-w>
" CMD-...
nnoremap <d-h> <c-w>h<c-w>
nnoremap <d-j> <c-w>j<c-w>
nnoremap <d-k> <c-w>k<c-w>
nnoremap <d-l> <c-w>l<c-w>

" selection sorting: SHIFT-V, then highlight with j, then :sort

let NERDTreeShowBookmarks=1
let NERDTreeIgnore = ['\.pyc$', '\.swp$']
let NERDTreeShowHidden=1
" saving a bookmark: `:Bookmark XYZ`

"NERDTree by default
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"To use :E instead of :NERDTree by default:
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | E | endif

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
if has("gui_win32")
  let Grep_Path       = '"C:\Program Files (x86)\Git\bin\grep.exe"'
  let Grep_Find_Path  = '"C:\Program Files (x86)\Git\bin\find.exe"'
  let Grep_Xargs_Path = '"C:\Program Files (x86)\Git\bin\xargs.exe"'
  let Grep_Egrep_Path = '"C:\Program Files (x86)\Git\bin\egrep"'
endif
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

" background calls to Ack
let g:ack_use_dispatch = 1

nnoremap <silent><leader>r :<c-u>Ack <cword><cr>

" combine multiple checkers
let g:syntastic_aggregate_errors = 1

" recommended n00b defaults
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Syntastic languages
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_pony_checkers = ['currycomb']
"let g:syntastic_pony_ponyc_exe = '/usr/local/bin/ponyc'
let g:syntastic_cpp_checkers = []
"let g:syntastic_elixir_checkers = ['elixir']
"let g:syntastic_enable_elixir_checker = 1
"let g:syntastic_elixir_elixir_args = '+elixirc'

" debugging
"let g:syntastic_debug = 63
"let g:syntastic_debug_file = '~/syntastic.log'

" paths for Syntastic
let g:syntastic_python_python_exec = '/usr/local/bin/python3'
"let g:syntastic_python_python_exec = '/usr/bin/python'

" F# / FSharp support
"let g:fsharpbinding_debug = 1
"let g:fsharp_xbuild_path = "C:/Windows/Microsoft.NET/Framework64/v4.0.30319/MSBuild.exe"
"let g:fsharp_test_runner = ""
"let g:fsharp_completion_helptext = 0 "off

" try :YATE or :YATEStationary to search by tags
"\t to :YATEStationary
nnoremap <silent><leader>t :<c-u>YATEStationary<cr>
" note, it would be nice to add an optional keyword to the command,
" and in this mapping insert <cword>

" YATE history autocompletion with <c-x><c-u>
let g:YATE_enable_real_time_search = 0  " make it stop eating me

let g:hdevtools_options = '-g-isrc -g-Wall'
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>

" hide carriage returns
match Ignore /\r/
"to switch to DOS mode:             e ++ff=dos
"followed by this to replace them:  setlocal ff=unix
"or this:                           %s/\s\r*$//g


" basic stuff should be down here to avoid anything evil, above, overriding it
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab
set noautoindent
set backspace= " almost like vi, don't backspace through indent,eol,start

"set visualbell
"set noerrorbells
set number
set hlsearch
set ignorecase
"set nowrap
set fileformat=unix
set fileformats=unix
set display=uhex
set ruler " otherwise, ctrl-g should show it
set laststatus=2 " show statusline even for single buffer
"set spell
