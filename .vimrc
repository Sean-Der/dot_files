"Enable the colorscheme only if we can have full color support
if $TERM =~ '^linux'
  set t_Co=8
else
  set t_Co=256
  colorscheme 256_jungle
  "Show tabs broken with tabs + spaces
  let g:indent_guides_auto_colors = 0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=238
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=239
  autocmd VimEnter * IndentGuidesEnable
endif

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
set tabstop=4
set shiftwidth=4
set expandtab

"Pathogen
call pathogen#infect() 

"Create a mapping for easy ncmpcpp access
nmap mpd :!ncmpcpp -h /home/sean/.mpd/socket<CR><CR>

"better window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

let mapleader=","
"for ctags
nmap <leader>ct :!exctags --extra=+f -R *<CR><CR>

"jump to definition
nmap <leader>sd :tjump <c-r>=expand("<cword>")<CR><CR>

"svn blame
vmap gl :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

"jump back from definition
nmap <leader>rd <C-t>
"Lazy paste fix
xnoremap p pgvy
"during split close buffer
nmap <leader>bd :bn <bar> :bd# <CR>

"let g:slimv_swank_cmd = '! urxvt -e sbcl --load /home/sean/.vim/slime/start-swank.lisp &'
set wildignore=*.fasl

noremap <leader>o <Esc>:CommandT<CR>
noremap <leader>O <Esc>:CommandTFlush<CR>
noremap <leader>m <Esc>:CommandTBuffer<CR>
