" Required by Vundle
set nocompatible
filetype off
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

" Set Proper Tabs
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set cursorline

" Searching
set incsearch
set hlsearch

" Relative line numbers
set number relativenumber
set numberwidth=4

" Disable/Enable relative line numbers
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Ruby performance fix for Vim 8.0, see:
"   https://github.com/vim/vim/issues/282
"   https://github.com/vim-ruby/vim-ruby/issues/243
set regexpengine=1

" Theme
set background=dark
colorscheme solarized

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
" via Thoughtbot dotfiles
if executable ('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'
  let g:ctrlp_use_caching = 0
endif

" Remaps

" Toggle off search highlighting
silent! nnoremap <leader>/ :nohlsearch<CR>
" Plugin Remaps
silent! nmap <C-n> :NERDTreeToggle<CR>
silent! nnoremap <C-m> :TagbarToggle<CR>
silent! nnoremap <leader>m :TagbarOpenAutoClose<CR>
let g:NERDTreeMapPreview="<C-o>"
inoremap jk <ESC>
let mapleader = "\<Space>"
" Split remaps
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
