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
    Plugin 'morhetz/gruvbox'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'Yggdroot/indentLine'

    " Syntax
    Plugin 'dense-analysis/ale'

    " Autocomplete
    Plugin 'ncm2/ncm2'
    Plugin 'roxma/nvim-yarp'
    Plugin 'ncm2/ncm2-bufword'
    Plugin 'ncm2/ncm2-path'
    Plugin 'ncm2/ncm2-jedi'

    " Autoformat
    Plugin 'Chiel92/vim-autoformat'

    " latex
    Plugin 'lervag/vimtex'
    Plugin 'Konfekt/FastFold'
call vundle#end()

filetype plugin indent on

syntax on
syntax enable

" colorscheme
let base16colorspace=256
let g:gruvbox_italic = '(1)'
highlight Comment cterm=italic
colorscheme gruvbox
set background=dark


" True Color Support if it's avaiable in terminal
"if has("termguicolors")
"    set termguicolors
"endif

if has("gui_running")
  set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:blocks
endif

set number                " line numbers
set relativenumber
set hidden
set noshowmode
set noshowmatch
set nolazyredraw

" Turn off backup
set nobackup
set noswapfile
set nowritebackup

" Search configuration
set ignorecase                    " ignore case when searching
set smartcase                     " turn on smartcase

" Tab and Indent configuration
set expandtab
set tabstop=4
set shiftwidth=0          " stay the same as tabstop

" vim-autoformat
noremap <F3> :Autoformat<CR>

" NCM2
augroup NCM2
  autocmd!
  " enable ncm2 for all buffers
  autocmd BufEnter * call ncm2#enable_for_buffer()

  " :help Ncm2PopupOpen for more information
  set completeopt=noinsert,menuone,noselect

  " When the <Enter> key is pressed while the popup menu is visible, it only
  " hides the menu. Use this mapping to close the menu and also start a new line.
  inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

  " vimtex for LaTex
  autocmd Filetype tex call ncm2#register_source({
            \ 'name': 'vimtex',
            \ 'priority': 8,
            \ 'scope': ['tex'],
            \ 'mark': 'tex',
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm2,
            \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            \ })
augroup END

" Ale
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'python': ['flake8']}

" Airline
let g:airline_left_sep  = ''
let g:airline_right_sep = ''
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = 'E:'
let airline#extensions#ale#warning_symbol = 'W:'

" better commands
set history=200           " keep 200 lines of command line history
set showcmd               " display incomplete commands
set wildmenu              " display completion matches in a status line
set ttimeout              " time out for key codes
set ttimeoutlen=100       " wait up to 100ms after Esc for special key

" positioning information
set ruler                 " show the cursor position all the time
set display=truncate      " show @@@ in the last line if it is truncated.
set scrolloff=5           " show a few lines of context around the cursor.

" annoying behaviour
set nrformats-=octal      " do not recognize octal numbers for inc and dec
set noundofile            " avoid temp file clutter
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,
            \.ilg,.inx,.out,.toc,.png,.jpg  " low priority suffixes

" better tabbing
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
