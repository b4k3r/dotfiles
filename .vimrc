if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  set rtp+=$GOROOT/misc/vim
  runtime macros/matchit.vim
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rvm'
NeoBundle 'tpope/vim-rails'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'thoughtbot/vim-rspec'
NeoBundle 'scrooloose/nerdtree'
NeoBundle "MarcWeber/vim-addon-mw-utils"
NeoBundle "tomtom/tlib_vim"
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'Keithbsmiley/rspec.vim'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'maksimr/vim-jsbeautify'
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
NeoBundle 'scrooloose/syntastic'
NeoBundle 'fatih/vim-go'
NeoBundle 'tpope/vim-surround'
NeoBundle 'bling/vim-airline'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-easytags'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'othree/javascript-libraries-syntax.vim'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

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
set term=xterm-256color
set t_Co=256
set background=dark
colorscheme jellybeans

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

nnoremap <A-F1> 1gt
nnoremap <A-F2> 2gt
nnoremap <A-F3> 3gt
nnoremap <A-F4> 4gt
nnoremap <A-F5> 5gt
nnoremap <A-F6> 6gt
nnoremap <A-F7> 7gt
nnoremap <A-F8> 8gt
nnoremap <A-F9> 9gt
nnoremap <A-F0> 10gt

set list
set listchars=tab:>-,trail:~

vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

map <c-f> :call JsBeautify()<cr>
" or
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
autocmd BufWritePre * :%s/\s\+$//e

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

let g:neocomplete#enable_at_startup = 1

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

set colorcolumn=120
hi ColorColumn guibg=#202020 ctermbg=234

" vim-airline conf
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

set tags=./tags;

let g:syntastic_ruby_checkers = ['rubocop', 'mri']

let g:easytags_auto_highlight = 0

set lazyredraw
