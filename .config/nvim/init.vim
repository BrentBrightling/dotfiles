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
  "Plugin 'itchyny/lightline.vim'
  Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plugin 'junegunn/fzf.vim'
  Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plugin 'w0rp/ale'


  " Language Support
  

  Plugin 'tpope/vim-commentary'

  Plugin 'vim-pandoc/vim-pandoc'
  Plugin 'vim-pandoc/vim-pandoc-syntax'

  Plugin 'KabbAmine/yowish.vim'
  Plugin 'mhinz/vim-signify'
call vundle#end()            " required

filetype plugin indent on    " required
syntax enable

let g:deoplete#enable_at_startup = 1

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
set encoding=utf-8
set ttimeoutlen=50

set number
set relativenumber 

set background=dark
set t_Co=256
set t_ut=

"colorscheme luna-term
colorscheme yowish

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1

let g:python3_hose_prog = '/usr/local/bin/python3'

let g:ale_echo_cursor = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_change = "never"
let g:ale_lint_on_insert_leave = 1

"Lightline
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif
set noshowmode
"let g:lightline = {
"  \ 'colorscheme': 'yowish',
"  \}

nmap <silent> <C-t> :NERDTreeToggle<CR>

" FZF bindings
nmap <C-p> :GFiles<cr>
nmap <C-h>h :History<CR>
nmap <C-l>l :Lines<CR>
nmap <C-m> :bn<CR>
nmap <C-n> :bp<CR>

nmap <C-f> :Find 

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" Guides
inoremap <Space><Space> <Esc>/<++><Enter>"_c4l
vnoremap <Space><Space> <Esc>/<++><Enter>"_c4l
map <Space><Space> <Esc>/<++><Enter>"_c4l
inoremap ;gui <++>

" Auto Commands

" Pandoc
autocmd FileType pandoc inoremap ;a \alpha
autocmd FileType pandoc inoremap ;b \beta
autocmd FileType pandoc inoremap ;th \theta
autocmd FileType pandoc inoremap ;r \rho
autocmd FileType pandoc inoremap ;m \mu

autocmd FileType pandoc inoremap ;h \hat{}<++><Esc>F}i
autocmd FileType pandoc inoremap ;ti \tilde{}<++><Esc>F}i
autocmd FileType pandoc inoremap ;o \overline{}<++><Esc>F}i
autocmd FileType pandoc inoremap ;f \frac{}{<++>}<++><Esc>F};i
autocmd FileType pandoc inoremap ;s \sum
autocmd FileType pandoc inoremap _ _{}<++><Esc>F}i
autocmd FileType pandoc inoremap ^ ^{}<++><Esc>F}i

