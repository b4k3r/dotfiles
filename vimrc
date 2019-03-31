if has('vim_starting')
  set nocompatible
  set rtp+=$GOROOT/misc/vim
  runtime macros/matchit.vim
endif

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'

Plug 'fatih/vim-go'
Plug 'tpope/vim-rails'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
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
Plug 'mileszs/ack.vim'
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'w0rp/ale'

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
" set term=screen-256color
set t_Co=256
set background=dark
colo gruvbox

hi VertSplit ctermbg=NONE guibg=NONE cterm=none

" Paste from cliboard
set clipboard+=unnamed

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll baret guioptions-=T

" set relativenumber
set number

set directory=$HOME/.vim/swapfiles//
set backupdir=$HOME/.vim/backup//

nnoremap <C-S-t> :tabnew<CR>
inoremap <C-S-t> <Esc>:tabnew<CR>
inoremap <C-S-w> <Esc>:tabclose<CR>

" set list
set listchars=tab:>-,trail:~

vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

autocmd BufWritePre * :%s/\s\+$//e

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

" vim-airline conf
let g:airline_powerline_fonts = 1
let g:airline_extensions = []
let g:airline_theme = 'gruvbox'

let g:go_def_mode='gopls'
let g:ale_go_bingo_executable = 'gopls'

set lazyredraw
set ttyfast
set re=1

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

set colorcolumn=120

au BufReadPost *.tex setlocal spell spelllang=pl,en
au BufReadPost *.md setlocal spell spelllang=en
au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell spelllang=pl,en

let g:go_fmt_command = "goimports"

let g:ackprg = 'ag --nogroup --nocolor --column'
