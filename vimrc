"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" V I M !
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Initialize plugins {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible

if has('win32')
  let $VIMHOME = $HOME."/vimfiles"
else
  let $VIMHOME = $HOME."/.vim"
endif
" Include custom plugins
set runtimepath^=$VIMHOME/plugin

call plug#begin('$VIMHOME/plugged')

Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chaoren/vim-wordmotion'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-commentary'
Plug 'wesQ3/vim-windowswap'
if has('python3') || has('python')
  Plug 'SirVer/ultisnips'
endif
Plug 'jlanzarotta/bufexplorer'
" emmett type plugin
" Plug 'rstacruz/sparkup'
Plug 'mxw/vim-jsx'
" Plug 'posva/vim-vue'
Plug 'storyn26383/vim-vue'
Plug 'pangloss/vim-javascript'
" ALE for syntax checking
" https://www.vimfromscratch.com/articles/vim-and-language-server-protocol/
Plug 'dense-analysis/ale'
" Completion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'deoplete-plugins/deoplete-jedi'
endif

" Notes
" Plug 'nicocrm/vim-notes'
" Fuzzy finder does not work on Windows but is a lot faster than ctrl P and has more options
if !has('win32')
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
endif
" light weight file explorer
Plug 'jeetsukumaran/vim-filebeagle'
" AUtomatically insert matching parentheses, but it's usually more of a PIA than anythign else
" Plug 'Raimondi/delimitMate'
" PHP
Plug 'captbaritone/better-indent-support-for-php-with-html'
Plug 'shawncplus/phpcomplete.vim'
" Go Language plugin
" Plug 'fatih/vim-go'
" typescript syntax
" Plug 'leafgarland/typescript-vim'
" Arduino
" Plug 'sudar/vim-arduino-syntax'
" Plug 'sudar/vim-arduino-snippets'
"
" Python {{{
" maybe: https://github.com/jmcantrell/vim-virtualenv
" Very useful, includes text objects like "ii" for stuff at the current indent level
" https://www.vim.org/scripts/script.php?script_id=3037
Plug 'michaeljsmith/vim-indent-object'
Plug 'Vimjas/vim-python-pep8-indent'
" python object motion.  ]], [[, ]m, ]M, etc
Plug 'jeetsukumaran/vim-pythonsense'
" if has('nvim')
"   Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" end
" }}}

" Not sure because ALE can already do that
Plug 'sbdchd/neoformat'
" Plug 'ejholmes/vim-forcedotcom'
Plug 'rking/ag.vim'

call plug#end()

" runtime bundle/vim-pathogen/autoload/pathogen.vim
" execute pathogen#infect()
" filetype plugin on
" filetype indent on
"
" runtime macros/matchit.vim

" }}}

" VIM user interface {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set mouse=a
set title
set history=50
set wildmenu "Turn on WiLd menu
set wildignore+=.git,*.exe,*.dll,*.so,node_modules,.meteor,*.map
set ignorecase "Ignore case when searching
set smartcase
set number " show line numbers
" I turned the following off because it makes it difficult to use things like Ctrl-P...
" and use a mapping instead
" set autochdir " Automatically change to current file directory

set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink
set visualbell
set ruler
set showcmd
set laststatus=2  " show status bar always
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set hidden    " allow hidden buffers
set foldlevel=5   " open folds by default, up to 5 levels
" set clipboard=unnamed  " use default clipboard for yanking operations

" Use relative line numbers, but turn it off when focus is lost, so that we can see the error messages
" au FocusLost * set nornu
" au FocusGained * set rnu

if has('gui_running')
  set guioptions-=T
  set guioptions-=m
  " lines / columns for default size, this is set in .gvimrc instead
  " so that we can re-source vimrc with no ill effect
" set lines=35 columns=150
else
  if has("x11")
    " this is for Vim - does not have any effect in neovim
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[4 q"
    let &t_EI = "\<Esc>[2 q"
  endif
  let g:solarized_termcolors=256
endif

" Color scheme
" t_Co is needed for molokai in xterm
set t_Co=256
" Note when using molokai, bg should be before the color declaration
set bg=dark
" colo molokai
colo distinguished
" colo solarized
" let g:airline_theme='solarized_flood'
" call togglebg#map("<F5>")

syntax on

" }}}

" {{{
" Sandwich: do not use the default keymaps, because they'll bind the "s" key which I use quite often

runtime macros/sandwich/keymap/surround.vim

" }}}

" ALE {{{
" Something to revisit when nvim 0.5 comes out, since it will have native support for LSP

" Don't check too fast while typing
" let g:ale_lint_delay = 500
" Or, don't check at all while typing
" let g:ale_lint_on_text_changed = "never"
" But make sure we check when we leave insert mode
let g:ale_lint_on_insert_leave = 1
" ALEDetail
nmap <silent> <leader>D <Plug>(ale_detail)
" ALEHover
nmap <silent> K <Plug>(ale_hover)
" ALEFindReferences
nmap <silent> gr <Plug>(ale_find_references)
" ALEGoToDefinition
nmap <silent> gd <Plug>(ale_go_to_definition_in_tab)
" nmap <silent> gtd <Plug>(ale_go_to_definition_in_tab)
" ALEFix
" Bind F8 to fixing problems with ALE
nmap <F8> <Plug>(ale_fix)
" move to the next ALE warning / error
nnoremap ]r :ALENextWrap<CR>
" move to the previous ALE warning / error
nnoremap [r :ALEPreviousWrap<CR>

" }}}

" Files, backups and undo {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile
set autowrite
set autoread
set tags=./tags;

"Persistent undo
try
    if MySys() == "windows"
      set undodir=C:\Windows\Temp
    else
      set undodir=~/.vim_runtime/undodir
    endif

    set undofile
catch
endtry
au FocusGained * checktime

" }}}

" Text, tab and indent related {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=indent,eol,start
set expandtab
set shiftwidth=2
set tabstop=2
set smarttab

set linebreak   " break at sensible character
set tw=500

set autoindent "Auto indent
set nosmartindent "Smart indet
set wrap "Wrap lines
" do not show preview window on complete
" set completeopt-=preview
"
" }}}

" Mappings {{{
""""""""""""""""""""""""""""""

" Use space bar for leader
let mapleader = " "

" Use jj for escape (try this instead of jk?)
" Make using Ctrl+C do the same as Escape, to trigger autocmd commands
inoremap <C-c> <Esc>
inoremap jj <esc>
" JJ for newlines?
inoremap JJ <cr>

" Use ctrl-J for return
" (this mapping is temporary)
" (remove this no longer necessary with new keyboard)
"inoremap <cr> <nop>

" Allow C-S to save from insert mode
inoremap <c-s> <c-o>:w<cr>

" Quick movement in insert mode (not too sure about this one)
inoremap OO <c-o>O

" select pasted selection
nnoremap gp `[v`]

" I tried those but it ends up being easier to use ultisnips for this type stuff
" inoremap {} {<cr>}<c-o>O
" inoremap ({} ({<cr>})<c-o>O

" Alt-slash for toggle comment
" (I put alt instead of control because the C-/ mapping does not seem to work right)
"nmap // gcc  " this one is annoying, it messes up my search prompt
nmap <M-/> gcc
nmap <C-/> gcc

" Change current directory to that of the file
nnoremap <leader>cd :cd %:h<cr>
nnoremap <leader>lcd :lcd %:h<cr>
" This is like gf but will also edit a file that does not exist yet
nnoremap <leader>gf :e <cfile><cr>

" CoPy: Quick copy of the current buffer to system clipboard
nnoremap <silent> <leader>cp :1,$yank +<cr>
" ReFormat: Quick reindent of current buffer
nnoremap <silent> <leader>rf :Neoformat<cr>

" Mute Highlight: Use Alt+L to mute hl search (does not work in term)
" This also does a redraw (useful since I remapped C-l)
nnoremap <silent> <M-l> :nohlsearch<cr><C-l>

" Shortcut to edit the vimrc file and re-source it
nnoremap <leader>ev :tabedit ~/.vim/vimrc<cr>
nnoremap <leader>sv :w<cr>:source ~/.vim/vimrc<cr>:q<cr>

" Buffers

" To open a new empty tab
nmap <leader>T :tabnew<cr>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>BB :bp <BAR> bd #<CR>
nmap <leader>B! :bp <BAR> bd! #<CR>

" Closing tabs
nmap <leader>TT :tabclose<cr>
nmap <leader>T! :tabclose!<cr>
nmap <leader>TO :tabonly<cr>

" Remap split commands so they work vertically
nnoremap  :vnew<cr>
nnoremap  :vsplit #<cr>

" Mappings used for window movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Completion mappings (suggested in help ins-completion)
" Tag completion
inoremap <c-]> <c-x><c-]>
" File name completion
inoremap <c-f> <c-x><c-f>
" Macro definition
" TODO: need to come up with correct include and definition options for javascript
inoremap <c-d> <c-x><c-d>
" Line completion
inoremap <c-l> <c-x><c-l>
" Should maybe bind C-X C-O (omni completion)?

" Shortcut for duplicating a line
nnoremap <C-d> :co .<cr>

" Allow escape in terminal mode
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>
endif

" Copy current file path to clipboard
noremap <silent> <F4> :let @+=expand("%:p")<CR>

" Change cwd to current file path
noremap <leader>cd :lcd %:p:h<cr>1<c-g>

" }}}

" Plugin Variables (and plugin-specific mappings) {{{
""""""""""""""""""""""""""""""
"""""""""""""""
" Command-T: use git for searches, but don't start from the SCM root
"  (I removed it and let it uses its default it generally works better and still is quite fast)
" let g:CommandTFileScanner='git'
" let g:CommandTTraverseSCM='pwd'
let g:CommandTMaxFiles=100000
let g:CommandTSCMDirectories='.git,.idea,.svn'
" allow Alt-T as alternate mapping
"nnoremap <silent> <M-t> :CommandT<cr>
" nnoremap <silent> <leader>tt :CommandT<cr>
" nnoremap <silent> <leader>tb :CommandTBuffer<cr>
" Alt-R Buffer jump in MRU order, not sure I like that yet
"nnoremap <silent> <M-r> :CommandTMRU<cr>

" For JSX indenting in JS files
let g:jsx_ext_required = 0
" To limit the pre-processor support in vim-vue
let g:vue_pre_processors = []

" Neoformat
let g:neoformat_python_isort = {
            \ 'exe': 'isort',
            \ 'args': ['-', '--quiet', '--settings-path /home/odoo/.dotfiles/isort.cfg'],
            \ 'stdin': 1,
            \ }
" let g:neoformat_python_yapf = {
"             \ 'exe': 'yapf',
"             \ 'args': ['--style ~/.style.yapf'],
"             \ 'stdin': 1,
"             \ }
let g:neoformat_python_black = {
                \ 'exe': 'black',
                \ 'stdin': 1,
                \ 'args': ['--line-length', '100', '-q', '-'],
                \ }
let g:neoformat_enabled_python = ['isort', 'black']
"   -- apt install tidy
"   -- npm install -g prettier @prettier/plugin-xml
let g:neoformat_enabled_xml = ['tidy', 'prettier']
" for python this will let us run isort and yapf
let g:neoformat_run_all_formatters = 1

"""""""""""""""
" FZF (fuzzy find everything)
"
" fu! <SID>bufferUnderCursor()
"   try
"     let default_input_save = get(g:, 'ctrlp_default_input', '')
"     let g:ctrlp_default_input = expand('<cword>')
"     CtrlPBuffer
"   finally
"     if exists('default_input_save')
"       let g:ctrlp_default_input = default_input_save
"     endif
"   endtry
" endfu
" nnoremap <silent> <leader>p. :call <SID>bufferUnderCursor()<cr>


function! s:find_git_root()
  " from https://tech.serhatteker.com/post/2019-05/vim-fzf-project-root/
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
" function! <SID>fileUnderCursor()
" Would be nice if we could feed some default input to :Files, to make it do a search for the string under the 
" cursor...  like ctrlp_default_input did


command! ProjectFiles execute 'Files' s:find_git_root()
" Mappings from https://dev.to/iggredible/how-to-search-faster-in-vim-with-fzf-vim-36ko
nnoremap <silent> <C-p> :ProjectFiles<CR>
nnoremap <silent> <leader>p :Files<CR>
" https://github.com/junegunn/fzf.vim/issues/346#issuecomment-288483704
" search in git root
command! -bang -nargs=* ProjectRg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..', 'dir': s:find_git_root()}, <bang>0)
" search in current dir
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
nnoremap <silent> <leader>f :Rg<CR>
nnoremap <silent> <leader>F :ProjectRg<CR>
" search under cursor
nnoremap <silent> <leader>.f "zyiw:exe "Rg ".@z.""<CR>
nnoremap <silent> <leader>.F "zyiw:exe "ProjectRg ".@z.""<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>
" because this one will conflict...
let g:filebeagle_suppress_keymaps=1
map <silent> -  <Plug>FileBeagleOpenCurrentBufferDir

"""""""""""""""
" NERDTree (no longer using, as NETRW is generally good enough and less annoying)
" nnoremap <leader>NT :NERDTree<cr>

" netrw
nnoremap <leader>ex :Explore<CR>
nnoremap <leader>sx :Sex<CR>
" nnoremap <silent> -  :Ex<CR>
" to suppress banner, change to 0
let g:netrw_banner=1
" set current directory from netrw browse dir
let g:netrw_keepdir=0
" to open file in previous window (default is to use same window)
"let g:netrw_browse_split=4

autocmd FileType netrw setl bufhidden=delete


"""""""""""""""
" SPARKUP
" Replace default <C-n> mapping to avoid interfering with VIM completion
let g:sparkupNextMapping = '<c-d>'
let g:sparkupExecuteMapping = '<c-e>'

"""""""""""""""
" VIM AIRLINE
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'   " or short_path
let g:airline#extensions#tabline#show_close_button = 0
let g:airline_highlighting_cache = 1
" " Don't show buffer #, because we already show the index.
" " Show file name, not full path
" let g:airline#extensions#tabline#buffer_nr_show = 0
" let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

"""""""""""""
" Buf Explorer - use upper case letters so they don't conflict
" with Command-T <leader>b mapping for buffer list
" (which is generally more useful than buf explorer)
nnoremap <leader>B :BufExplorer<cr>
nnoremap <leader>BT :ToggleBufExplorer<cr>
nnoremap <leader>BS :BufExplorerHorizontalSplit<cr>
nnoremap <leader>BV :BufExplorerVerticalSplit<cr>

" Set a prefix for VIM WordMotion, so we can keep using the
" standard VIM keys
let g:wordmotion_prefix = ","

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
" prevent recursive mapping on standard c-x c-k (completion)
inoremap <c-x><c-k> <c-x><c-k>

" Sessions (not using right now)
" let g:session_autosave = 'no'

" deoplete-go settings
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
" deoplete-jedi (for Python)
" let g:deoplete#sources#jedi#show_docstring = 0
" Do we want to disable completions?
" let g:jedi#completions_enabled = 0
" deoplete vimtex settings
" if !exists('g:deoplete#omni#input_patterns')
"     let g:deoplete#omni#input_patterns = {}
" endif
" let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
" For debugging
" let g:deoplete#enable_debug = 1
" let g:deoplete#enable_profile = 1
" call deoplete#enable_logging('DEBUG', '/PATH_TO/deoplete.log')<Paste>
let g:deoplete#enable_at_startup = 1
" Avoid slowing down semshi
call deoplete#custom#option('auto_complete_delay', 100)

" Use project root instead of current directory for Ag plugin
" let g:ag_working_path_mode='r'

" }}}


" vim: fdm=marker:ts=2:sw=2
