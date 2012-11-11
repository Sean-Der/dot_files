"Enable the colorscheme only if we can have full color support
if &t_Co != 8
  colorscheme 256_jungle
  "Show tabs in vim
  let g:indent_guides_auto_colors = 0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=238
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=239
  autocmd VimEnter * IndentGuidesEnable
endif

set nowrap
set title
set nobackup
set noswapfile
syntax on
"au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
filetype plugin indent on
set showcmd
set showmatch
set ignorecase
set smartcase 
set incsearch
set autowrite
set hidden

"Tabs
set shiftwidth=4 tabstop=4

"Remap the arrow keys to actually do something useful
nmap <Right> :bn<cr>
nmap <Left>  :bp<cr>
nmap <Up>    :E<cr>
nmap <Down>  :bd<cr>

"Create a mapping for easy ncmpcpp access
nmap mpd :!ncmpcpp<CR><CR>

let mapleader=","
"for ctags
nmap <leader>ct :!ctags --extra=+f -R *<CR><CR>
"jump to definition
nmap <leader>d <C-]>
"jump back from definition
nmap <leader>r <C-t>
"Lazy paste fix
xnoremap p pgvy
