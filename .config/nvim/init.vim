function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

call plug#begin('~/.config/nvim/plugged')
  Plug 'fatih/vim-go'
  Plug 'airblade/vim-gitgutter'
  Plug 'benekastah/neomake'
  Plug 'bling/vim-airline'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'maxbrunsfeld/vim-yankstack'
  Plug 'milkypostman/vim-togglelist'
  Plug 'neovim/node-host', { 'do': 'npm install' }
  Plug 'sean-der/vim-clang-format'
  Plug 'sheerun/vim-polyglot'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-sleuth'
  Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
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


"Leaving modes in Emacs+EVIL feels right
map <C-g> <Esc>
map! <C-g> <Esc>
cmap <C-g> <Esc>
imap <C-g> <Esc>
tmap <C-g> <C-\><C-n>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


let mapleader=","

nmap <leader>o :Files<CR>
nmap <leader>m :History<CR>
nmap <leader>t :Tags<CR>
nmap <leader>r <ESC>:Rg<CR>

"ctags
nmap <leader>tc :!ctags --extra=+f -R *<CR><CR>
set tags=tags;

set wildignore=*.o,*#,*.fasl
set wildmode=longest,list,full
set completeopt=menu,preview

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
set laststatus=2

autocmd! BufWritePost * Neomake
let g:neomake_open_list = 2
let g:neomake_warning_sign = {'text': '⚠>', 'texthl': 'NeomakeWarningMsg'}
let g:neomake_error_sign = {'text': '✖', 'texthl': 'NeomakeErrorMsg'}
hi NeomakeErrorMsg guifg=#d70000 guibg=#8a8a8a guisp=#8a8a8a gui=NONE ctermfg=160 ctermbg=233 cterm=NONE
hi NeomakeWarningMsg guifg=#d70000 guibg=#8a8a8a guisp=#8a8a8a gui=NONE ctermfg=100 ctermbg=233 cterm=NONE

autocmd BufWritePre * :FixWhitespace

autocmd BufEnter * :syntax sync fromstart
