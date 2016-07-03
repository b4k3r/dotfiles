if has('vim_starting')
  set nocompatible
  set rtp+=$GOROOT/misc/vim
  runtime macros/matchit.vim
endif

call plug#begin('~/.vim/plugged')

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rvm'
Plug 'tpope/vim-rails'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tomtom/tcomment_vim'
Plug 'thoughtbot/vim-rspec'
Plug 'airblade/vim-gitgutter'
Plug 'Keithbsmiley/rspec.vim'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/syntastic'
Plug 'fatih/vim-go'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'mileszs/ack.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'edkolev/tmuxline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'elixir-lang/vim-elixir'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'jiangmiao/auto-pairs'
Plug 'mustache/vim-mustache-handlebars'
Plug 'morhetz/gruvbox'
Plug 'w0ng/vim-hybrid'
Plug 'nanotech/jellybeans.vim'
Plug 'chriskempson/base16-vim'
Plug 'junegunn/seoul256.vim'

" JavaScript staff
Plug 'othree/yajs.vim', { 'for': 'javascript' }
if exists("g:plugs['yajs.vim']")
  Plug 'gavocanov/vim-js-indent', { 'for': 'javascript' }
endif
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'mustache/vim-mustache-handlebars'

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

" Rspec
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" Colors
set term=screen-256color
set t_Co=256
set background=dark
let g:seoul256_background = 236
colo seoul256

hi VertSplit ctermbg=NONE guibg=NONE cterm=none

" Paste from cliboard
set clipboard=unnamed,unnamedplus

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll baret guioptions-=T

set relativenumber
set number

" Disable backup
set nobackup
set nowritebackup
set noswapfile

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

let g:ycm_collect_identifiers_from_tags_files = 1

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

" vim-airline conf
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'zenburn'

let g:syntastic_ruby_checkers = ['mri']
let g:syntastic_javascript_checkers = ['eslint']

let g:easytags_auto_highlight = 0

set lazyredraw

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

set colorcolumn=120

map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>
map <Leader>vq :VimuxCloseRunner<CR>
map <Leader>vx :VimuxInterruptRunner<CR>
map <Leader>vz :call VimuxZoomRunner()<CR>

set timeoutlen=1000 ttimeoutlen=0
