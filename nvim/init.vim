call plug#begin(stdpath('data').'/plugged')

Plug 'junegunn/goyo.vim'                       "zen mode
Plug 'ervandew/supertab'                       "basic coc
Plug 'preservim/nerdtree'                      "nerdtree
Plug 'sheerun/vim-polyglot'                    "language pack
Plug 'Raimondi/delimitMate'                    "autoclosing of brackets
Plug 'uiiaoo/java-syntax.vim'                  "java syntax highlighting
Plug 'ryanoasis/vim-devicons'                  "file icons for airline/nerdtree
Plug 'vim-syntastic/syntastic'                 "syntax check
Plug 'vim-airline/vim-airline'                 "vim status bar
Plug 'chriskempson/base16-vim'                 "base16 colorscheme
Plug 'vim-airline/vim-airline-themes'          "airline themes
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' "nerdtree-syntax-highlighting
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} "markdown previewer

"Plug 'dawikur/base16-vim-airline-themes'      "base16 airline
"Plug 'rafi/awesome-vim-colorschemes'          "extra colorschemes

call plug#end()

"Favourable Colorschemes :
"brewer, bright, chalk, darktooth, dracula, synth-midnight-dark, snazzy, seti, material, google-dark, harmonic, horizon-dark

"Air-line
let g:airline_powerline_fonts = 1
let g:airline_theme = 'tomorrow'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

"Unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

"Airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

"Always display
set laststatus=2
set showtabline=2

"Highlight comments
highlight Comment cterm=italic

"256-color
set background=dark
set t_Co=256

"True colours
if (has("termguicolors"))
 set termguicolors
endif

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"Colorscheme
colorscheme base16-google-dark

"Turn off colors for variable names in java
highlight link JavaIdentifier NONE

"Splits at bottom and right
set splitbelow splitright

"NerdTree toggle & pos
map <C-N> :NERDTreeToggle<return>
let g:NERDTreeWinPos = "right"

"Filetype specific settings
autocmd BufNewFile,BufRead,filetype *.py,*.java,*.cpp,*.c,*.h,*.js,*.css,*.html,*.php,*.jsp
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=120 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

"Syntax highlighting
syntax on

"Folding
set foldmethod=indent
set foldlevel=99

set noshowmode                           "show mode
set omnifunc=syntaxcomplete#Complete     "set completion
set noswapfile                           "turn of swapfile
set autoindent                           "enable autoindent
set encoding=utf-8                       "Set defualt encoding
set lbr                                  "doesn't wrap mid-word
set ruler                                "show the cursor positon
set showcmd                              "show incomplete command
set clipboard+=unnamedplus               "enabling system clipboard
set showmatch                            "highlights matching brackets
set hlsearch                             "highlights matching searcher
set number relativenumber                "set number and relative number
set backspace=indent,eol,start           "let backspace delete over lines
set smartindent                          "allow vim to guess indentation
set incsearch                            "search as characters are entered
set scrolloff=4                          "scroll offset when pressed z + <Enter>
set ignorecase                           "searches while ignoring case of pattern
set wildmenu                             "auto completion of commands with TAB

"After a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

"Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e

"Split nav with Alt+Shift as modifier
nnoremap <M-J> <C-W><C-J>
nnoremap <M-K> <C-W><C-K>
nnoremap <M-L> <C-W><C-L>
nnoremap <M-H> <C-W><C-H>

"Enable folding with space
nnoremap <space> za

"Clears highlights
nnoremap // :noh<return>

"Switching buffers with alt+,/alt+.
nnoremap <M-.> :bnext!<return>
nnoremap <M-,> :bprevious!<return>

"Deleting buffers with Alt+Shift+q
nnoremap <M-S-Q> :bdelete %<return>

"Always opens terminal in insert mode
autocmd TermOpen * startinsert

"Mapping Esc to <Ctrl-\><Ctrl-N> for leaving terminal
autocmd TermClose * tnoremap <Esc> <C-\><C-N>

"Setting shell to powershell
set shell=powershell shellquote=( shellpipe=\| shellxquote=
set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
set shellredir=\|\ Out-File\ -Encoding\ UTF8

"Run code if compilation successfull
autocmd filetype c nnoremap <f9> :w <bar> :terminal gcc % -o %:r ; if ($?) { %:r:s?^?.\\? } <cr>
autocmd filetype cpp nnoremap <f9> :w <bar> :terminal g++ -std=c++11 -O2 -Wall % -o %:r ; if ($?) { %:r:s?^?.\\? } <cr>
autocmd filetype java nnoremap <f9> :w <bar> :terminal javac % ; if ($?) { java -classpath %:h %:t:r } <cr>
autocmd filetype python nnoremap <f9> :w <bar> :terminal python % <cr>

"autocmd filetype c nnoremap <f9> :w <bar> terminal !make %:r && .%:r <cr>
