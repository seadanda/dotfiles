set nocompatible "use vim settings rather than vi settings

set backspace=indent,eol,start " more powerful backspacing

if &t_Co > 2 || has("gui_running")
    syntax on    " syntax highlighting
    set hlsearch " highlight last used search pattern
endif

" Don't use Ex mode, use Q for formatting.
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

if has('mouse')
    set mouse=a " scroll and click
endif

augroup vimStartup
    au!
    " When editing a file, jump to the last known cursor position.
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif
augroup END

filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim

call vundle#begin()
  Plugin 'tpope/vim-fugitive'
  Plugin 'Yggdroot/indentLine'
  Plugin 'morhetz/gruvbox'
  Plugin 'vim-airline/vim-airline'
  Plugin 'dense-analysis/ale'
call vundle#end()

set noshowmode " let airline do this
let g:ale_completion_enabled = 1
"let g:ale_python_flake8_options = '--ignore=E402,F403,F405,W504 --max-line-length=120'

filetype plugin on

augroup vimrcEx
    au!
    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78
augroup END

" better commands
set history=200           " keep 200 lines of command line history
set showcmd               " display incomplete commands
set wildmenu              " display completion matches in a status line
set ttimeout              " time out for key codes
set ttimeoutlen=100	      " wait up to 100ms after Esc for special key

" positioning information
set number                " hybrid line numbers
set ruler                 " show the cursor position all the time
set display=truncate      " show @@@ in the last line if it is truncated.
set scrolloff=5           " show a few lines of context around the cursor.

" annoying behaviour
set nrformats-=octal      " do not recognize octal numbers for inc and dec
set noundofile            " avoid temp file clutter
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,
            \.ilg,.inx,.out,.toc,.png,.jpg  " low priority suffixes

" better tabbing
set tabstop=4             " default 
set shiftwidth=0          " stay the same as tabstop
set expandtab             " keep alignment constant between editors
set smarttab              " delete as tab
"autocmd FileType vhd,vhdl,html,tex setlocal tabstop=2 " 2 space tabs

" more natural splits
set splitbelow
set splitright
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-h> <c-w><c-h>
nnoremap <c-l> <c-w><c-l>

" mappings
let mapleader = ","
let maplocalleader = "\\"
" faster insert mode escape
inoremap jk <esc> 
" change and source vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" move lines up and down
nnoremap - ddp
nnoremap _ ddkP
" start and end of lines on home row
nnoremap H ^
nnoremap L $
" don't move after #
nnoremap # #<c-o>
" replace last searched string
nnoremap <leader>rl :%s///g<left><left>
" remove lines in insert mode
inoremap <c-d> <esc>ddi
" uppercase word under cursor in insert mode
inoremap <c-u> <esc>viwUi
" wrap visually selected text in various symbols
vnoremap <leader>{ c{}<esc>P
vnoremap <leader>( c()<esc>P
vnoremap <leader>" c""<esc>P
vnoremap <leader>' c''<esc>P

" autocomplete and lint
let g:ale_linters = {'python': ['flake8', 'pyls'], 'shell': ['language-server'], 'vhdl': ['vcom']}
let g:ale_vhdl_vcom_options = '-93 -quiet -lint -work /home/donal/vhdevel/readout40-firmware/velo/data_processing/pre_router/simulation/libraries/work'

" theme
"set termguicolors " kills italic comments!
colorscheme gruvbox
set background=dark
let g:gruvbox_italic = '(1)'
highlight Comment cterm=italic

" Snakefile syntax highlighting
augroup snakefiledetect
    au BufRead,BufNewFile Snakefile set filetype=python
augroup END

" comment out line of code
autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
autocmd FileType c      nnoremap <buffer> <localleader>c ^v$hc/**/<esc>hP
autocmd FileType cpp    nnoremap <buffer> <localleader>c I//<esc>
autocmd FileType vhdl   nnoremap <buffer> <localleader>c I--<esc>
autocmd FileType sh     nnoremap <buffer> <localleader>c I#<esc>

" set case insensitive search for vhdl
autocmd FileType vhdl :set ignorecase

" autoformat code before write
"autocmd BufWritePre *.cpp,*.c,*.h,*.py,*.tex gg=G
" make tex files on write
"autocmd BufWritePre *.tex :lcd %:p:h
"autocmd BufWritePost *.tex :silent :make

" show tabs and whitespace
set list
set listchars=tab:!·,trail:·

" Strip trailing whitespace
nnoremap <leader>sw :%s/\s\+$//e<cr>

" snippets
" ifs
"autocmd FileType python :iabbrev <buffer> iff if:<left>
"autocmd FileType c,cpp  :iabbrev <buffer> iff if () {<cr>}<esc>kkA<left><left><left>
"autocmd FileType vhdl   :iabbrev <buffer> iff if then<cr>end if;<esc>k$hbhi
"
"" vhdl snippets
"autocmd FileType vhdl   :iabbrev <buffer> ventity entity ENTNAME is<cr>port(<cr><cr>);<cr>end entity ENTNAME<cr><cr>architecture rtl of ENTNAME is<cr>--components<cr><cr>--signals<cr><cr>begin<cr>--component instantiation<cr><cr>--processes<cr><cr>end rtl;<esc>
