" .vimrc
" Original from: Adam Greig.  Thanks Adam!
" https://github.com/adamgreig/dotvim
"
" Adjusted slightly by Hannah McLaughlin
" https://github.com/lochsh/dotvim

" vim is not vi
set nocompatible

" use a more compatible shell
if $SHELL =~ "fish"
    set shell=/bin/sh
endif

" load plugins via vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

set notitle
" Utilities
Plugin 'gmarik/Vundle.vim'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim'}
Plugin 'scrooloose/nerdcommenter'
Plugin 'wincent/Command-T'
Plugin 'sjl/gundo.vim'
Plugin 'briandoll/change-inside-surroundings.vim'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'lochsh/vim-kolor'
Plugin 'unblevable/quick-scope'

" Language/Syntax Support
Plugin 'kchmck/vim-coffee-script'
Plugin 'groenewege/vim-less'
Plugin 'vim-scripts/opencl.vim'
Plugin 'petRUShka/vim-pyopencl'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'rust-lang/rust.vim'
Plugin 'stephpy/vim-yaml'
Plugin 'wlangstroth/vim-racket'
Plugin 'racer-rust/vim-racer'
Plugin 'octol/vim-cpp-enhanced-highlight'

" To consider:
"Plugin 'scrooloose/nerdtree'
"Plugin 'tpope/vim-fugitive'
"Plugin 'jamessan/vim-gnupg'
call vundle#end()
filetype plugin indent on

" tabs and indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent

" behaviour
set backspace=indent,eol,start
" set mouse=a
set term=xterm-256color
set modelines=0
set textwidth=79
" set directory=~/.vim/tmp
autocmd FileType rust setlocal textwidth=99 colorcolumn=100


" appearance
set cursorline
set encoding=utf-8
set termencoding=utf-8
set colorcolumn=80
set wildmenu
set wildignore=*.pyc
set title
set showcmd
set showmode
set visualbell
set nofoldenable
set ruler
set number
set relativenumber
set listchars=tab:›\ ,trail:·
set list

" searching
set hlsearch
set incsearch
set showmatch
set smartcase
set ignorecase

" colors
syntax enable
let g:kolor_italic=1                 " Enable italic. Default: 1
let g:kolor_bold=1                   " Enable bold. Default: 1
let g:kolor_underlined=0             " Enable underline. Default: 0
let g:kolor_alternative_matchparen=0 " Gray 'MatchParen' color. Default: 0
colorscheme kolor

" key bindings
let mapleader = ","
map <silent> <leader><space> ;noh<CR>
" Highlight (line) to end of recently changed/yanked text
nnoremap <leader>v V`]
" Delete to _ register instead of default
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d
" Easier enter/leave paste mode
nmap <silent> <leader>o ;set paste<CR>
nmap <silent> <leader>O ;set nopaste<CR>
" Go to matching position with ', just line with `
nnoremap ' `
nnoremap ` '
" Use semicolon instead of colon to save shift key/fingers
noremap ; :
noremap : ;

" disable arrow keys and Delete that I may be reborn anew as a purist
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <Del> <NOP>

" plugin key bindings
nnoremap <F5> :GundoToggle<CR>
"map <F2> :NERDTreeToggle<CR>
"map <F3> :call FindInNERDTree()<CR>

" Unmap nerdcommenter's comment-invert, map instead change-inside-surroundings
nnoremap <leader>Ci <Plug>NERDCommenterInvert
nmap <script> <silent> <unique> <Leader>ci :ChangeInsideSurrounding<CR>

" filetype specific settings
autocmd FileType make setlocal noexpandtab
autocmd FileType ruby setlocal softtabstop=2 shiftwidth=2
autocmd FileType html setlocal softtabstop=2 shiftwidth=2
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd BufNewFile,BufRead *.less set filetype=less
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
autocmd BufNewFile,BufRead *.json set filetype=javascript
autocmd BufNewFile,BufRead *.json set tw=0
autocmd BufNewFile,BufRead *.ebnf set filetype=ebnf
autocmd BufNewFile,BufRead *.cl set filetype=opencl
autocmd BufNewFile,BufRead *.sls set filetype=yaml
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=pandoc
augroup end

" supertab
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview
highlight Pmenu ctermbg=238 gui=bold

" syntastic
let g:syntastic_python_checkers = ['flake8', 'pylint']
let g:syntastic_python_flake8_args = "--max-complexity 11"
let g:syntastic_python_pylint_args = "-j8 -E"

let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_cpplint_exec = 'cppcheck'
let g:syntastic_cpp_checkers = ['cppcheck', 'gcc']

let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1

let g:syntastic_enable_highlighting = 1
let g:syntastic_enable_signs = 1

let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_error_symbol = "😞"
let g:syntastic_style_warning_symbol = "😕"

" pandoc
let g:pandoc_use_hard_wraps = 1
let g:pandoc#formatting#mode = 'ha'

" always show a powerline
set laststatus=2
" disable the amazingly annoying delay reverting to command mode
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif
