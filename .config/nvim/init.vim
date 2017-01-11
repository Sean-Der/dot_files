colorscheme 256_jungle
syntax on

set nowrap "line wrapping
set title "set the term title
set showcmd "show cur command
set showmatch "show matching bracket
set autochdir "\:e is relative to current file

"Better file handling
set nobackup
set noswapfile
set autowrite

"Perf improvements
set nocursorcolumn
set nocursorline
syntax sync minlines=256

set ignorecase
set smartcase
set mouse=""

"Pathogen
call pathogen#infect()
Helptags

"Leaving modes in Emacs+EVIL feels right
map <C-g> <Esc>
map! <C-g> <Esc>
cmap <C-g> <Esc>
imap <C-g> <Esc>
tmap <C-g> <C-\><C-n>

let mapleader=","

nmap <leader>r <ESC>:Grepper<CR>

nmap <leader>o :CtrlP<CR>
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>m :CtrlPMRU<CR>

"ctags
nmap <leader>tc :!ctags --extra=+f -R *<CR><CR>
set tags=tags;

"Hitting tab in visual mode fixes indentation on the selected lines
vmap <Tab> =

set wildignore=*.o,*#,*.fasl

set wildmode=longest,list,full

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
set laststatus=2

autocmd! BufWritePost * Neomake
let g:neomake_open_list = 2
let g:neomake_warning_sign = {'text': '⚠>', 'texthl': 'NeomakeWarningMsg'}
hi NeomakeWarningMsg guifg=#d70000 guibg=#8a8a8a guisp=#8a8a8a gui=NONE ctermfg=100 ctermbg=233 cterm=NONE
let g:neomake_error_sign = {'text': '✖', 'texthl': 'NeomakeErrorMsg'}
hi NeomakeErrorMsg guifg=#d70000 guibg=#8a8a8a guisp=#8a8a8a gui=NONE ctermfg=160 ctermbg=233 cterm=NONE

autocmd BufWritePre * :FixWhitespace

let g:UltiSnipsExpandTrigger="<C-a>"
let g:UltiSnipsJumpForwardTrigger="<C-a>"
set completeopt=menu,preview

call yankstack#setup()
nmap <leader>n <Plug>yankstack_substitute_older_paste
nmap <leader>p <Plug>yankstack_substitute_newer_paste

au BufRead,BufNewFile *.gcov set filetype=gcov
hi gcovNotExecuted ctermfg=124 ctermbg=NONE cterm=NONE
hi gcovExecuted ctermfg=28 ctermbg=NONE cterm=NONE
hi gcovNoCode ctermfg=102 ctermbg=NONE cterm=NONE

let g:deoplete#enable_at_startup = 1

nmap <F8> :TagbarToggle<CR>

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

so $HOME/.config/nvim/init_private.vim
