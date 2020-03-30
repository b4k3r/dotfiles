if has('vim_starting')
  set nocompatible
endif

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'

Plug 'lervag/vimtex'
Plug 'plasticboy/vim-markdown'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'xolox/vim-misc'
Plug 'ludovicchabant/vim-gutentags'
Plug 'terryma/vim-multiple-cursors'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'dense-analysis/ale'

call plug#end()

filetype plugin indent on

syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands

set laststatus=2

" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

" Searching
set nohlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter


" Colors
set t_Co=256
set background=dark
colo gruvbox

hi VertSplit ctermbg=NONE guibg=NONE cterm=none

" Paste from cliboard
set clipboard=unnamed,unnamedplus

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll baret guioptions-=T

set relativenumber
set number

set directory=$HOME/.vim/swapfiles//
set backupdir=$HOME/.vim/backup//

nnoremap <C-S-t> :tabnew<CR>
inoremap <C-S-t> <Esc>:tabnew<CR>
inoremap <C-S-w> <Esc>:tabclose<CR>

set list
set listchars=tab:>-,trail:~

vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

autocmd BufWritePre * :%s/\s\+$//e

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

" vim-airline conf
let g:airline_powerline_fonts = 1
let g:airline_extensions = []
let g:airline_theme = 'gruvbox'

set lazyredraw
set ttyfast
set re=1

set colorcolumn=120

nnoremap <c-p> :Files<cr>

au BufReadPost *.tex setlocal spell spelllang=pl,en
au BufReadPost *.md setlocal spell spelllang=pl,en
au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell spelllang=pl,en

set tags=./.tags;
