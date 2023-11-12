set nocompatible
set encoding=utf-8
set backspace=2
syntax on
set t_Co=256
colorscheme default
set cursorline
highlight CursorLine cterm=none
highlight LineNr ctermfg=grey
set number
set ruler
set clipboard=unnamed
set noswapfile
set tabstop=2
set shiftwidth=2
set expandtab
set cin 
set showmatch
set hlsearch
highlight Search cterm=none
set incsearch
set ignorecase
set statusline=%F\ %m%r%w%=[%{strlen(&fenc)?&fenc:&enc},\ %{&ff},\ %{strlen(&filetype)?&filetype:'plain'}][row=%l/%L,\ col=%c][%3p%%]
set laststatus=2
set modeline
set modelines=5
