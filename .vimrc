" Vim-plug install command
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Update plugins by typing :PlugInstall in vim command line

" -------- BEGIN Options that work with vanilla vim ('vanilla') --------

" " Set leader key to spacebar
map <SPACE> <leader>

" **** Necessary (for me) settings ('necessary') ****
" Dope numbering scheme
set number
set relativenumber

" Miscellaneous things that work nice
set nocompatible
set hidden
set showcmd
set ignorecase
set smartcase
set incsearch
set nohlsearch
set showmode
set showmatch
set nowrapscan
set scrolloff=5
set undofile

set backspace=indent,eol,start

" Splitting windows
set splitbelow
set splitright

" Indenting stuff
set tabstop=2
set shiftwidth=2
set expandtab

" Buffer navigation
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>bl :ls<CR>

" Change temp files to store in ~/.vim
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" **** Might conflict with plugins or can be plain old annoying ('conflict' 'annoying') ****
set autochdir
set cursorline
set concealcursor=n

" Popup window for auto-completion (check if this screws with any plugins)
set wildmenu
set wildmode=list:longest

" Edit .vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>

" Wrapped line movement
nnoremap j gj
nnoremap k gk

" Autocomplete line
inoremap <C-l> <C-x><C-l>

" Find tags file (not necessary with coc or YouCompleteMe)
" set tags=./tags;/

" Enable 256 color in terminal (doesn't always work when screen-256color isn't installed)
set term=screen-256color

command! -nargs=1 Silent
\   execute 'silent !clear -x'
\ | execute 'silent !' . <q-args>
\ | execute 'redraw!'

" Shortcut for previewing markdown files
nnoremap <C-m> :Silent view_md %<CR>

" **** autocmds section ('autocmd') ****
" Don't expand tab in Makefiles
autocmd FileType make set noexpandtab

" Set text wrap with to 70 for compatibility with David's editor. Might not be
" necessary anymore
" This affects BOTH autowrap and the gq command
autocmd FileType c,cpp,java,tex,txt,sml,rb,html,xml,dot,py autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
autocmd FileType tex set textwidth=75
autocmd FileType plaintex set textwidth=75
autocmd FileType latex set textwidth=75

" llvm IR syntax highlighting
augroup filetype
  au! BufRead,BufNewFile *.ll     set filetype=llvm
augroup END

" Reopen files where I left off
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" -------- END Options that work with vanilla vim ('vanilla') --------

" -------- BEGIN vim-plug plugins to install ('vim-plug' 'plugged) --------

" Automatically install vim-plug if it isn't installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" **** Visual enhancement plugins ****
" Show trailing whitespace
Plug 'vim-scripts/ShowTrailingWhitespace'
" Show indentation levels
Plug 'Yggdroot/indentLine'
" Show the undotree
 Plug 'mbbill/undotree'
" Diff specific lines in a file
Plug 'AndrewRadev/linediff.vim'
" Show git diff in gutter
Plug 'airblade/vim-gitgutter'
" Dank status bar
Plug 'vim-airline/vim-airline'

" **** Shortcut plugins ****
" Better netrw
Plug 'tpope/vim-vinegar'
" Comment and uncomment blocks of code
Plug 'tpope/vim-commentary'
" Automatic closing of brackets, quotes, etc.
Plug 'raimondi/delimitmate'
" Seamlessly switch between vim windows and tmux panes
Plug 'christoomey/vim-tmux-navigator'
" Close buffer without closing window
Plug 'qpkorr/vim-bufkill'
" Navigating buffers
Plug 'jeetsukumaran/vim-buffergator'
" Fuzzy file/buffer finder
Plug 'ctrlpvim/ctrlp.vim'

" **** Linter
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" **** Git ****
" enough said
Plug 'tpope/vim-fugitive'

" **** fzf ****
Plug 'junegunn/fzf.vim'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" **** Colorschemes ****
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'junegunn/seoul256.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'AlessandroYorba/Alduin'
Plug 'pgdouyon/vim-yin-yang'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasiser/vim-code-dark'

call plug#end()

" -------- END vim-plug plugins to install ('vim-plug' 'plugged) --------

" -------- BEGIN Options related to vim plugins ('plugins') --------
" Set colorscheme
set background=dark
colorscheme codedark

" **** indentLine ****
" set character list for indents
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" **** vim-airline ****
" set theme
let g:airline_theme = 'codedark'
" Enable list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
" Enable coc integration
let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = 'E:'
let airline#extensions#coc#warning_symbol = 'W:'
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

" **** ctrlp ****
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_by_filename = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.gz,*.zip,*.o

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.vim/ctrlp_cache'

" **** coc.nvim ****
let g:coc_global_extensions = ['coc-clangd', 'coc-cmake', 'coc-fzf-preview', 'coc-json', 'coc-python', 'coc-sh', 'coc-todolist']

" Increase size of command window
set cmdheight=2
" Make things update faster
set updatetime=300
" Don't pass messages to |ins-completion-menu|
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" -------- END Options related to vim plugins ('plugins') --------

" -------- BEGIN Macros ('macro') --------

"Insert a comment block
let @z='i/******************************************************************************/'

" -------- END Macros ('macro') --------
