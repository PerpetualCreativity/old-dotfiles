
" Vim setup

if v:progname =~? "evim"
  finish
endif

" Vundle - plugin manager
" :h vundle
set nocompatible
filetype off

set rtp+=~/.dotfiles/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'adrian5/oceanic-next-vim'
Plugin 'VundleVim/Vundle.vim'
" file explorer
Plugin 'preservim/nerdtree'
" better styling for nerdtree
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
" git status in nerdtree
Plugin 'xuyuanp/nerdtree-git-plugin'
" open files with fzf (requires fzf installed)
set rtp+=/usr/local/opt/fzf
Plugin 'junegunn/fzf.vim'
" emmet support in vim
Plugin 'mattn/emmet-vim'
" git, but in vim
Plugin 'tpope/vim-fugitive'
" surround things easily, with (), '', etc
Plugin 'tpope/vim-surround'
" gcc<count> comment out line(s), gc in visual. both are toggleable
Plugin 'tpope/vim-commentary'
" csv editing!
Plugin 'chrisbra/csv.vim'
" tex/latex support
Plugin 'lervag/vimtex'
" to auto-format markdown tables.
Plugin 'dhruvasagar/vim-table-mode'
" more targets in vim, including ) and ,
Plugin 'wellle/targets.vim'
" automatically highlights and deletes trailing whitespace
Plugin 'ntpeters/vim-better-whitespace'
" auto insert/delete brackets
Plugin 'jiangmiao/auto-pairs'
" switch between single-line and multi-line code
Plugin 'AndrewRadev/splitjoin.vim'
" a better status bar
Plugin 'itchyny/lightline.vim'
" preview css colors
Plugin 'ap/vim-css-color'
" pandoc markdown support
Plugin 'vim-pandoc/vim-pandoc-syntax'
" Language Server Protocol support
Plugin 'natebosch/vim-lsc'
" Debug Adapter Protocol support
Plugin 'puremourning/vimspector'
" use tab for omnicomplete
Plugin 'ajh17/VimCompletesMe'
" support for many different languages
Plugin 'sheerun/vim-polyglot'
" visualise the Vim undo tree
Plugin 'mbbill/undotree'
" text alignment
Plugin 'tommcdo/vim-lion'
" quickly see which command to use
Plugin 'lifepillar/vim-cheat40'
" repeat plugin commands with .
Plugin 'repeat.vim'
" browse filetags
Plugin 'preservim/tagbar'
" dc-based calculator for vim
Plugin 'fcpg/vim-colddeck'
" add Nerd Font support to vim
Plugin 'ryanoasis/vim-devicons'
call vundle#end()
filetype plugin indent on

" Better Whitespace Setup
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

if has("vms")
  set nobackup      " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undodir=$HOME."/.undodir"
    set undofile    " keep an undo file (undo changes after closing)
  endif
endif

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

syntax enable

set nobackup

" Disable annoying error bells
set noerrorbells
set vb t_vb=
set number
" space-tabs are better
set tabstop=4
set shiftwidth=4
set expandtab
" underline the current line
set cursorline
set showmatch
set linebreak
" a better backspace
set backspace=indent,eol,start
set incsearch
set hlsearch
" when searching, lowercase=ignorecase and any uppercase becomes case-sensitive
set ignorecase
set smartcase
set foldenable
set foldlevelstart=10
set foldnestmax=10
" mouse support.
" no, I don't use it that often. However, it is useful when resizing splits.
set mouse=a
set wildmenu
set relativenumber
set clipboard=unnamed
" disable vim intro
set shm+=I
set foldmethod=syntax
set laststatus=2
set showcmd

" NERDTree config
let NERDTreeQuitOnOpen=1

nmap <F2> :NERDTreeToggle<CR>

" Close vim if only window left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" nerd tree highlight
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1

" fzf.vim config
nnoremap <silent> <Space><Space> :Files<CR>

" Markdown (.md) config
" Treat all .md files as markdown
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
" tell vim to load pandoc markdown
autocmd BufNewFile,BufFilePre,BufRead *.md set syntax=markdown.pandoc

autocmd syntax markdown.pandoc let b:AutoPairs = AutoPairsDefine({'$':'$', '$$': '$$', '\left(': '\right)', '*': '*', '**': '**'})
let g:pandoc#syntax#conceal#urls=1
autocmd syntax markdown.pandoc set conceallevel=2
autocmd syntax markdown.pandoc highlight! link Conceal Special

nmap <C-L><C-L> :set invrelativenumber<CR>

nnoremap <tab> <C-W>w

" detect racket files
autocmd BufNewFile,BufFilePre,BufRead *.rkt set filetype=racket

" undotree config
nnoremap <F3> :UndotreeToggle<CR>

" tagbar config
nnoremap <F4> :TagbarToggle<CR>

" lightline config
" ayu_dark,
let g:lightline = {
    \ 'colorscheme': 'ayu_dark',
    \ }

" spell check
autocmd FileType markdown setlocal spell spelllang=en_gb
" turn off spell checking between $$ in markdown (latex)
" https://vi.stackexchange.com/a/19991
autocmd FileType markdown syntax match notexspell /\$[^\$]\+\$/ contains=@NoSpell

" vimtex
let g:tex_flavor = 'latex'

" LSC config

let g:lsc_server_commands = {
\  "go": {
\    "command": "gopls serve",
\    "log_level": -1,
\    "suppress_stderr": v:true,
\  },
\  "rust": "rust-analyzer",
\  "javascript": "typescript-language-server --stdio",
\  "haskell": "haskell-language-server-wrapper --lsp",
\  "racket": "racket -l racket-langserver"
\}

let g:lsc_auto_map = {
\  'GoToDefinition': 'gd',
\  'FindReferences': 'gr',
\  'Rename': 'gR',
\  'ShowHover': 'K',
\  'FindCodeActions': 'ga',
\  'Completion': 'omnifunc',
\}

let g:lsc_enable_autocomplete = v:true
let g:lsc_enable_diagnostics = v:true
let g:lsc_reference_highlights = v:false
let g:lsc_trace_level = 'off'

set completeopt=menu,menuone,noinsert,noselect

" vimspector
let g:vimspector_enable_mappings = 'HUMAN'

" don't you just hate it when you accidentally type
" :Q or :W instead of :q and :w
" and vim doesn't do what you really meant for it to do?
command! Q q
command! W w

" change cursor style in different modes
" https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI.="\e[6 q" " line          insert
let &t_SR.="\e[2 q" " block         replace
let &t_EI.="\e[4 q" " underscore    normal

" this is the only useful function from $VIMRUNTIME/defaults.vim that isn't
" already in this .vimrc.
" it sends the editor back to the line you were last editing.
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" italics support
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" correcting spelling mistakes on the fly
inoremap <C-k> <c-g>u<Esc>[s1z=`]a<c-g>u

colorscheme oceanicnext

