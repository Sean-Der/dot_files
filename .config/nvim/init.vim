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

let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_open_list = 1
let g:ale_lint_on_text_changed = 'never'

autocmd BufWritePre * :FixWhitespace

autocmd BufEnter * :syntax sync fromstart
