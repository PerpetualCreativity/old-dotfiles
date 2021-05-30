" PerpetualCreativity's vim config

if has("vms")
    set nobackup      " do not keep a backup file, use versions instead
else
    set backupdir=~/.vim/backup
    set backup        " keep a backup file (restore to previous version)
    if has('persistent_undo')
        set undodir=~/.undodir
        set undofile    " keep an undo file (undo changes after closing)
    endif
endif

if has('syntax') && has('eval')
    packadd! matchit
endif

" plugins --------------------------------------------------------------------
call plug#begin(stdpath('data') . '/plugged')
Plug 'mhartington/oceanic-next'
    if (has("termguicolors"))
        set termguicolors
    endif
    let g:oceanic_next_terminal_bold = 0
    let g:oceanic_next_terminal_italic = 1
    syntax on
" indent guides
Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
    let g:indentLine_char = '▏'
" file explorer
Plug 'preservim/nerdtree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }
        let g:NERDTreeFileExtensionHighlightFullName = 1
        let g:NERDTreeExactMatchHighlightFullName = 1
        let g:NERDTreePatternMatchHighlightFullName = 1
        let g:NERDTreeHighlightFolders = 1
        let g:NERDTreeHighlightFoldersFullName = 1
    Plug 'xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
    " Close vim if only window left is NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    let NERDTreeQuitOnOpen=1
    map <F2> :NERDTreeToggle<CR>
" better styling for nerdtree
" open files with fzf (requires fzf installed)
set rtp+=/usr/local/opt/fzf
Plug 'junegunn/fzf.vim'
    nnoremap <silent> <Space><Space> :Files<CR>
    nnoremap <silent> <Leader>b      :Buffers<CR>
    nnoremap <silent> <Leader>w      :Buffers<CR>
    nnoremap <silent> <Leader>m      :Marks<CR>
" emmet support in vim
Plug 'mattn/emmet-vim', { 'for': ['html', 'jet'] }
" git, but in vim
Plug 'tpope/vim-fugitive'
" surround things easily, with (), '', etc
Plug 'tpope/vim-surround'
" gcc<count> comment out line(s), gc in visual. both are toggleable
Plug 'tpope/vim-commentary'
" csv editing!
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
" tex/latex support
Plug 'lervag/vimtex', { 'for': 'latex' }
    let g:tex_flavor = 'latex'
" to auto-format markdown tables.
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeEnable' }
" more targets in vim, including ) and ,
Plug 'wellle/targets.vim'
" automatically highlights and deletes trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
    let g:better_whitespace_enabled=1
    let g:better_whitespace_on_save=1
" auto insert/delete brackets
Plug 'LunarWatcher/auto-pairs'
    autocmd syntax markdown.pandoc let b:AutoPairs = autopairs#AutoPairsDefine({'$':'$', '$$': '$$', '\left(': '\right)', '*': '*', '**': '**'})
" switch between single-line and multi-line code
Plug 'AndrewRadev/splitjoin.vim'
" preview css colors
Plug 'ap/vim-css-color', { 'for': ['html', 'css'] }
" pandoc markdown support
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': 'markdown' }
    autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
    autocmd BufNewFile,BufFilePre,BufRead *.md set syntax=markdown.pandoc
    let g:pandoc#syntax#conceal#urls=1
    autocmd syntax markdown.pandoc set conceallevel=2
    " autocmd syntax markdown.pandoc highlight! link Conceal Special
    " spell check
    autocmd FileType markdown setlocal spell spelllang=en_gb
    " turn off spell checking between $$ in markdown (latex)
    " https://vi.stackexchange.com/a/19991
    autocmd FileType markdown syntax match notexspell /\$[^\$]\+\$/ contains=@NoSpell
    autocmd FileType markdown set scl=no
" install language servers with :TSInstall, available parsers at nvim-treesitter#supported-languages
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
" Language Server Protocol config
Plug 'neovim/nvim-lspconfig'
    nnoremap gD        <Cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap gd        <Cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap K         <Cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap gi        <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <C-k>     <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <space>wa <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
    nnoremap <space>wr <cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
    nnoremap <space>wl <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
    nnoremap <space>D  <cmd>lua vim.lsp.buf.type_definition()<CR>opts)
    nnoremap <space>rn <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <space>ca <cmd>lua vim.lsp.buf.code_action()<CR>
    nnoremap gr        <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <space>e  <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
    nnoremap [d        <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
    nnoremap ]d        <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
    nnoremap <space>q  <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
    sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=LspDiagnosticsSignError
    sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=LspDiagnosticsSignWarning
    sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=LspDiagnosticsSignInformation
    sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=LspDiagnosticsSignHint
" use lsp or treesitter for omnicomplete
Plug 'nvim-lua/completion-nvim'
    set completeopt=menuone,noinsert,noselect
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    autocmd BufEnter * lua require'completion'.on_attach()
    imap <tab> <Plug>(completion_smart_tab)
    imap <s-tab> <Plug>(completion_smart_s_tab)
    let g:completion_enable_auto_popup = 1
    let g:completion_sorting = 'length'
    let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
" statusline
Plug 'vim-airline/vim-airline'
    let g:airline#extensions#scrollbar#enabled = 0
Plug 'vim-airline/vim-airline-themes'
    let g:airline_theme='oceanicnextminimal'
" visualise the Vim undo tree
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
    map <F3> :UndotreeToggle<CR>
" text alignment
Plug 'tommcdo/vim-lion'
" browse filetags
Plug 'preservim/tagbar', { 'on': 'TagbarToggle' }
    map <F4> :TagbarToggle<CR>
" floating terminal for neovim
Plug 'voldikss/vim-floaterm'
    let g:floaterm_keymap_toggle = '<F1>'
    highlight FloatermBorder guibg=none
" repeat plugin commands with .
Plug 'tpope/vim-repeat'
" add Nerd Font support to vim
Plug 'ryanoasis/vim-devicons'
call plug#end()

" vim options ----------------------------------------------------------------
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
" see :h shortmess
set shortmess=asIc
set foldmethod=syntax
set laststatus=2
" I already have a statusbar
set noshowmode
" preview commands as you type
set inccommand=nosplit
" turn off signcolumn
set signcolumn=no
" make key code timeout small (to combat lag when hitting <ESC>
set ttimeout ttimeoutlen=10
set showcmd

" filetypes
autocmd BufNewFile,BufFilePre,BufRead *.rkt set filetype=racket

" mappings and other fun -----------------------------------------------------
nmap <C-L><C-L> :set invrelativenumber<CR>
nnoremap <tab> <C-W>w

" italics support
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" don't you just hate it when you accidentally type
" :Q or :W instead of :q and :w
" and vim doesn't do what you really meant for it to do?
command! Q q
command! W w

" change cursor style in different modes
if has('nvim')
    set guicursor=n-c-v-sm:hor10-Cursor,i-ci-ve:ver10-Cursor,r-cr-o:block-Cursor
else
    " https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
    let &t_SI.="\e[6 q" " line       insert
    let &t_SR.="\e[2 q" " block      replace
    let &t_EI.="\e[4 q" " underscore normal
endif

" correcting spelling mistakes on the fly
inoremap <C-k> <c-g>u<Esc>[s1z=`]a<c-g>u

" this is the only useful function from $VIMRUNTIME/defaults.vim that isn't
" already in this .vimrc.
" it sends the editor back to the line you were last editing.
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" initialize colorscheme
colorscheme OceanicNext
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE

" setup lsp
lua << EOF
lspc = require'lspconfig'
    lspc.gopls.setup{}
    lspc.rust_analyzer.setup{}
    lspc.tsserver.setup{}
    lspc.pyls.setup{}
    lspc.hls.setup{}
EOF

