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
Plug 'lervag/vimtex'
Plug 'hashivim/vim-terraform'

Plug 'junegunn/fzf'
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
Plug 'mg979/vim-visual-multi'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'dense-analysis/ale'
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --go-completer' }

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
let g:gruvbox_contrast_dark = "soft"
set background=dark
colo gruvbox

hi VertSplit ctermbg=NONE guibg=NONE cterm=none

" Paste from cliboard
set clipboard=unnamed,unnamedplus

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll baret guioptions-=T

set number

set nofoldenable

set directory=$HOME/.vim/swapfiles//
set backupdir=$HOME/.vim/backup//

nnoremap <C-S-t> :tabnew<CR>
inoremap <C-S-t> <Esc>:tabnew<CR>
inoremap <C-S-w> <Esc>:tabclose<CR>

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

set timeoutlen=1000 ttimeoutlen=0
set colorcolumn=120

au BufReadPost *.tex setlocal spell spelllang=pl,en
au BufReadPost *.md setlocal spell spelllang=pl,en
au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell spelllang=pl,en

set tags=./.tags;

" Go config <3
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>r  <Plug>(go-run)

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1

let g:tex_flavor = 'latex'
let g:vimtex_quickfix_open_on_warning = 0

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

let g:terraform_align=1
let g:terraform_fmt_on_save=1

let g:NERDTreeShowHidden=1

" FZF related stuff
nnoremap <C-b> :Buffers<CR>
nnoremap <C-g>g :Ag<CR>
nnoremap <leader><leader> :Commands<CR>
nnoremap <C-p> :call FzfOmniFiles()<CR>

fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GitFiles
  endif
endfun
