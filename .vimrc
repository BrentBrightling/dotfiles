set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'
  Plugin 'notpratheek/vim-luna'
  Plugin 'scrooloose/nerdtree'
  Plugin 'vim-ruby/vim-ruby'
  Plugin 'Xuyuanp/nerdtree-git-plugin'
  Plugin 'mattn/emmet-vim'
  Plugin 'bling/vim-airline'
  Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plugin 'junegunn/fzf.vim'
  " Language Support

  Plugin 'vim-pandoc/vim-pandoc'
  Plugin 'vim-pandoc/vim-pandoc-syntax'

  Plugin 'mhinz/vim-signify'
call vundle#end()            " required

filetype plugin indent on    " required
syntax enable

colorscheme luna-term

" Move swap files
set dir=~/.vim/_swap/

" Move backups
set backup
set backupdir=~/.vim/_backup

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
set autowrite

set number
set relativenumber 

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

nmap <silent> <C-S-n> :NERDTreeToggle<CR>

" FZF bindings
nmap <C-p> :GFiles<cr>
nmap <C-h>h :History<CR>
nmap <C-l>l :Lines<CR>
nmap <C-m> :bn<CR>
nmap <C-n> :bp<CR>

nmap <C-f> :Find 

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
