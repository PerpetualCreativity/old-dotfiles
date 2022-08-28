" PerpetualCreativity's vim config

syntax on

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
" a good colorsheme
Plug 'embark-theme/vim', { 'as': 'embark' }
  if (has("termguicolors"))
      set termguicolors
  endif
  let g:embark_terminal_italics = 1
Plug '~/projects/editree'
" better file tree (than netrw)
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
  map <F2> <CMD>NERDTreeToggle<CR>
  imap <F2> <esc><CMD>NERDTreeToggle<CR>
" open files with fzf (requires fzf installed)
set rtp+=/usr/local/opt/fzf
Plug 'junegunn/fzf.vim'
  nnoremap <silent> <Space><Space> <CMD>Files<CR>
  nnoremap <silent> <Leader>b      <CMD>Buffers<CR>
  nnoremap <silent> <Leader>w      <CMD>Buffers<CR>
  nnoremap <silent> <Leader>m      <CMD>Marks<CR>
" surround things easily, with (), '', etc
Plug 'tpope/vim-surround'
" gcc<count> comment out line(s), gc in visual. both are toggleable
Plug 'tpope/vim-commentary'
" to auto-format markdown tables.
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeEnable' }
" more targets in vim, including ) and ,
Plug 'wellle/targets.vim'
" automatically highlights and deletes trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
  let g:better_whitespace_enabled=1
  let g:better_whitespace_on_save=1
" switch between single-line and multi-line code
Plug 'AndrewRadev/splitjoin.vim'
" preview css colors
Plug 'RRethy/vim-hexokinase', { 'for': ['html', 'css'], 'do': 'make hexokinase' }
  let g:Hexokinase_highlighters = ['virtual']
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
" treesitter support
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
" language server protocol config
Plug 'neovim/nvim-lspconfig'
  nnoremap gD        <cmd>lua vim.lsp.buf.declaration()<CR>
  nnoremap gd        <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap K         <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap gi        <cmd>lua vim.lsp.buf.implementation()<CR>
  nnoremap <C-k>     <cmd>lua vim.lsp.buf.signature_help()<CR>
  nnoremap <space>D  <cmd>lua vim.lsp.buf.type_definition()<CR>opts)
  nnoremap <space>rn <cmd>lua vim.lsp.buf.rename()<CR>
  nnoremap <space>ca <cmd>lua vim.lsp.buf.code_action()<CR>
  nnoremap gr        <cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <space>e  <cmd>lua vim.diagnostic.open_float()<CR>
  nnoremap [d        <cmd>lua vim.diagnostic.goto_prev()<CR>
  nnoremap ]d        <cmd>lua vim.diagnostic.goto_next()<CR>
  nnoremap <space>q  <cmd>lua vim.diagnostic.setloclist()<CR>
  sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=LspDiagnosticsSignError
  sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=LspDiagnosticsSignWarning
  sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=LspDiagnosticsSignInformation
  sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=LspDiagnosticsSignHint
" debugger
Plug 'puremourning/vimspector', {'do': ':VimspectorUpdate'}
  let g:vimspector_install_gadgets = ['CodeLLDB', 'delve', 'local-lua-debugger-vscode', 'vscode-firefox-debug']
  nmap <F4>         <Plug>VimspectorContinue
  nmap <F5>         <Plug>VimspectorStop
  nmap <leader><F4> <Plug>VimspectorRestart
  nmap <F6>         <Plug>VimspectorPause
  nmap <F7>         <Plug>VimspectorToggleBreakpoint
  nmap <leader><F7> <Plug>VimspectorToggleConditionalBreakpoint
  nmap <F8>         <Plug>VimspectorAddFunctionBreakpoint
  nmap <leader><F8> <Plug>VimspectorAddFunctionBreakpoint
  nmap <F9>         <Plug>VimspectorStepOver
  nmap <F10>        <Plug>VimspectorStepInto
  nmap <F11>        <Plug>VimspectorStepOut
" use lsp or treesitter for omnicomplete
Plug 'hrsh7th/nvim-compe'
  let g:compe = {}
    let g:compe.enabled = v:true
    let g:compe.autocomplete = v:true
    let g:compe.debug = v:false
    let g:compe.min_length = 1
    let g:compe.preselect = 'disable'
    let g:compe.throttle_time = 80
    let g:compe.source_timeout = 200
    let g:compe.resolve_timeout = 800
    let g:compe.incomplete_delay = 400
    let g:compe.max_abbr_width = 100
    let g:compe.max_kind_width = 100
    let g:compe.max_menu_width = 100
    let g:compe.documentation = v:true
    let g:compe.source = {}
      let g:compe.source.path = v:true
      let g:compe.source.buffer = v:true
      let g:compe.source.calc = v:true
      let g:compe.source.nvim_lsp = v:true
      let g:compe.source.nvim_lua = v:true
      let g:compe.source.emoji = v:true
  inoremap <silent><expr> <tab> pumvisible() ? "\<c-n>" : "\<TAB>"
  inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"
" auto-close pairs
Plug 'cohama/lexima.vim'
  autocmd FileType commonlisp let b:lexima_disabled=1
" visualise the Vim undo tree
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
  map <F3> <CMD>UndotreeToggle<CR>
" floating terminal for neovim
Plug 'numtostr/FTerm.nvim'
  map <F1> <CMD>lua require'FTerm'.toggle()<CR>
  map! <F1> <CMD>lua require'FTerm'.toggle()<CR>
  tmap <F1> <C-\><C-n><CMD>lua require'FTerm'.toggle()<CR>
" repeat plugin commands with .
Plug 'tpope/vim-repeat'
" automatically detect tab/space
Plug 'tpope/vim-sleuth'
" automatically close HTML tabs
Plug 'alvan/vim-closetag'
  let g:closetag_filenames = '*.html'
" better common lisp editing
Plug 'vlime/vlime', {'for': 'commonlisp', 'rtp': 'vim/'}
" amazing lisp editing using indents or parentheses
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}
call plug#end()

" vim options ----------------------------------------------------------------
" Disable annoying error bells
set noerrorbells
set vb t_vb=
set number
" tab configuration
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
set foldmethod=syntax
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
set laststatus=3
" I already have a statusbar
set noshowmode
" preview commands as you type
set inccommand=nosplit
" make key code timeout small (to combat lag when hitting <ESC>
set ttimeout ttimeoutlen=10
set showcmd
set signcolumn=yes

" filetypes
autocmd BufNewFile,BufFilePre,BufRead *.rkt set filetype=racket
autocmd BufNewFile,BufFilePre,BufRead *.lisp set filetype=commonlisp
autocmd BufNewFile,BufFilePre,BufRead *.vim set shiftwidth=2

" mappings and other fun -----------------------------------------------------
map Y y$
nmap <C-l><C-l> <CMD>set invrelativenumber<CR>
nmap <tab> <C-w>w
nmap <S-tab> <C-w>W

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
inoremap <m-k> <C-g>u<Esc>[s1z=`]a<C-g>u

" this is the only useful function from $VIMRUNTIME/defaults.vim that isn't
" already in this .vimrc.
" it sends the editor back to the line you were last editing.
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" remember folds on save
" https://stackoverflow.com/a/54739345
augroup remember_folds
  autocmd!
  autocmd BufWinLeave *.* mkview 1
  autocmd BufWinEnter *.* silent! loadview 1
augroup END

" initialize colorscheme
colorscheme embark
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
hi StatusLine guifg=g:terminal_color_15 guibg=g:terminal_color_7
hi StatusLineNC guifg=g:terminal_color_0 guibg=g:terminal_color_7

" statusline and tabline -----------------------------------------------------

function s:stl_hi(...)
  execute 'highlight User' . a:1 . ' guibg=g:terminal_color_7 guifg=' . a:2 . ' cterm=' . a:3 . ' gui=' . a:3
endfunction
" reset / treesitter
call s:stl_hi(1, g:terminal_color_8, 'none')
" blue bold
call s:stl_hi(2, g:terminal_color_12, 'bold')
" blue normal
call s:stl_hi(3, g:terminal_color_12, 'none')
" cyan italic
call s:stl_hi(4, g:terminal_color_14, 'italic')
" cyan bold
call s:stl_hi(5, g:terminal_color_14, 'bold')
" magenta
call s:stl_hi(6, g:terminal_color_13, 'bold')
" red
call s:stl_hi(7, g:terminal_color_1,  'bold')
" yellow
call s:stl_hi(8, g:terminal_color_11, 'bold')
" green
call s:stl_hi(9, g:terminal_color_10, 'bold')

set statusline=%1*
set statusline+=%5*%{mode()}%1*
" git branch.
if system('git rev-parse') !~? 'fatal'
  let branchname=substitute(system('git branch --show-current'), '\n\+$', '', '')
  set statusline+=\ \<%4*%{branchname}%1*\>
else
  set statusline+=\ \·
endif

" filename
set statusline+=\ %1*%{fnamemodify(bufname(\"%\"),\":~:.:h\")}/
set statusline+=%2*%{fnamemodify(bufname(\"%\"),\":t:r\")}
" modified
set statusline+=%{%&modified?'%7*':&readonly?'%8*':'%5*'%}.
set statusline+=%3*%{fnamemodify(bufname(\"%\"),\":e\")}

set statusline+=%= " divide the statusline to the right

" lsp diagnostics
set statusline+=%8*%{%luaeval('#vim.diagnostic.get(0,{severity=vim.diagnostic.severity.HINT})')%}%1*\·
set statusline+=%9*%{%luaeval('#vim.diagnostic.get(0,{severity=vim.diagnostic.severity.INFO})')%}%1*\·
set statusline+=%6*%{%luaeval('#vim.diagnostic.get(0,{severity=vim.diagnostic.severity.WARN})')%}%1*\·
set statusline+=%7*%{%luaeval('#vim.diagnostic.get(0,{severity=vim.diagnostic.severity.ERROR})')%}%1*

" tabline

function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let s .= '%1*<'
    let x = i+1
    if x == tabpagenr()
      let s .= '%4*'
    else
      let s .= '%2*'
    endif

    let n = '' " buffer names
    let m = 0 " tab modified
    for b in tabpagebuflist(i+1)
      if getbufvar(b, "&modifiable")
        let n .= fnamemodify(bufname(b), ':t') . ' | '
      endif
      if getbufvar(b, "&modified")
        let m += 1
      endif
    endfor
    let s .= substitute(n, ' | $', '', '')
    if m>0
      let s .= '%7* +'
    endif
    let s .= '%1*> '
  endfor
  return s
endfunction
set tabline=%!Tabline()

lua << EOF
-- lsp
lspc = require'lspconfig'
lsps = { 'gopls', 'rust_analyzer', 'tsserver', 'pylsp', 'hls', 'racket_langserver', 'sumneko_lua' }
for _,lsp in ipairs(lsps) do
  lspc[lsp].setup{}
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with (
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = true,
    signs = true,
  }
)
-- treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = { "phpdoc" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
}
EOF
