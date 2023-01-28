call plug#begin('~/.config/nvim/plugged')
  Plug 'fatih/vim-go'
  Plug 'airblade/vim-gitgutter'
  Plug 'w0rp/ale'
  Plug 'itchyny/lightline.vim'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'maxbrunsfeld/vim-yankstack'
  Plug 'milkypostman/vim-togglelist'
  Plug 'rhysd/vim-clang-format'
  Plug 'sheerun/vim-polyglot'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'tpope/vim-fugitive'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  Plug 'preservim/tagbar'
call plug#end()

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

set ignorecase
set smartcase
set mouse=""
set inccommand=nosplit
set termguicolors

"Leaving modes in Emacs+EVIL feels right
map <C-g> <Esc>
map! <C-g> <Esc>
cmap <C-g> <Esc>
imap <C-g> <Esc>
tmap <C-g> <C-\><C-n>

let mapleader=","

nmap <leader>o :Files<CR>
nmap <leader>g :GFiles<CR>
nmap <leader>e :Ex<CR>
nmap <leader>m :History<CR>
nmap <leader>t :Tags<CR>
nmap <leader>r <ESC>:Rg<CR>

"ctags
nmap <leader>tc :!ctags --extra=+f -R *<CR><CR>
set tags=tags;

set wildignore=*.o,*#,*.fasl
set wildmode=longest,list,full
set completeopt=menu,preview

let g:indent_guides_enable_on_vim_startup = 1

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠'
let g:ale_open_list = 1
let g:ale_lint_on_text_changed = 'never'

let g:fzf_layout = { 'down': '~40%' }
let g:tagbar_position = 'below'

autocmd BufWritePre * :FixWhitespace
autocmd BufEnter * :syntax sync fromstart
