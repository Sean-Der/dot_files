colorscheme 256_jungle
"Show tabs broken with tabs + spaces
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=238
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=239
autocmd VimEnter * IndentGuidesEnable

syntax on

set nowrap "line wrapping
set title "set the term title
set showcmd "show cur command
set showmatch "show matching bracket
set hidden "no nag screens on tag jump

"Better file handling
set nobackup
set noswapfile
set autowrite

set backspace=indent,eol,start " allow backspacing over everything in insert mode

set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set ignorecase
set smartcase 

"Tabs
filetype plugin indent on
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

"Pathogen
call pathogen#infect() 

"Create a mapping for easy ncmpcpp access
nmap mpd :!ncmpcpp -h /home/sean/.mpd/socket<CR><CR>

"Leaving modes in Emacs+EVIL feels right
map <C-g> <Esc>
map! <C-g> <Esc>

"better window navigation
map h <C-w>h
map j <C-w>j
map k <C-w>k
map l <C-w>l

let mapleader=","

nmap <leader>r :Rgrep <CR><CR>

"ctags
nmap <leader>ct :!exctags --extra=+f -R *<CR><CR>
nmap <leader>st :tjump <c-r>=expand("<cword>")<CR><CR>
nmap <leader>rt <C-t>

"during split close buffer
nmap <leader>bd :bn <bar> :bd# <CR>

"Command T
noremap <leader>o <Esc>:CommandT<CR>
noremap <leader>O <Esc>:CommandTFlush<CR>
noremap <leader>m <Esc>:CommandTBuffer<CR>

let g:yankring_history_dir = '$HOME/.vim'

:autocmd BufWritePost *.go :silent Fmt
