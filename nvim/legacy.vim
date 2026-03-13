" Vim-plug
call plug#begin()

Plug 'dracula/vim',{'as':'dracula'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'tpope/vim-fugitive'
"Plug 'sheerun/vim-polyglot'
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'tpope/vim-surround'
"Plug 'ycm-core/YouCompleteMe'
"Plug 'vim-syntastic/syntastic'
"Plug 'chrisbra/sudoedit.vim'
"Plug 'JuliaEditorSupport/julia-vim'
"Plug 'easymotion/vim-easymotion'
"Plug 'mattn/emmet-vim'

call plug#end()

"map <Leader> <Plug>(easymotion-prefix)

" Actual vim stuff
imap jj <esc>
imap jk <esc>
map <leader>o o<esc>
map <leader>O O<esc>

map Y y$
let mapleader = "\\"
map <SPACE> <leader>

" Provides different behaviors on double taps
function! ToggleMovement(firstOp, thenOp)
  let pos = getpos('.')
  execute "normal! " . a:firstOp
  if pos == getpos('.')
    execute "normal! " . a:thenOp
  endif
endfunction

" The original carat 0 swap
nnoremap <silent> 0 :call ToggleMovement('^', '0')<CR>

" Easy split movement
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

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

" Airline customization
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>

