set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'
  Plugin 'ctrlpvim/ctrlp.vim'
  Plugin 'notpratheek/vim-luna'
  Plugin 'scrooloose/nerdtree'
  Plugin 'Xuyuanp/nerdtree-git-plugin'
  Bundle 'jistr/vim-nerdtree-tabs'

  " Language Support
  Plugin 'vim-ruby/vim-ruby'

  Plugin 'mhinz/vim-signify'
call vundle#end()            " required

filetype plugin indent on    " required
syntax enable

colorscheme luna-term

"Text Styles
set tabstop=2
set shiftwidth=2
set expandtab
set scrolloff=10
set backspace=2
set showbreak=   
set cpoptions+=n
set linebreak
set linespace=1
set smartindent

set number
set relativenumber 
