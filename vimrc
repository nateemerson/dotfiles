" Required by Vundle
set nocompatible
filetype off

let g:has_async = v:version >= 800 || has('nvim')

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'jakedouglas/exuberant-ctags'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'Townk/vim-autoclose'
Plugin 'airblade/vim-gitgutter'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-rhubarb'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'pangloss/vim-javascript'
Plugin 'dense-analysis/ale'


" Plugins must be added before following line
call vundle#end()
filetype plugin indent on

" Basics
syntax enable
set backspace=2
set nowrap
set list listchars=tab:»·,trail:·,nbsp:·
set updatetime=750
set wildmenu
set cursorline

" Use OS clipboard
set clipboard=unnamed

" Set Proper Tabs
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set cursorline

" Searching
set incsearch
set hlsearch

" Set path for file searching
set path+=**

" Relative line numbers
set number relativenumber
set numberwidth=4

" Disable/Enable relative line numbers
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

augroup vimrcEx
  autocmd!

augroup END

" Ruby performance fix for Vim 8.0, see:
"   https://github.com/vim/vim/issues/282
"   https://github.com/vim-ruby/vim-ruby/issues/243
set regexpengine=1

" Theme
set background=dark
colorscheme solarized
let g:airline_solarized_bg='dark'

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
" via Thoughtbot dotfiles
" also https://robots.thoughtbot.com/faster-grepping-in-vim
if executable ('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'
  let g:ctrlp_use_caching = 0
  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<SPACE>
endif

" autocmd for opening vertical/horizontal splits from qf window
" TODO: Figure out how to override <C-v> for qf
" autocmd! FileType qf nnoremap <C-v> <Nop>
" autocmd! FileType qf nnoremap <buffer> <C-v> <C-w><Enter><C-w>L
autocmd! FileType qf nnoremap <buffer> <C-x> <C-w><Enter>

" Remaps

" Basic remaps
inoremap jk <ESC>
let mapleader = "\<Space>"
vmap <leader>y "+y
nnoremap <leader>q @q
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" Toggle off search highlighting
silent! nnoremap <leader>/ :nohlsearch<CR>
" Plugin Remaps
silent! nmap <C-n> :NERDTreeToggle<CR>
silent! nnoremap <C-b> :TagbarToggle<CR>
silent! nnoremap <leader>m :TagbarOpenAutoClose<CR>
let g:NERDTreeMapPreview="<C-o>"
silent! nmap <leader>gs :Gstatus<CR>
silent! nmap <leader>ga :Gwrite<CR>
silent! nmap <leader>gd :Gdiff<CR>
silent! nmap <leader>gb :Gblame<CR>
" Split remaps
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
