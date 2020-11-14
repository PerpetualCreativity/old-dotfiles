
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
" markdown support
Plugin 'plasticboy/vim-markdown'
" tex/latex support
Plugin 'lervag/vimtex'
" 'focus mode' for vim
Plugin 'junegunn/goyo.vim'
" this plugin + vim-markdown can auto-format markdown tables.
Plugin 'godlygeek/tabular'
" shows what function you're in if it's taller than the page
Plugin 'wellle/context.vim'
" more targets in vim, including ) and ,
Plugin 'wellle/targets.vim'
" automatically highlights and deletes trailing whitespace
Plugin 'ntpeters/vim-better-whitespace'
" highlight other uses of a variable
Plugin 'rrethy/vim-illuminate'
" better word motions
Plugin 'chaoren/vim-wordmotion'
" autocomplete
Plugin 'ervandew/supertab'
" auto insert/delete brackets
Plugin 'jiangmiao/auto-pairs'
" switch between single-line and multi-line code
Plugin 'AndrewRadev/splitjoin.vim'
" highlight first occurrences of letters (makes using 'f' and friends easier)
Plugin 'unblevable/quick-scope'
" a better status bar
Plugin 'vim-airline/vim-airline'
" the base-16 snazzy theme in this is pretty cool
Plugin 'vim-airline/vim-airline-themes'
" nord
Plugin 'arcticicestudio/nord-vim'
call vundle#end()
filetype plugin indent on

" Better Whitespace Setup
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" Rainbow Setup
let g:rainbow_active = 1
let g:rainbow_guifgs = ['LightGray', 'Blue', 'Green', 'Red', 'Cyan', 'Magenta', 'Yellow']
let g:rainbow_ctermfgs = ['LightGray', 'Blue', 'Green', 'Red', 'Cyan', 'Magenta', 'Yellow']


" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

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

"Disable annoying error bells
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

let NERDTreeQuitOnOpen=1

nmap <F2> :NERDTreeToggle<CR>
nmap <F3> :TableFormat<CR>
" Vim GitGutter
set updatetime=100
map <Leader>gi :GitGutterToggle<CR>
let g:gitgutter_enabled = 1

" Close vim if only window left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" nerd tree lighlight
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1

" Markdown (.md) config
" Treat all .md files as markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown

nmap <C-L><C-L> :set invrelativenumber<CR>

" Goyo setup
nnoremap <C-g> :Goyo<CR>
nnoremap <tab> <C-W>w
nnoremap <`> gt
autocmd FileType * Goyo
autocmd FileType * Goyo
autocmd FileType markdown Goyo

" spell check
map <C-S> :setlocal spell! spelllang=en_gb<CR>
autocmd FileType markdown setlocal spell spelllang=en_gb

" Vim Markdown
let g:markdown_fenced_languages = [
    \ 'bash=sh',
    \ 'c',
    \ 'coffee',
    \ 'erb=eruby',
    \ 'javascript',
    \ 'json',
    \ 'perl',
    \ 'python',
    \ 'ruby',
    \ 'yaml',
    \ 'go',
\]

" Configuration for vim-markdown
let g:vim_markdown_conceal = 2
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_math = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_autowrite = 1
let g:vim_markdown_edit_url_in = 'tab'
let g:vim_markdown_follow_anchor = 1

au BufNewFile,BufRead *.bars set filetype=html
au BufNewFile,BufRead *.ejs set filetype=html

" vimtex
let g:tex_flavor = 'latex'

" quick scope
highlight QuickScopePrimary guifg='#ffffff' gui=underline ctermfg=White cterm=underline
highlight QuickScopeSecondary guifg='#ffffff' gui=underline ctermfg=White cterm=underline

" vim airline
let g:airline_theme='base16_snazzy'

" vim illuminate
let g:Illuminate_delay = 250
let g:Illuminate_ftHighlightGroups = { 'vim': ['vimVar', 'vimFuncName', 'vimFunction'] }

" " support for Terminal.app
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" nord theme config
let g:nord_cursor_line_number_background = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1

colorscheme nord

" don't you just hate it when you accidentally type
" :Q or :W instead of :q and :w
" and vim doesn't do what you really meant for it to do?

command! Q q
command! W w

" only blink cursor in insert mode
" https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI.="\e[3 q"
let &t_SR.="\e[3 q"
let &t_EI.="\e[4 q"

