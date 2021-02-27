"----------------------------------
"" Plugins
"----------------------------------

" Install vim-plug if missing
let vim_plug_path = stdpath('data') . '/site/autoload/plug.vim'
let vim_config_path = stdpath('config') . '/init.vim'
if empty(glob(vim_plug_path))
    silent exe '!curl -fLo ' . vim_plug_path . ' --create-dirs '
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    exe 'source ' . vim_config_path
    PlugInstall --sync
endif

call plug#begin(stdpath('data') . '/plugged')

" Linting
Plug 'dense-analysis/ale'

" Airline tag plugin
Plug 'vim-airline/vim-airline'

" Debugging
Plug 'puremourning/vimspector'

" fzf for vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Navigate vim and tmux seamlessly
Plug 'christoomey/vim-tmux-navigator'

" Git + vim integration
Plug 'tpope/vim-fugitive'

" Git + vim git gutter
Plug 'airblade/vim-gitgutter'

" Detect the right indentation rules
Plug 'tpope/vim-sleuth'

" double check which are needed
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

" Markdown
Plug 'shime/vim-livedown'

" Coc - autocomplete n more
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-python'

" Nerd tree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Nerd commentor
Plug 'preservim/nerdcommenter'

" Reading mode
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" REPL for python
Plug 'sillybun/vim-repl'

" Floating terminal
Plug 'voldikss/vim-floaterm'

call plug#end()

"----------------------------------
"" General Defaults
"----------------------------------

" Set leader to spacebar
let mapleader = "\<Space>"

" Source the file
nnoremap <Leader>sv :source $MYVIMRC<CR>

" Start scrolling when cursor is two before top or bottom
set scrolloff=2

set expandtab

" Don't create a swap file
set noswapfile

" Don't let it wrap text
set nowrap

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" " mapping of <C-L> below)
set hlsearch

" Colorscheme
colorscheme distinguished

" default colorscheme switcher, when opening markdown it switches to default
noremap <leader>dc :colorscheme distinguished<CR>

" Set the history of commands
set history=1000

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Set paste option toggle when copying from system TODO NEED TO CHANGE NOW GOT
" VIMSPECTOR DEBUGGERS
"set pastetoggle=<F10>

" Set copy and paste in visual mode
vnoremap <C-c> :w !pbcopy<CR><CR>
noremap <C-v> :r !pbpaste<CR><CR>

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" turn hybrid line numbers on
:set number relativenumber

" Set syntax highlighting
syntax on

" Make the 88th column stand out
"highlight ColorColumn ctermbg=magenta

" regex you are at the first line virtually
"call matchadd('ColorColumn', '\%88v', 88)

" Show trailing tabs and white spaces
set listchars=tab:>~,nbsp:_,trail:.
set list

" Add spell check to document
nnoremap <Leader>SC :setlocal spell spelllang=en_gb<enter>

" Remap ; to :
nnoremap ; :
nnoremap : ;

" Set - to swap current line and one below over
nmap - ddp

" Remove trailing whitespace
nnoremap rws :%s/\s\+$//e

" To write the time
nnoremap <leader>gd :pu=strftime('%d-%m-%y')<enter>

" To fix spelling of word under cursor (choose first option)
nnoremap <leader>tt 1z=

" Remap S to :w (save) as S is the same as cc
nnoremap S :w<enter>

" Get current filepath in clipboard
nnoremap <leader>gfp :let @+=@%<CR>

" Make current split full screen and close again
noremap Zz <c-w>_ \| <c-w>\|
noremap Zo <c-w>=

" Set cursor line
set cursorline

" Remembers undo file as well as deleting those that are over 90 days old
set undofile
set undodir=~/.vim/undodir
let s:undos = split(globpath(&undodir, '*'), "\n")
call filter(s:undos, 'getftime(v:val) < localtime() - (60 * 60 * 24 * 90)')
call map(s:undos, 'delete(v:val)')

" Set the python providers virtual envs
let g:python_host_prog = '/Users/alistair.hughes/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/alistair.hughes/.pyenv/versions/neovim3/bin/python'

"--------------------------------
" Useful functions
"--------------------------------

" remap :cl to console log depending on file type, show appropiate debugging
autocmd FileType javascript map <Leader>cl yiwoconsole.log('<c-r>"', <c-r>");<Esc>^
autocmd FileType python nmap <Leader>cl yiwoprint(f"<c-r>"= {<c-r>"}")<Esc>^

" TODO: Think of good leader, <leader>t is good for terminal
" Run unit tests
"nnoremap <leader>ruta :call term_start('./run-unit-tests.sh', {'vertical': 1})<CR>
"nnoremap <leader>ta :call term_start('./run-unit-tests.sh', {'cwd': 'lambdas', 'vertical': 1})<CR>

" Convert to function to prettify, but runs current test under the cursor
"nnoremap <leader>rut :call term_start('pipenv run python -m pytest ' . expand('%:s?lambdas/??')  . '::' . expand('<cword>'), {'vertical': 1})<CR>
"nnoremap <leader>t :call term_start('pipenv run python -m pytest ' . expand('%:s?lambdas/??')  . '::' . expand('<cword>'), {'cwd': 'lambdas', 'vertical': 1})<CR>

"--------------------------------
" ALE settings
"--------------------------------

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1

let g:ale_cache_executable_check_failures = 1

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black', 'isort', 'autopep8'],
\}

let g:ale_linters = {
\   'python': ['flake8', 'mypy'],
\}

"" For black linter
let g:ale_python_flake8_options="--max-line-length=88"

"--------------------------------
" Markdown settings
"--------------------------------

" Set syntax to markdown
nnoremap MD :set syntax=markdown

:augroup markdownstyling
:  au!
:  au BufNewFile,BufFilePre,BufRead *.markdown,*.md colorscheme default
:  au BufNewFile,BufFilePre,BufRead *.markdown,*.md syntax on
:  au BufNewFile,BufFilePre,BufRead *.markdown,*.md highlight clear SpellBad
:  au BufNewFile,BufFilePre,BufRead *.markdown,*.md highlight SpellBad cterm=underline,bold ctermfg=blue
:augroup END

" remap :cl to console log depending on file type, show appropiate debugging
autocmd FileType javascript map <Leader>cl yiwoconsole.log('<c-r>"', <c-r>");<Esc>^
autocmd FileType php nmap <Leader>cl yiwodie(var_dump('<c-r>"', $<c-r>"));<Esc>^
autocmd FileType python nmap <Leader>cl yiwoprint(f"<c-r>"= {<c-r>"}")<Esc>^

"------------------------------------------------------------
"" LiveDown
"------------------------------------------------------------

" open
nnoremap <Leader>gm :LivedownToggle<CR>

" Should markdown preview get shown automatically upon opening markdown buffer

" Should the browser window pop-up upon previewing
let g:livedown_open = 1

"------------------------------------------------------------
"" Highlighting settings
"------------------------------------------------------------

" This rewires n and N to do the highlighting
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>

" Highlighting colour
highlight WhiteOnRed ctermbg=red

" Blink highlight the match that you are on
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

"------------------------------------------------------------
"" FZF.vim settings
"------------------------------------------------------------

" Ctrl p to find files
nnoremap <C-p> :Files<Cr>

" Ctrl o to find in files
nnoremap <leader>o :Ag<Cr>

" Floating window preview
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" Ignore files in .gitingore
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Exclude filenames and numbers in :Ag
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

"------------------------------------------------------------
"" Coc Settings
"------------------------------------------------------------

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')

" Use ctrl space to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" tab for snippets
let g:coc_snippet_next = '<tab>'

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Run selected in python repl
vnoremap <leader>rr :CocCommand python.execSelectionInTerminal<cr>

" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"------------------------------------------------------------
"" VIM-REPL
"------------------------------------------------------------

nnoremap <leader>r :REPLToggle<CR>
let g:repl_position = 0

autocmd Filetype python nnoremap <F6> <Esc>:REPLDebugStopAtCurrentLine<Cr>
autocmd Filetype python nnoremap <F7> <Esc>:REPLPDBN<Cr>
autocmd Filetype python nnoremap <F8> <Esc>:REPLPDBS<Cr>

"------------------------------------------------------------
"" Nerd tree
"------------------------------------------------------------

let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
nnoremap VE :NERDTreeFind<CR>

"------------------------------------------------------------
"" Fugitive
"------------------------------------------------------------

" Open diffs in vertical split
:set diffopt+=vertical

"------------------------------------------------------------
"" Limelight
"------------------------------------------------------------

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
nmap <Leader>ll <Plug>(Limelight)
xmap <Leader>ll <Plug>(Limelight)

"------------------------------------------------------------
"" SnipMate
"------------------------------------------------------------

" Use new SnipMate
let g:snipMate = { 'snippet_version' : 1 }

"------------------------------------------------------------
"" Buffer
"------------------------------------------------------------

" Swap buffers
nmap <leader>sb <C-w>x

"------------------------------------------------------------
"" Vimspector debugging
"------------------------------------------------------------

let g:vimspector_enable_mappings = 'HUMAN'

"------------------------------------------------------------
"" Line wrapping navigation
"------------------------------------------------------------

let s:wrapenabled = 0
function! ToggleWrap()
  set wrap nolist
  if s:wrapenabled
    set nolinebreak
    unmap j
    unmap k
    unmap 0
    unmap ^
    unmap $
    let s:wrapenabled = 0
  else
    set linebreak
    nnoremap j gj
    nnoremap k gk
    nnoremap 0 g0
    nnoremap ^ g^
    nnoremap $ g$
    vnoremap j gj
    vnoremap k gk
    vnoremap 0 g0
    vnoremap ^ g^
    vnoremap $ g$
    let s:wrapenabled = 1
  endif
endfunction
map <leader>ww :call ToggleWrap()<CR>

"------------------------------------------------------------
"" Float term
"------------------------------------------------------------

let g:floaterm_keymap_toggle = '<Leader>ft'
let g:floaterm_keymap_kill = '<Leader>fk'
let g:floaterm_keymap_next = '<Leader>fn'
let g:floaterm_keymap_prev = '<Leader>fp'
let g:floaterm_keymap_new = '<Leader>ff'
