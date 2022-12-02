lua << EOLUA
vim.g.DEBUG = "WARN"
require('init')
EOLUA

" autocmd BufWritePost plugins.lua source <afile> | PackerCompile
" autocmd BufWritePost treesitter.lua source <afile> | TSUpdate
autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}

" No ex mode
nnoremap Q <nop>

nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<CR>
inoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<CR>

command! EditConfig :e ~/.config/nvim/init.vim

" disable compatibility to old-time vi
set nocompatible

" show matching
set showmatch

set nojoinspaces
set termguicolors

" colors
set background=dark
colorscheme gruvbox-material

" Enhance command-line completion
set wildmenu

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Centralize backups, swapfiles and undo history
set backupdir=~/.nvim/backups
set directory=~/.nvim/swaps//,.
if exists("&undodir")
  set undofile
  set undodir=~/.nvim/undo
  set undolevels=500
  set undoreload=500
endif
if exists("&undodir")
  set undofile
endif

" Respect modeline in files
set modeline
set modelines=4

" Enable line numbers
set number

" Make line numbers relative
set relativenumber

" Enable syntax highlighting
syntax on

" Highlight current line
set cursorline

" Show 'invisible' characters
set listchars=tab:▸\ ,trail:␠,nbsp:␣
set list

"spaces not tabs
" set expandtab
" set shiftwidth=2
" set softtabstop=2

" indent a new line the same amount as the line just typed
set autoindent
set smartindent

" Highlight searches
set hlsearch

" Ignore case of searches
set ignorecase
set smartcase

" Highlight dynamically as pattern is typed
" NVIM DEFAULT
" set incsearch

" Always show status line
set laststatus=2

" Disable auto-mouse in all modes
set mouse-=a

" Disable error bells
set noerrorbells

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Show the cursor position
set ruler

" Don’t show the intro message when starting Vim
set shortmess=attI

" Show the current mode
set showmode

" Show the filename in the window titlebar
set title

" Show the (partial) command as it’s being typed
set showcmd

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Speed up scrolling in Vim
set ttyfast

" XML filetype folding
" DISABLE: Breaks JSX syntax (https://github.com/mxw/vim-jsx#frequently-asked-questions)
" let g:xml_syntax_folding=1
" au FileType xml setlocal foldmethod=syntax

" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
" noremap <leader>ss :call StripWhitespace()<CR>
"
" Enter cleans the search highlight
" nnoremap <CR> :nohlsearch<CR>

" Reset worthwhie title (not "Thanks for flying Vim")
let &titleold=getcwd()

" Up/down on wrapped lines
nmap j gj
nmap k gk

" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure

let g:node_host_prog = system('volta which neovim-node-host | tr -d "\n"')

" EditorConfig play well with others
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Escape can be a pain
imap jj <Esc>

" Line length ruler
highlight ColorColumn ctermbg=lightred ctermfg=black guibg=lightred guifg=black

" Some filetype settings
autocmd Filetype css setlocal iskeyword+=-
autocmd Filetype scss setlocal iskeyword+=-

autocmd Filetype markdown setlocal tw=100 spell
autocmd Filetype php setlocal ts=4 sw=4 sts=4 noet
autocmd Filetype python setlocal ts=4 sw=4 sts=4 et

" vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

""""""""""""""
" Key Bindings
""""""""""""""
nnoremap <silent> <Leader><Leader> :source $MYVIMRC<cr>
nnoremap <silent> <Leader>ve :vsp $MYVIMRC<cr>
nnoremap <silent> <Space>bn :enew<cr>
nnoremap <silent> <Space><tab> :b#<cr>
nnoremap <silent> <Space>gb :Git blame<cr>
nnoremap <silent> <Space>gx :.GBrowse<cr>

nnoremap <Space>ft :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

nnoremap <Space>dd :Gitsigns change_base('develop')<cr>
nnoremap <Space>dt :Gitsigns change_base('trunk')<cr>
