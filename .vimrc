
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
Plugin 'VundleVim/Vundle.vim'
" file explorer
Plugin 'preservim/nerdtree'
" better styling for nerdtree
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
" git status in nerdtree
Plugin 'xuyuanp/nerdtree-git-plugin'
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
" change the default start screen
Plugin 'mhinz/vim-startify'
" tex/latex support
Plugin 'lervag/vimtex'
" to auto-format markdown tables.
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" more targets in vim, including ) and ,
Plugin 'wellle/targets.vim'
" automatically highlights and deletes trailing whitespace
Plugin 'ntpeters/vim-better-whitespace'
" highlight other uses of a variable
Plugin 'rrethy/vim-illuminate'
" better word motions
Plugin 'chaoren/vim-wordmotion'
" auto insert/delete brackets
Plugin 'jiangmiao/auto-pairs'
" switch between single-line and multi-line code
Plugin 'AndrewRadev/splitjoin.vim'
" a better status bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" limelight
Plugin 'junegunn/limelight.vim'
" css colors
Plugin 'ap/vim-css-color'
" pandoc markdown support
Plugin 'vim-pandoc/vim-pandoc-syntax'
" nord
Plugin 'arcticicestudio/nord-vim'
call vundle#end()
filetype plugin indent on

" Better Whitespace Setup
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
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
set undofile
" don't place undo files in the same folder as the file
set undodir=~/.vim/undodir
set foldenable
set foldlevelstart=10
set foldnestmax=10
" mouse support.
" no, I don't use it that often. However, it is useful when resizing splits.
set mouse=a
set wildmenu
set relativenumber
set clipboard=unnamed

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

" spell check
autocmd FileType markdown setlocal spell spelllang=en_gb
" turn off spell checking between $$ in markdown (latex)
" https://vi.stackexchange.com/a/19991
autocmd FileType markdown syntax match notexspell /\$[^\$]\+\$/ contains=@NoSpell

" vimtex
let g:tex_flavor = 'latex'

" quick scope
highlight QuickScopePrimary guifg='#ffffff' gui=underline ctermfg=White cterm=underline
highlight QuickScopeSecondary guifg='#ffffff' gui=underline ctermfg=White cterm=underline
autocmd FileType markdown let b:qs_local_disable=1

" vim airline
let g:airline_theme='base16_snazzy'

" vim illuminate
let g:Illuminate_delay = 250
let g:Illuminate_ftHighlightGroups = { 'vim': ['vimVar', 'vimFuncName', 'vimFunction'] }

" limelight
let g:limelight_conceal_ctermfg = 'gray'

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

" vim as a calculator
" second comment on
" https://vim.fandom.com/wiki/Using_vim_as_calculator
ino <C-A> <C-O>yiW<End>=<C-R>=<C-R>0<CR>

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

" let g:nord_cursor_line_number_background = 1
" let g:nord_italic = 1
" let g:nord_italic_comments = 1
" let g:nord_underline = 1
colorscheme cyan

