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
" Plug 'mhartington/oceanic-next'
"   if (has("termguicolors"))
"       set termguicolors
"   endif
"   let g:oceanic_next_terminal_bold = 0
"   let g:oceanic_next_terminal_italic = 1
"   syntax on
Plug 'embark-theme/vim', { 'as': 'embark' }
  if (has("termguicolors"))
      set termguicolors
  endif
  let g:embark_terminal_italics = 1
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
  " set foldmethod=expr
  " set foldexpr=nvim_treesitter#foldexpr()
" Language Server Protocol config
Plug 'neovim/nvim-lspconfig'
  nnoremap gD        <Cmd>lua vim.lsp.buf.declaration()<CR>
  nnoremap gd        <Cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap K         <Cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap gi        <Cmd>lua vim.lsp.buf.implementation()<CR>
  nnoremap <C-k>     <Cmd>lua vim.lsp.buf.signature_help()<CR>
  nnoremap <space>wa <Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
  nnoremap <space>wr <Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
  nnoremap <space>wl <Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
  nnoremap <space>D  <Cmd>lua vim.lsp.buf.type_definition()<CR>opts)
  nnoremap <space>rn <Cmd>lua vim.lsp.buf.rename()<CR>
  nnoremap <space>ca <Cmd>lua vim.lsp.buf.code_action()<CR>
  nnoremap gr        <Cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <space>e  <Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
  nnoremap [d        <Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
  nnoremap ]d        <Cmd>lua vim.lsp.diagnostic.goto_next()<CR>
  nnoremap <space>q  <Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
  sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=LspDiagnosticsSignError
  sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=LspDiagnosticsSignWarning
  sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=LspDiagnosticsSignInformation
  sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=LspDiagnosticsSignHint
" use lsp or treesitter for omnicomplete
Plug 'nvim-lua/completion-nvim'
  set completeopt=menuone,noinsert,noselect
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" <CMD> "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" <CMD> "\<S-Tab>"
  autocmd BufEnter * lua require'completion'.on_attach()
  imap <tab> <Plug>(completion_smart_tab)
  imap <s-tab> <Plug>(completion_smart_s_tab)
  let g:completion_enable_auto_popup = 1
  let g:completion_enable_snippet = 'UltiSnips'
  let g:completion_sorting = 'length'
  let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
  Plug 'SirVer/ultisnips'
    let g:UltiSnipsExpandTrigger="<M-d>"
    let g:UltiSnipsJumpForwardTrigger="<M-f>"
    let g:UltiSnipsJumpBackwardTrigger="<M-f>"
    Plug 'honza/vim-snippets'
" auto-close pairs
Plug 'cohama/lexima.vim'
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

" initialize colorscheme
colorscheme embark
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
hi StatusLine guifg=g:terminal_color_15 guibg=g:terminal_color_7
hi StatusLineNC guifg=g:terminal_color_0 guibg=g:terminal_color_7

" statusline and tabline -----------------------------------------------------
" design inspired by bubbly, but logic is completely different.

" statusline

function s:stl_hi(...)
  execute 'highlight User' . a:1 . ' guibg=' . a:2 . ' guifg=' . a:3 . ' gui=' . ((a:0==4) ? a:4 : 'bold')
endfunction
function s:stl_hi_both(group, bgcolor, fgcolor)
  call s:stl_hi(a:group  , a:bgcolor, a:fgcolor)
  call s:stl_hi(a:group+1, a:fgcolor, a:bgcolor)
endfunction

" reset / treesitter
call s:stl_hi(1, g:terminal_color_7, g:terminal_color_8, 'none')
" cyan
call s:stl_hi_both(2, g:terminal_color_7, g:terminal_color_14)
" blue
call s:stl_hi_both(4, g:terminal_color_7, g:terminal_color_12)
" magenta
call s:stl_hi_both(6, g:terminal_color_7, g:terminal_color_13)
" red
call s:stl_hi_both(8, g:terminal_color_7, g:terminal_color_1)

set statusline=
set statusline+=%2*%3*
set statusline+=%{mode()}
set statusline+=%2*\ %1*
" git branch.
if system('git rev-parse') !~? 'fatal'
  let branchname=substitute(system('git branch --show-current'), '\n\+$', '', '')
  set statusline+=%6*%7*
  set statusline+=%{branchname}
  set statusline+=%6*\ %1*
endif

set statusline+=%4*%5*
" filename
set statusline+=%f
" modified
set statusline+=%{%&modified?'\ %9*\ +%8*':'%4*'%}
set statusline+=\ %1*

set statusline+=%= " divide the statusline to the right

" treesitter statusline
set statusline+=%{(nvim_treesitter#statusline()=='null')?'':nvim_treesitter#statusline().'\ '}

" lsp diagnostics
set statusline+=%6*%7*
set statusline+=%{luaeval('vim.lsp.diagnostic.get_count(0,[[Warning]])')}\ 
set statusline+=%9*
set statusline+=\ %{luaeval('vim.lsp.diagnostic.get_count(0,[[Error]])')}
set statusline+=%8*%1*

" tabline

function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let x = i+1
    if x == tabpagenr()
      let s .= '%2*%3*'
    else
      let s .= '%4*%5*'
    endif

    let s .= '%' . x . 'T'
    let s .= x . ' '

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

    let n = substitute(n, ' | $', '', '')
    let s .= n

    if m > 0
      let s .=' %9* +%8*'
    else
      if x == tabpagenr()
        let s .= '%2*'
      else
        let s .= '%4*'
      endif
    endif

    let s .= '%1* '
  endfor
  return s
endfunction
set tabline=%!Tabline()

lua << EOF
-- set up lsp
lspc = require'lspconfig'
  lspc.gopls.setup{}
  lspc.rust_analyzer.setup{}
  lspc.tsserver.setup{}
  lspc.pylsp.setup{}
  lspc.hls.setup{}
  lspc.racket_langserver.setup{}
-- set up treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = { enable=true },
}
EOF

