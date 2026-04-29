" Actual vim stuff
imap jj <esc>
imap jk <esc>
map <leader>o o<esc>
map <leader>O O<esc>

map Y y$
let mapleader = "\\"
map <SPACE> <leader>

" Easy vsplit adjustment
nnoremap <leader>= :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>

"let g:loaded_python3_provider = 0
" Tabs
set autoindent " indent new lines
set tabstop=4 " set tab character width
set softtabstop=0 " for editing tabs
set expandtab " insert spaces instead of tabs
set shiftwidth=4 " insert 4 spaces

" Strip trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" Aesthetics
colorscheme dracula
set termguicolors
syntax enable
set number
set nowrap
nohl
set listchars=tab:>-,trail:·,precedes:«,extends:»,eol:¬

