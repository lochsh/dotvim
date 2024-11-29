" .vimrc
" Originally forked from: Adam Greig.  Thanks Adam!
" https://github.com/adamgreig/dotvim
"
" Adjusted substantially by Hannah McLaughlin
" https://github.com/lochsh/dotvim

" vim is not vi
set nocompatible

" use old regex engine instead of outrageously slow new one
" this one stupid line is necessary for vim to be usable on OS X at least, for
" versions above 8.0.0642
set re=1

" use a more compatible shell
if $SHELL =~ "fish"
    set shell=/bin/sh
endif

" support 24-bit colours
"if exists('+termguicolors')
  "let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  "let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  "set termguicolors
"endif

" fzf path
set rtp+=~/.fzf/bin/fzf

set notitle

" rainbow parens
let g:rainbow_active = 1
let g:rainbow_ctermfgs = [
    \ 'brown',
    \ 'Darkblue',
    \ 'darkgray',
    \ 'darkgreen',
    \ 'darkcyan',
    \ 'darkmagenta',
    \ 'gray',
    \ 208,
    \ 'Darkblue',
    \ 'darkgreen',
    \ 'darkcyan',
    \ 198,
    \ ]

" Netrw settings
let g:netrw_bufsettings = 'noma nomod nu relnu nowrap ro nobl'

filetype plugin indent on

" ignore certain file extensions for fzf
command! -bang -nargs=? -complete=dir
  \ Files call fzf#vim#files(<q-args>,
  \ {'source': 'rg --files -g "!*.{png,bin,dcm,md5,xml,IMA,o,gcno}"'}, <bang>0)

" tabs and indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent

" public/private in C++ at 1 space indent
set cindent
set cinoptions=g1

" swp files
set directory=/tmp

" behaviour
set backspace=indent,eol,start
set term=xterm-256color
set modelines=0
set textwidth=79
autocmd FileType rust setlocal textwidth=99 colorcolumn=100
autocmd FileType python setlocal textwidth=88 colorcolumn=89

set matchpairs+=<:>

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
colorscheme kolor
let g:airline_theme='bubblegum'

" cpp highlighting
let g:cpp_class_decl_highlight = 1

" semantic highlighting
" green, cyan, dark pink, blue, yellow, light pink, purple, orange, light
" orange, light green, royal blue, warm yellow, cornflower blue, deep pink
let g:semanticTermColors = [42,80,162,75,186,176,141,208,180,121,63,222,69,198]

let g:fzf_action = {
   \ 'ctrl-y': ':%w !xclip -selection clipboard',
\}

" key bindings
let mapleader = " "
map <silent> <leader><space> ;noh<CR>
" Highlight (line) to end of recently changed/yanked text
nnoremap <leader>v V`]
" Easier enter/leave paste mode
nmap <silent> <leader>o ;set paste<CR>
nmap <silent> <leader>O ;set nopaste<CR>
" Easier fzf
nmap <silent> <leader>f ;Files .<CR>
nmap <silent> <leader>h ;BCommits<CR>
nmap <silent> <leader>t ;Commits<CR>
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
autocmd FileType python set omnifunc=python3complete#Complete
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
autocmd BufNewFile,BufRead poetry.lock set filetype=toml
autocmd BufNewFile,BufRead *.service set filetype=systemd
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=pandoc
augroup end
au BufRead,BufNewFile *.qasm set filetype=qasm

" supertab
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview
highlight Pmenu ctermbg=238 gui=bold

" ALE
let g:ale_sign_error = "✗"
let g:ale_sign_warning = "⚠️"
let g:ale_style_error_symbol = "😞"
let g:ale_style_warning_symbol = "😕"
let g:ale_linters = {"rust": ["analyzer"], "cpp": ["cppcheck", "gcc"], "c": ["cc"], "python": ["ruff"] }
let g:ale_fixers = {"python": ["ruff"] }
let g:ale_cpp_cc_options = "-std=c++14 -Wall -Wextra -stdlib=libc++"
let g:ale_c_cc_options = "-std=c99 -Wall -Wextra"
let g:ale_python_ruff_options = "--select E,F,B,SIM"
let g:ale_rust_analyzer_config = {
    \ "checkOnSave":    { "allTargets": v:false },
\}
let g:ale_virtualtext_cursor = 'disabled'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

" Jedi
let g:jedi#popup_on_dot = 0
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#show_call_signatures = 0

" pandoc
let g:pandoc_use_hard_wraps = 1
let g:pandoc#formatting#mode = 'ha'
let g:pandoc#syntax#style#emphases = 0

" always show a powerline
set laststatus=2
let g:airline_powerline_fonts = 1"

" disable the amazingly annoying delay reverting to command mode
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif
