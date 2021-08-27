call plug#begin()
  Plug 'scrooloose/nerdtree'
  Plug 'kyazdani42/nvim-tree.lua'

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'stsewd/fzf-checkout.vim'

  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'

  Plug 'mhinz/vim-signify'

  " Language Support
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-rails'

  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'hrsh7th/nvim-compe'
  Plug 'glepnir/lspsaga.nvim'
  " Plug 'nvim-lua/completion-nvim'
  " Plug 'steelsojka/completion-buffers'

  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

  " Plug 'f-person/git-blame.nvim'
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'vim-pandoc/vim-pandoc-syntax'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}


  " Themes
  " Plug 'dracula/vim'
  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'sainnhe/gruvbox-material'
call plug#end()

set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
set noswapfile

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

let mapleader = " "

set noshowmatch
set number
set relativenumber
set tabstop=2
set shiftwidth=2
set incsearch
set expandtab
set scrolloff=10
set backspace=2
set showbreak=
set cpoptions+=n
set linebreak
set linespace=1
set smartindent
set autowrite
set encoding=UTF-8
set ttimeoutlen=50
set noerrorbells
set signcolumn=yes
set colorcolumn=120

set undodir=~/.vim/undodir
set undofile


set clipboard=unnamed

set t_Co=256
set t_ut=

"colorscheme luna-term
colorscheme gruvbox-material
"colorscheme horizon
set background=dark

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1

autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

nmap <silent> <Leader>t :NvimTreeFindFile<CR>
nmap <silent> <C-t> :NvimTreeToggle<CR>

map <leader>c "*y

" " FZF bindings
" nmap <C-p> :GFiles<cr>
" nmap <C-h>h :History<CR>
" nmap <C-l>l :Lines<CR>
" nmap <C-f> :Find
"
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

" Buffers
nmap <C-m> :bn<CR>
nmap <C-n> :bp<CR>
nmap <Leader>d :bd!<CR>


" Stop using arrow keys
nnoremap <Left> <<
nnoremap <Right> >>
nnoremap <Up> ddkP
nnoremap <Down> ddp

" Easy exit
inoremap jj <Esc>
inoremap kk <Esc>
inoremap jk <Esc>
inoremap kj <Esc>

" Fugitive

nnoremap <leader>gj :diffget //3<CR>
nnoremap <leader>gf :diffget //2<CR>
nnoremap <leader>gs :G<CR>
nnoremap <leader>gc :GBranches<CR>
nnoremap <leader>gp :Gpush<CR>

" EasyMotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_prompt = '{n}>> '
nmap s <Plug>(easymotion-s)
nmap gj <Plug>(easymotion-j)
nmap gk <Plug>(easymotion-k)
nmap gh <Plug>(easymotion-linebackward)
nmap gl <Plug>(easymotion-lineforward)

let g:ale_fixers = {'javascript': ['prettier']}
let g:ale_fix_on_save = 1


noremap <silent> <leader>og V:<c-u>call OpenCurrentFileInGithub()<cr>
xnoremap <silent> <leader>og :<c-u>call OpenCurrentFileInGithub()<cr>

" Commands

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --glob "!log/*" --glob "!node_modules/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" FUNCTIONS

function! OpenCurrentFileInGithub()
  let file_dir = expand('%:h')
  let git_root = system('cd ' . file_dir . '; git rev-parse --show-toplevel | tr -d "\n"')
  let file_path = substitute(expand('%:p'), git_root . '/', '', '')
  let branch = system('git symbolic-ref --short -q HEAD | tr -d "\n"')
  let git_remote = system('cd ' . file_dir . '; git remote get-url origin')
  let repo_path = matchlist(git_remote, ':\(.*\)\.')[1]
  let url = 'https:' . repo_path . '/blob/' . branch . '/' . file_path
  let first_line = getpos("'<")[1]
  let url .= '#L' . first_line
  let last_line = getpos("'>")[1]
  if last_line != first_line | let url .= '-L' . last_line | endif
  let @*=url
  call system('open ' . url)
endfunction

fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

augroup BRONT
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
  " autocmd BufEnter * lua require'completion'.on_attach()
augroup END


" TELESCOPE
nnoremap <C-f> :lua require('telescope.builtin').grep_string({ search = vim.fn.input("🔍: ") })<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>


lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

:lua << EOF
local previewers = require('telescope.previewers')

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    file_sorter =  require'telescope.sorters'.get_fzy_sorter,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    path_display = {"shorten"},
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' },
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.qflist.new
  }
}
require('telescope').load_extension('fzy_native')
EOF

highlight TelescopeBorder         guifg=#bd93f9
highlight TelescopePromptBorder   guifg=#bd93f9
highlight TelescopeResultsBorder  guifg=#bd93f9
highlight TelescopePreviewBorder  guifg=#bd93f9

command! Format execute 'lua vim.lsp.buf.formatting()'

nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>gsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>gr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>grn :lua vim.lsp.buf.rename()<CR>
" nnoremap <leader>gh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>gca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>gsd :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>

:lua << EOF
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}
EOF

:lua << EOF
  local nvim_lsp = require('lspconfig')
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  end
  local servers = { "jsonls", "tsserver", "pyright", "vimls", "clangd" }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup { on_attach = on_attach }
  end
EOF



let g:completion_auto_change_source = 1
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
" lua require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
" lua require'lspconfig'.clangd.setup{ on_attach=require'completion'.on_attach }
" lua require'lspconfig'.pyls_ms.setup{ on_attach=require'completion'.on_attach }
" lua require'lspconfig'.vimls.setup{  on_attach=require'completion'.on_attach }
"
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set completeopt=menuone,noselect
:lua << EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 300;
  incomplete_delay = 400;
  allow_prefix_unmatch = false;
  max_abbr_width = 1000;
  max_kind_width = 1000;
  max_menu_width = 1000000;
  documenation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = false;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = false;
    treesitter = true;
  };
}
  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end
  _G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
      return t "<Plug>(vsnip-jump-prev)"
    else
      return t "<S-Tab>"
    end
  end

  vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
  vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
  vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF


  " nvim_lsp["pyls_ms"].setup {
  "   on_attach=require'completion'.on_attach,
  "   filetypes = { "python" },
  "   cmd = { "dotnet", "exec", "/Users/brentbrightling/code/python-language-server/output/bin/Debug/Microsoft.Python.LanguageServer.dll" },
  "   init_options = {
  "     analysisUpdates = true,
  "     asyncStartup = true,
  "     displayOptions = {},
  "     interpreter = {
  "       properties = {
  "         InterpreterPath = "/usr/bin/python3",
  "         Version = "3.9.1"
  "       }
  "     }
  "   }
  " }
  "
" Tree sitter

:lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
}
EOF

" SAGA

:lua <<EOF
local saga = require 'lspsaga'
saga.init_lsp_saga()
EOF
