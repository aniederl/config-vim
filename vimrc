scriptencoding utf-8

" Filename:      .vimrc
" Purpose:       setup file for the VIM editor
" Author:        (c) Andreas Niederl <rico32@gmx.net>
" License:       This file is licensed under the GPL v2.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Local Pre-Initialization {{{1
"===============================================================================

" include local configuration
let s:vimlocalpreconfig = expand($HOME . '/.vim/local.pre.vim')

if filereadable(s:vimlocalpreconfig)
  execute 'source ' . s:vimlocalpreconfig
endif


" Plugin Initialization Settings {{{1
"===============================================================================

" map '-' to ',' so it can be used for reverse character search with f/t/F/T
nnoremap - ,

" use ',' as leader
let mapleader = ','

" use '\' as local leader
let maplocalleader = '\'

" tasklist.vim shortcut
"map <LocalLeader>u <Plug>TaskList

" disable default zoomwintab mappings
let g:zoomwintab_remap = 0

"===============================================================================


" Plugins {{{1
"===============================================================================

" Setup {{{2
"-------------------------------------------------------------------------------

" auto install plug
let s:plugpath = expand($HOME . '/.vim/autoload/plug.vim')
if !filereadable(s:plugpath)
  echo "Downloading Plug..."
  echo ""
  silent execute "!curl --create-dirs -fLo " . s:plugpath . " https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
endif

filetype off

if has('vim_starting')
  set nocompatible
endif

call plug#begin('~/.vim/plugged')


"-------------------------------------------------------------------------------
" vimproc {{{2
"-------------------------------------------------------------------------------

Plug 'Shougo/vimproc', { 'do': 'make' }


"-------------------------------------------------------------------------------
" neocomplete {{{2
"-------------------------------------------------------------------------------

" use new neocomplete completion if possible
let g:use_neocomplete = 0
if v:version >= 704 && has('lua')
  let g:use_neocomplete = 1
  Plug 'Shougo/neocomplete'
  "Plug 'RyanPineo/neocomplete-ultisnips'
else
  Plug 'Shougo/neocomplcache'
endif


"-------------------------------------------------------------------------------
" snippets {{{2
"-------------------------------------------------------------------------------

Plug 'SirVer/ultisnips'

" snippet collection for different languages
Plug 'honza/vim-snippets'

" trigger configuration
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

let g:UltiSnipsEditSplit="vertical"


"-------------------------------------------------------------------------------
" ansible {{{2
"-------------------------------------------------------------------------------

Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh' }

" goto role under cursor
" source: https://gist.github.com/mtyurt/3529a999af675a0aff00eb14ab1fdde3
"let g:ansible_goto_role_paths = './roles,../_common/roles'

function! FindAnsibleRoleUnderCursor()
  if exists("g:ansible_goto_role_paths")
    let l:role_paths = g:ansible_goto_role_paths
  else
    let l:role_paths = "./roles"
  endif
  let l:tasks_main = expand("<cfile>") . "/tasks/main.yml"
  let l:found_role_path = findfile(l:tasks_main, l:role_paths)
  if l:found_role_path == ""
    echo l:tasks_main . " not found"
  else
    execute "edit " . fnameescape(l:found_role_path)
  endif
endfunction

autocmd FileType yaml.ansible nnoremap <Leader>gr :call FindAnsibleRoleUnderCursor()<CR>
autocmd FileType yaml.ansible vnoremap <Leader>gr :call FindAnsibleRoleUnderCursor()<CR>


"-------------------------------------------------------------------------------
" git {{{2
"-------------------------------------------------------------------------------

" git integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'

" gitk for vim
Plug 'gregsexton/gitv'


"-------------------------------------------------------------------------------
" Motions and Regions {{{2
"-------------------------------------------------------------------------------

" motions for CamelCase
Plug 'vim-scripts/camelcasemotion'

" extend % matching
Plug 'vim-scripts/matchit.zip'
Plug 'vim-scripts/ruby-matchit'
Plug 'voithos/vim-python-matchit'

" surroundings, quoting, tags, etc.
Plug 'tpope/vim-surround'

" narrow region extraction/editing
Plug 'chrisbra/NrrwRgn'


"-------------------------------------------------------------------------------
" Sessions {{{2
"-------------------------------------------------------------------------------

" session manager
Plug 'vim-scripts/sessionman.vim'

" session obsession
Plug 'tpope/vim-obsession'


"-------------------------------------------------------------------------------
" General {{{2
"-------------------------------------------------------------------------------

" custom operators
Plug 'kana/vim-operator-user'

" secure modelines
Plug 'ciaranm/securemodelines'

" automatically change working dir to project root
Plug 'airblade/vim-rooter'

" mapping pairs
Plug 'tpope/vim-unimpaired'

" smart casing substition, abbreviation and coercion
Plug 'tpope/vim-abolish'

" heuristically set buffer options (shiftwidth, tabexpand etc.)
Plug 'tpope/vim-sleuth'

""
" alignmentxt
Plug 'junegunn/vim-easy-align'

" start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" start interactive EasyAlign for a motion / text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" interactive EasyAlign
nmap iga <Plug>(LiveEasyAlign)
xmap iga <Plug>(LiveEasyAlign)

" colorschemes
Plug 'flazz/vim-colorschemes'
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'

" display signs at interesting lines
Plug 'tomtom/quickfixsigns_vim'

" highlight several words in different colors simultaneously
Plug 'vim-scripts/Mark--Karkat'

" powerful file explorer
Plug 'Shougo/vimfiler.vim'

" path navigator
Plug 'justinmk/vim-dirvish'

" create junk files for scratch editing
Plug 'Shougo/junkfile.vim'

" easy window resizing
Plug 'jimsei/winresizer'

" zoom a window
Plug 'vim-scripts/zoomwintab.vim'

" tmux integration
Plug 'benmills/vimux'

" filesystem sidebar
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'

let NERDTreeIgnore = ['\.pyc$', '\~$']

map <Leader>t :NERDTreeToggle<CR>


Plug 'majutsushi/tagbar'

nnoremap <silent> <LocalLeader>t :TagbarToggle<CR>

" filetype icons
Plug 'ryanoasis/vim-devicons'

" start screen
"Plug 'mhinz/vim-startify'

"""
" airline
Plug 'vim-airline/vim-airline'

let g:airline_powerline_fonts = 1
let g:airline_symbols         = get(g:, 'airline_symbols', {})
let g:airline_symbols.space   = "\ua0"

"""
" fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" default extra keybindings
let g:fzf_action = {
 \ 'ctrl-t': 'tab split',
 \ 'ctrl-x': 'split',
 \ 'ctrl-v': 'vsplit' }

" default layout
let g:fzf_layout = { 'down': '~40%' }

let g:fzf_colors = {
 \ 'fg':      ['fg', 'Normal'],
 \ 'bg':      ['bg', 'Normal'],
 \ 'hl':      ['fg', 'Comment'],
 \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
 \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
 \ 'hl+':     ['fg', 'Statement'],
 \ 'info':    ['fg', 'PreProc'],
 \ 'pointer': ['fg', 'Exception'],
 \ 'marker':  ['fg', 'Keyword'],
 \ 'spinner': ['fg', 'Label'],
 \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" Ctrl-N and Ctrl-P will be automatically bound to next-history and
" previous-history instead of down and up.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" jump to the existing window if possible
let g:fzf_buffers_jump = 1

" command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" mappings
nmap <Leader><Tab> <Plug>(fzf-maps-n)
xmap <Leader><Tab> <Plug>(fzf-maps-x)
omap <Leader><Tab> <Plug>(fzf-maps-o)

" insert mode completion
imap <C-x><C-k> <Plug>(fzf-complete-word)
imap <C-x><C-f> <Plug>(fzf-complete-path)
imap <C-x><C-j> <Plug>(fzf-complete-file-ag)
imap <C-x><C-l> <Plug>(fzf-complete-line)

nmap <silent> <LocalLeader><Space> :Files<CR>
nmap <silent> <LocalLeader>a :Buffers<CR>
nmap <silent> <LocalLeader>A :Windows<CR>
nmap <silent> <LocalLeader>; :BLines<CR>
nmap <silent> <LocalLeader>o :BTags<CR>
nmap <silent> <LocalLeader>O :Tags<CR>
nmap <silent> <LocalLeader>m :History<CR>
nmap <silent> <LocalLeader>gl :Commits<CR>
nmap <silent> <LocalLeader>ga :BCommits<CR>
nmap <silent> <LocalLeader>ft :Filetypes<CR>


"-------------------------------------------------------------------------------
" General Coding {{{2
"-------------------------------------------------------------------------------

" smart tabs: tabs for indentation, spaces for alignment
"Plug 'vim-scripts/Smart-Tabs'

" auto-balancing delimiters
Plug 'Raimondi/delimitMate'

" intelligent commenting
Plug 'tomtom/tcomment_vim'
"Plug 'tpope/vim-commentary'

let g:tcomment#options = {'whitespace': 'no'}

" file alternation
Plug 'tpope/vim-projectionist'

" dispatch commands
Plug 'tpope/vim-dispatch'

" test execution
Plug 'janko-m/vim-test'

" powerful syntax checker
Plug 'scrooloose/syntastic'

" highlight custom types and classes
Plug 'vim-scripts/TagHighlight'

" end structures automatically
Plug 'tpope/vim-endwise'

" detect file indentation settings and warn on inconsistencies
"Plug 'vim-scripts/IndentConsistencyCop'
"Plug 'vim-scripts/IndentConsistencyCopAutoCmds'

" textobject 'a' for function/method arguments
Plug 'vim-scripts/argtextobj.vim'

" multiple cursors
Plug 'terryma/vim-multiple-cursors'

" better folding
"Plug 'Konfekt/FastFold'

"nmap zuz <Plug>(FastFoldUpdate)

let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes = ['x', 'X', 'a', 'A', 'o', 'O', 'c', 'C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']

let g:tex_fold_enabled = 1
let g:vimsyn_folding = 'af'
let g:xml_syntax_folding = 1
let g:php_folding = 1
let g:perl_fold = 1

" fold text object
"xnoremap iz :<C-u>FastFoldUpdate<CR><ESC>:<C-u>normal! ]zv[z<CR>
"xnoremap az :<C-u>FastFoldUpdate<CR><ESC>:<C-u>normal! ]zV[z<CR>

" keep editing state
"Plug 'kopischke/vim-stay'

"set viewoptions=cursor,folds,slash,unix

"-------------------------------------------------------------------------------
" General Editing {{{2
"-------------------------------------------------------------------------------

" ansi escape sequences
"Plug 'vim-scripts/AnsiEsc.vim'

" graphical undo
Plug 'vim-scripts/Gundo'

" repeat some plugin commands with '.'
Plug 'tpope/vim-repeat'

" table movement and alignment
Plug 'godlygeek/tabular'

" accumulate all spelling errors in the quickfix buffer
Plug 'vim-scripts/SpellCheck'

" insert lorem ipsum blocks
Plug 'vim-scripts/loremipsum'


"-------------------------------------------------------------------------------
" Unite {{{2
"-------------------------------------------------------------------------------

Plug 'Shougo/unite.vim'

" most recently used
"Plug 'Shougo/neomru.vim'

" show an outline
Plug 'Shougo/unite-outline'


" switch through colorschemes
Plug 'ujihisa/unite-colorscheme'

" locate
Plug 'ujihisa/unite-locate'

" fonts
Plug 'ujihisa/unite-font'


" unite everything
Plug 'sgur/unite-everything'


" filetypes
Plug 'osyo-manga/unite-filetype'

" folds
Plug 'osyo-manga/unite-fold'

" quickfix
Plug 'osyo-manga/unite-quickfix'


" help
Plug 'tsukkee/unite-help'

" tags
Plug 'tsukkee/unite-tag'


" marks
Plug 'tacroe/unite-mark'

" aliases
Plug 'tacroe/unite-alias'


" tasklist
Plug 'junkblocker/unite-tasklist'

" history
Plug 'thinca/vim-unite-history'

" command line completion
Plug 'majkinetor/unite-cmdmatch'


"-------------------------------------------------------------------------------
" C/C++ {{{2
"-------------------------------------------------------------------------------

" clang completer for C and C++
Plug 'Rip-Rip/clang_complete'

" clang formatter
Plug 'rhysd/vim-clang-format'

" cscope
Plug 'vim-scripts/autoload_cscope.vim'

" highlight operators in C-like languages
Plug 'vim-scripts/cSyntaxAfter'

" QML
Plug 'peterhoeg/vim-qml'


"-------------------------------------------------------------------------------
" Java {{{2
"-------------------------------------------------------------------------------

" java completion
Plug 'artur-shaik/vim-javacomplete2'


"-------------------------------------------------------------------------------
" Octave {{{2
"-------------------------------------------------------------------------------

Plug 'vim-scripts/octave.vim'
Plug 'vim-scripts/octave.vim--'


"-------------------------------------------------------------------------------
" Python {{{2
"-------------------------------------------------------------------------------

" Python-mode
"Plug 'klen/python-mode', { 'for': 'python' }

" virtualenv
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }

" show indent lines
Plug 'Yggdroot/indentLine', { 'for': 'python' }

" coverage reports
Plug 'alfredodeza/coveragepy.vim', { 'for': 'python' }

" sort imports
Plug 'fisadev/vim-isort', { 'for': 'python' }

" conceal
Plug 'ehamberg/vim-cute-python', { 'for': 'python' }

" nose test runner
Plug 'lambdalisue/nose.vim', { 'for': 'python' }

" folding
"Plug 'tmhedberg/SimpylFold'

" show docstrings for folds
let g:SimpylFold_docstring_preview = 1

" better indentation
Plug 'vim-scripts/indentpython.vim'

" auto completion
Plug 'Valloric/YouCompleteMe'

let g:ycm_autoclose_preview_window_after_completion = 1

autocmd FileType python  nnoremap <buffer> <C-]> :YcmCompleter GoToDefinitionElseDeclaration<CR>

" switch to virtualenv
py3 << EOF
import os
import sys

if "VIRTUAL_ENV" in os.environ:
  project_base_dir = os.environ["VIRTUAL_ENV"]
  activate_this = os.path.join(project_base_dir, "bin/activate_this.py")
  execfile(activate_this, dict(__file__=activate_this))
EOF

" add optional highlighting
let python_highlight_all = 1

" rope integration
Plug 'python-rope/ropevim'

let ropevim_enable_shortcuts = 1
let ropevim_extended_complete = 1

autocmd FileType python setlocal omnifunc=RopeCompleteFunc

"-------------------------------------------------------------------------------
" Perl {{{2
"-------------------------------------------------------------------------------

" perl editing in vim
Plug 'vim-perl/vim-perl'

" completion
Plug 'c9s/perlomni.vim'

" documentation
Plug 'hotchpotch/perldoc-vim'


"-------------------------------------------------------------------------------
" Ruby {{{2
"-------------------------------------------------------------------------------

" editing Ruby with vim
Plug 'vim-ruby/vim-ruby'

" refactoring
Plug 'ecomba/vim-ruby-refactoring'

" testing with cucumber
Plug 'tpope/vim-cucumber'

" browser Ruby documentation from inside Vim
Plug 'danchoi/ri.vim'

" HTML-embedded ruby
Plug 'vim-scripts/eruby.vim'

" Haml, Sass, SCSS
Plug 'tpope/vim-haml'


"-------------------------------------------------------------------------------
" Haskell {{{2
"-------------------------------------------------------------------------------

" Vim to Haskell
Plug 'dag/vim2hs'

" ghc integration
Plug 'eagletmt/ghcmod-vim'

" completion with ghc
Plug 'ujihisa/neco-ghc'


"-------------------------------------------------------------------------------
" Scala {{{2
"-------------------------------------------------------------------------------

Plug 'derekwyatt/vim-scala'


"-------------------------------------------------------------------------------
" HTML/CSS {{{2
"-------------------------------------------------------------------------------

" HTML, CSS, etc.
Plug 'mattn/emmet-vim'


"-------------------------------------------------------------------------------
" LaTeX {{{2
"-------------------------------------------------------------------------------

Plug 'lervag/vimtex'

"-------------------------------------------------------------------------------
" Markdown {{{2
"-------------------------------------------------------------------------------

" markdown
Plug 'tpope/vim-markdown'

" pandoc
Plug 'vim-scripts/pdc.vim'

" reStructuredText
Plug 'Rykka/riv.vim', { 'for': 'rst' }

"-------------------------------------------------------------------------------
" Hex Editing {{{2
"-------------------------------------------------------------------------------

Plug 'Shougo/vinarise.vim'

"-------------------------------------------------------------------------------
" Misc. Syntax {{{2
"-------------------------------------------------------------------------------

" gitolite
Plug 'tmatilai/gitolite.vim'

" gtk
Plug 'vim-scripts/gtk-vim-syntax'

" lighttpd
Plug 'vim-scripts/lighttpd-syntax'

" nagios
Plug 'vim-scripts/nagios-syntax'

" Nmap
Plug 'vim-scripts/Nmap-syntax-highlight'

" ntp
Plug 'vim-scripts/ntp.vim'

" pam
Plug 'vim-scripts/pam.vim'

" qmake
Plug 'vim-scripts/qmake--syntax.vim'

" udev
Plug 'vim-scripts/syntaxudev.vim'

" xquery
Plug 'vim-scripts/XQuery-syntax'

" xslt
Plug 'vim-scripts/XSLT-syntax'

Plug 'tmux-plugins/vim-tmux'

"-------------------------------------------------------------------------------
" Check and Load {{{2
"-------------------------------------------------------------------------------

" include local plugin configuration
let s:vimlocalplug = $HOME . '/.vim/localplug.vim'

if filereadable(s:vimlocalplug)
  exe 'source ' . s:vimlocalplug
endif

"-------------------------------------------------------------------------------
" Check and Load {{{2
"-------------------------------------------------------------------------------

call plug#end()

filetype plugin indent on


"-------------------------------------------------------------------------------
" }}}2

"===============================================================================

" include gentoo specific vimrc (with sane defaults) if available {{{1
let $ETC_VIM = '/etc/vim'
if filereadable(expand("$ETC_VIM/vimrc.gentoo"))
  source $ETC_VIM/vimrc.gentoo
endif


" Basic Settings {{{1
"===============================================================================

" we use vim, not some ancient vi
set nocompatible

" custom runtime path for system wide plugins in /etc/vim/plugins
"set runtimepath=$HOME/.vim,$ETC_VIM,$ETC_VIM/plugins,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$ETC_VIM/after,~/.vim/after

" Use lighter colors on dark backgrounds
set background=dark

" Syntax highlighting
if has("syntax")
  syntax on
endif

" Unicode encoding
set fileencoding=utf-8


" viminfo
" '30    store viminfo for the last 30 files previously edited
" \"50   maximum number of lines saved for each register
" %      restore buffer list if vim is not started with a filename argument
" n...   name of the viminfo file
set viminfo='30,\"50,%,n~/.viminfo

" General {{{1
"===============================================================================
" write changes on buffer switch or :make
set autowrite

" read a file unasked when unchanged in vim but changed outside
set autoread

" show matching parenthesises
set showmatch

" do not flicker around
set novisualbell

" context for scrolling
set scrolloff=3

" backspace over autoindent, line breaks and start of insert mode
set backspace=indent,eol,start

" use backups
set nobackup
set writebackup
set backupdir=~/.vim/.backup//,.

" temporary files
set directory=~/.vim/.tmp//,.

" Only insert the longest common text of the matches.  If
" the menu is displayed you can use CTRL-L to add more
" characters.  Whether case is ignored depends on the kind
" of completion.  For buffer text the 'ignorecase' option is
" used.
set completeopt+=longest

" Use the popup menu also when there is only one match.
" Useful when there is additional information about the
" match, e.g., what file it comes from.
set completeopt+=menuone

" switch to tab with open file or open new tab (quickfix)
set switchbuf=usetab,newtab

" allow putting unwritten buffers into background
set hidden

" avoid hit-enter prompts
set shortmess+=aAI

" console dialogs instead of popups
set guioptions+=c

" report all line changes
set report=0

" extend command history
set history=1000

" show tab number, filename and modified flag in tab label
set guitablabel=%N:\ %t\ %M

" allow pasting as-is using X copy buffer
set mouse=a

"===============================================================================
" sensible default options (inspired by https://github.com/tpope/vim-sensible)
set nrformats-=octal

set ttimeout
set ttimeoutlen=100

" use <Leader>; to clear search highlights
nnoremap <silent> <Leader>; :nohlsearch<CR>

set sidescrolloff=5

set display+=lastline

" delete comment characters when joining commented lines
if v:version > 703
  set formatoptions+=j
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

set tabpagemax=50

if !empty(&viminfo)
  set viminfo^=!
endif

set sessionoptions-=options

inoremap <C-U> <C-G>u<C-U>

"===============================================================================

" mode is already shown by powerline/airline
set noshowmode

" show command in last line
set showcmd

" only remember current directory and open buffers in session files
set sessionoptions=buffers,curdir

" vimgrep {{{2
"-------------------------------------------------------------------------------

let b:grepformat = &grepformat
set grepformat=%f:%l:%c:%m
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  let g:ackprg = 'rg --vimgrep --no-heading'
elseif executable('ag')
  set grepprg=ag\ --vimgrep
  let g:ackprg = 'ag --vimgrep'
elseif executable('ack')
  set grepprg=ack\ --column
else
  " always show line number and names of matching files when grepping
  set grepprg=grep\ -nH\ $*
  let &grepformat=b:grepformat
endif

" grep word under cursor
nnoremap <Leader>vv :grep! "\b<cword>\b"<CR>:cwindow<CR>

command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap <Leader>a :Ag<Space>


" spell checking {{{2
"-------------------------------------------------------------------------------

" check for spelling errors
set nospell

" use US english as default
set spelllang=en_us

" correct the last spelling mistake using the first suggestion
"   [s   - move to last mistake
"   1z=  - choose first suggestion
"   gi    - enter insert mode at last point before leaving insert
imap <C-l> <Esc>[s1z=gi

"-------------------------------------------------------------------------------


" statusline {{{2
"-------------------------------------------------------------------------------

" always show status line
set laststatus=2

" source $HOME/.vim/vimrc.d/statusline

"-------------------------------------------------------------------------------
"===============================================================================

" Text Formatting {{{1
"===============================================================================

" Terminal text width
set textwidth=80

" Indentation
if has("autocmd")
  filetype indent on
endif

" Tab width
set tabstop=2

" Indentation shift width
set shiftwidth=2

" round indent to multiple of sw using < and >
set shiftround

" use spaces for indentation and alignment
set expandtab

" use smart indentation (i.e. respect indentation with blank lines in between)
set smartindent

" preserve indentation style from previous lines
set copyindent

" visualize tabs and trailing whitespaces
" use :set list! to toggle
set listchars=tab:»-,trail:·
set list
set showbreak=↪

" Format options (with Vim help text) {{{2
"-------------------------------------------------------------------------------

" Auto-wrap text using textwidth
set formatoptions+=t

" Auto-wrap comments using textwidth, inserting the current comment
" leader automatically.
set formatoptions+=c

" Automatically insert the current comment leader after hitting
" <Enter> in Insert mode.
set formatoptions+=r

" Automatically insert the current comment leader after hitting 'o' or
" 'O' in Normal mode.
set formatoptions+=o

" Allow formatting of comments with "gq".
" Note that formatting will not change blank lines or lines containing
" only the comment leader.  A new paragraph starts after such a line,
" or when the comment leader changes.
set formatoptions+=q

" When formatting text, recognize numbered lists.  This actually uses
" the 'formatlistpat' option, thus any kind of list can be used.  The
" indent of the text after the number is used for the next line.  The
" default is to find a number, optionally followed by '.', ':', ')',
" ']' or '}'.  Note that 'autoindent' must be set too.  Doesn't work
" well together with "2".
" Example: >
"   1. the first item
"      wraps
"   2. the second item
set formatoptions+=n

" Long lines are not broken in insert mode: When a line was longer than
" 'textwidth' when the insert command started, Vim does not
" automatically format it.
set formatoptions+=l
"-------------------------------------------------------------------------------
"===============================================================================


" Use markers to specify folds
"set foldmethod=marker

" Fold based on indentation
"set foldmethod=indent

" Don't close folds by default
"set foldlevel=99

" Fold with space bar
nnoremap <Space> za

" Searching {{{1
"===============================================================================

" Find as you type
set incsearch

" Ignore case on searches
set ignorecase

" Only ignore case when we type lower case
set smartcase

" Wrap search around EOF
set wrapscan

" highlight the search pattern
set hlsearch

"===============================================================================



" Menues {{{1
"===============================================================================

" nice completion menu
set wildmenu

" complete longest first while showing all completions, then enter completion
" menu
set wildmode=list:longest,full

" ignore for wild completion
set wildignore=*.swp,*.jpg,*.png,*.xpm,*.gif

" tex
set wildignore+=*.pdf,*.dvi,*.ps,*.aux,*.out,*.vrb,*.nav,*.toc,*.snm

" C/C++ generated files
set wildignore+=*.d,_cov/,*.gperf,*.gcda,*.gcno

augroup vimrc_tex
  autocmd!

  " ignore pdflatex log files
  autocmd FileType tex,latex,context setlocal wildignore+=*.log
augroup END

"===============================================================================

" highlight formatting errors {{{1

" highlight space errors with red background
highlight SpaceError term=standout cterm=bold ctermbg=red ctermfg=white gui=bold guibg=red guifg=white

augroup vimrc_error_highlight
  autocmd!

  " highlight trailing whitespaces and whitespaces before tabs
  " \ze sets end of match for highlighting
  autocmd BufWinEnter * if &modifiable && &ft!='unite' | match SpaceError /\s\+$\| \+\ze\t/ | endif
augroup END


" Tip 1008: Toggle to open or close the quickfix window {{{1
" http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
"===============================================================================

" toggles the quickfix window.
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
  else
    execute "copen " . g:jah_Quickfix_Win_Height
  endif
endfunction

function! QFixLeave()
  if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win
    unlet! g:qfix_win
  endif
endfunction

" used to track the quickfix window
augroup QFixToggle
  autocmd!
  autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
  autocmd BufWinLeave * call QFixLeave()
  autocmd TabLeave * call QFixLeave()
augroup END
"===============================================================================

" Functions {{{1
"===============================================================================
function! BuildProject()
  silent make
  echohl StatusLine | echo "Build Complete" | echohl None
  cwindow
endfunction

let g:CtagsExcludes = [ '.git', '.hg', '.svn' ]

function! UpdateTags()
  let ctags_args = ''

  let ctags_args .= ' --recurse'

  if exists('g:CtagsExcludes')
    for exclude in g:CtagsExcludes
      let ctags_args .= ' --exclude=' . exclude
    endfor
  endif

  let ctags_args .= ' --c-kinds=+p'
  let ctags_args .= ' --c++-kinds=+p'

  let ctags_args .= ' --fields=+iaS'
  let ctags_args .= ' --extra=+q'

  execute ":!ctags " . ctags_args

  echohl StatusLine | echo "Tags File Updated" | echohl None
endfunction
command! -nargs=0 UpdateTags call UpdateTags()

"===============================================================================

" Keyboard Shortcuts {{{1
"===============================================================================

" General {{{2
"-------------------------------------------------------------------------------

" tabs
nnoremap te :tabe<Space>
nnoremap td :tab drop
nnoremap ts :tab split<CR>

" split directions
set splitbelow
set splitright

" relative tab nav
nnoremap <silent> <C-h> :tabprevious<CR>
nnoremap <silent> <C-l> :tabnext<CR>

" relative tab move
nnoremap <silent> <A-Left>  :execute 'silent! tabmove ' . (tabpagenr() - 2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr())<CR>

" custom tab close
function! CloseTab()
  if winnr("$") == 1  && tabpagenr() > 1 && tabpagenr() < tabpagenr("$")
    tabclose | tabprev
  else
    quit
  endif
endfunction
nmap <silent> Q :call CloseTab()<CR>


" quick splits
nnoremap _     :split<CR>
nnoremap <bar> :vsplit<CR>

" quick close
nnoremap <Leader>k <C-W>c
nnoremap <Leader>K :bdelete<CR>

" zoom
map <Leader>z :ZoomWinTabToggle<CR>

" navigate through quickfix buffer with main window following errors
nnoremap <silent> <C-j> :cnext<CR>
nnoremap <silent> <C-k> :cprevious<CR>


" toggle line numbers
nnoremap <F7> :set number!<CR>

" toggle list mode
nnoremap <silent> <Leader>eh :set list!<CR>

" copy/paste with clipboard
nnoremap <Leader>y "*y
nnoremap <Leader>p "*p

" pastetoogle key, enter paste mode for disabling autoindentation when
" pasting something into vim
nnoremap <silent> <Leader>P :set invpaste<CR>

" toggle search highlighting
"nnoremap <silent> <Leader>v :set invhlsearch<CR>

" remove trailing whitespaces
nnoremap <silent> <Leader>et :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" build buffer and show errors
"nnoremap <LocalLeader>m :call BuildProject()<CR>

" update tags and types file
" nnoremap <Leader>u :UpdateTypesFile!<CR>

" toggle quickfix window using Vim Tip 1008
let g:jah_Quickfix_Win_Height = 10
nnoremap <silent> <Leader>q :QFix<CR>


" toggle taglist window
"nnoremap <silent> <LocalLeader>t :TlistToggle<CR>

" ctrlp mappings
"nnoremap <silent> <Leader>f :CtrlP<CR>
"nnoremap <silent> <Leader>b :CtrlPBuffer<CR>
"nnoremap <silent> <Leader>T :CtrlPBufTag<CR>
"nnoremap <silent> <Leader>t :CtrlPTag<CR>
"nnoremap <silent> <Leader>F :CtrlPCurWD<CR>
"nnoremap <silent> <Leader>M :CtrlPMRUFiles<CR>
"nnoremap <silent> <Leader>m :CtrlPMixed<CR>
"nnoremap <silent> <Leader>l :CtrlPLine<CR>

" quick save
nnoremap <silent> <Leader>w :update<CR>

" undo tree
nnoremap <silent> <Leader>u :GundoToggle<CR>

" spell checking
nnoremap <silent> <Leader>se :setlocal spell spelllang=en<CR>
nnoremap <silent> <Leader>sg :setlocal spell spelllang=de<CR>
nnoremap <silent> <Leader>so :setlocal nospell<CR>
nnoremap <silent> <Leader>sc ]sz=
nnoremap <silent> <Leader>sn ]s
nnoremap <silent> <Leader>sp z=
nnoremap <silent> <Leader>sa zg

" python mode
nnoremap <silent> <LocalLeader>n :PymodeLint<CR>

let g:pymode_breakpoint_bind = '<Leader>B'

let g:pymode_lint = 1
let g:pymode_lint_on_write = 0
let g:pymode_lint_checkers = ['pylint', 'pep8', 'mccabe', 'pep257']
let g:pymode_lint_ignore = ''
let g:pymode_virtualenv = 0
let g:pymode_rope = 1

let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 1


" syntastic
nnoremap <silent> <LocalLeader>N :SyntasticCheck<CR>:Errors<CR>

let g:syntastic_mode_map = { 'mode': 'active',
            \ 'active_filetypes': [],
            \ 'passive_filetypes': ['python'] }

let g:syntastic_error_symbol         = '✗'
let g:syntastic_warning_symbol       = '⚠'
let g:syntastic_style_error_symbol   = '⚡'
let g:syntastic_style_warning_symbol = '⚡'


"-------------------------------------------------------------------------------

" Command-line mode {{{2
"-------------------------------------------------------------------------------

" Bash like keys for the command line.
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Ctrl-[hl]: Move left/right by word
cnoremap <c-h> <s-left>
cnoremap <c-l> <s-right>

" Ctrl-Space: Show history
cnoremap <c-@> <c-f>

cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoremap <c-f> <left>
cnoremap <c-g> <right>

"-------------------------------------------------------------------------------

" Fugitive {{{2
"-------------------------------------------------------------------------------

nnoremap <Leader>gt  :!tig<CR>:redraw!<CR>
nnoremap <Leader>gs  :Gstatus<CR>
nnoremap <Leader>gd  :Gdiff<CR>
nnoremap <Leader>gc  :Gcommit<CR>
nnoremap <Leader>gl  :exe "silent Glog <Bar> Unite -no-quit quickfix"<CR>:redraw!<CR>
nnoremap <Leader>gL  :exe "silent Glog -all <Bar> Unite -no-quit quickfix"<CR>:redraw!<CR>
nnoremap <Leader>gb  :Gblame<CR>
nnoremap <Leader>gw  :Gwrite<CR>
nnoremap <Leader>go  :Gread<CR>
nnoremap <Leader>gR  :Gremove<CR>
nnoremap <Leader>gm  :Gmove<CR>
nnoremap <Leader>gp  :Git! push<CR>
nnoremap <Leader>gP  :Git! pull<CR>
nnoremap <Leader>gi  :Git!<Space>
nnoremap <Leader>ge  :Gedit<CR>
nnoremap <Leader>gE  :Gedit<Space>
nnoremap <Leader>gg  :exe 'silent Ggrep -i '.input("Pattern: ").'<Bar>Unite -no-quit quickfix'<CR>
nnoremap <Leader>ggm :exe 'silent Glog --grep='.input("Pattern: ").'<Bar>Unite -no-quit quickfix'<CR>
nnoremap <Leader>ggt :exe 'silent Glog -S='.input("Pattern: ").'<Bar>Unite -no-quit quickfix'<CR>
nnoremap <Leader>gn  :Unite output:echo\ system("git\ init")<CR>
nnoremap <Leader>gB  :Gbrowse<CR>


" gitv
nnoremap <silent> <Leader>gv :Gitv --all<CR>
nnoremap <silent> <Leader>gV :Gitv! --all<CR>
vnoremap <silent> <Leader>gV :Gitv! --all<CR>

let g:Gitv_OpenHorizontal = 'auto'
let g:Gitv_WipeAllOnClose = 1


" diff mode
nnoremap <Leader>du :diffupdate<CR>

if !exists(":Gdiffoff")
  command Gdiffoff diffoff | q | Gedit
endif
nnoremap <Leader>dq :Gdiffoff<CR>

" }}}2
" Unite {{{2
"-------------------------------------------------------------------------------

" Inside Menu {{{3
"-------------------------------------------------------------------------------

" mappings inside unite menu
function! s:unite_settings()
  " use 'Q' or Escape for leaving
  nmap <buffer> Q     <Plug>(unite_exit)
  nmap <buffer> <Esc> <Plug>(unite_exit)
  imap <buffer> <Esc> <Plug>(unite_exit)

  " navigation
  imap <buffer> <C-j> <Plug>(unite_insert_leave)
  nmap <buffer> <C-j> <Plug>(unite_loop_cursor_down)
  nmap <buffer> <C-k> <Plug>(unite_loop_cursor_up)

  " line editing
  imap <buffer> <C-w> <Plug>(unite_delete_backward_word)
  imap <buffer> <C-u> <Plug>(unite_delete_backward_path)

  " redraw menu
  imap <buffer> <C-r> <Plug>(unite_redraw)
  nmap <buffer> <C-r> <Plug>(unite_redraw)

  " choose action
  imap <buffer> <C-a> <Plug>(unite_choose_action)
endfunction

augroup vimrc_unite
  autocmd!
  autocmd FileType unite call s:unite_settings()
augroup END

"-------------------------------------------------------------------------------
" Prefix {{{3
"-------------------------------------------------------------------------------

" use space as unite prefix
"nnoremap [unite] <Nop>
"nmap     <Space> [unite]

" use backslash as unite menu prefix
"nnoremap [menu] <Nop>
"nmap     \ [menu]

"
" "-------------------------------------------------------------------------------
" " Mappings {{{3
" "-------------------------------------------------------------------------------
"
" "-------------------------------------------------------------------------------
" " Direct {{{4
" "-------------------------------------------------------------------------------
"
" " general fuzzy file search
" nnoremap <silent> [unite]<Space> :<C-u>Unite -buffer-name=files buffer file_mru bookmark file_rec/async<CR>
"
" " buffer and mru
" nnoremap <silent> [unite]u       :<C-u>Unite -buffer-name=buffers buffer file_mru<CR>
"
" " mru
" nnoremap <silent> [unite]m       :<C-u>Unite -buffer-name=mru file_mru<CR>
"
" " files
" nnoremap <silent> [unite]o       :<C-u>Unite -buffer-name=files file<CR>
"
" " recursive files
" nnoremap <silent> [unite]O       :<C-u>Unite -buffer-name=files file_rec/async file/new<CR>
"
" "-------------------------------------------------------------------------------
"
" " grep for word under cursor
" nnoremap <silent> [unite]g       :<C-u>UniteWithCursorWord -buffer-name=grep grep<CR>
"
" " grep
" nnoremap <silent> [unite]G       :<C-u>Unite -buffer-name=grep grep<CR>
"
" " find
" nnoremap <silent> [unite]n       :<C-u>Unite -buffer-name=find find<CR>
"
" "-------------------------------------------------------------------------------
"
" " buffers
" nnoremap <silent> [unite]b       :<C-u>Unite -buffer-name=buffers buffer<CR>
"
" " tabs
" nnoremap <silent> [unite]B       :<C-u>Unite -buffer-name=tabs tab<CR>
"
" "-------------------------------------------------------------------------------
"
" " search line
" nnoremap <silent> [unite]f       :<C-u>Unite -buffer-name=search -auto-preview line<CR>
"
" " search word under cursor
" nnoremap <silent> [unite]8       :<C-u>UniteWithCursorWord -buffer-name=search -no-split -auto-preview line<CR>
"
" " outline (and ctags)
" nnoremap <silent> [unite]t       :<C-u>Unite -buffer-name=outline -vertical -winwidth=40 -direction=topLeft -toggle outline<CR>
"
" " search todos
" nnoremap <silent> [unite];       :<C-u>Unite -buffer-name=todo -toggle grep:%::FIXME\|TODO\|XXX\|@todo\|\\todo<CR>
"
" "-------------------------------------------------------------------------------
"
" " yank history
" nnoremap <silent> [unite]i       :<C-u>Unite -buffer-name=yanks history/yank<CR>
"
" " registers
" nnoremap <silent> [unite]r       :<C-u>Unite -buffer-name=registers register<CR>
"
" "-------------------------------------------------------------------------------
"
" " bookmarks
" nnoremap <silent> [unite]m       :<C-u>Unite -buffer-name=bookmarks bookmark<CR>
"
" " help
" nnoremap <silent> [unite]h       :<C-u>Unite -buffer-name=help help<CR>
"
" " sessions
" nnoremap <silent> [unite]p       :<C-u>Unite -buffer-name=sessions session<CR>
"
" " sources
" nnoremap <silent> [unite]a       :<C-u>Unite -buffer-name=sources source<CR>
"
" " snippets
" nnoremap <silent> [unite]s       :<C-u>Unite -buffer-name=snippets snippet<CR>
"
" " :lcd
" nnoremap <silent> [unite]d       :<C-u>Unite -buffer-name=change-cwd -default-action=lcd directory_mru<CR>
"
" " line with word under cursor
" nnoremap <silent> [unite]l       :<C-u>UniteWithCursorWord -buffer-name=search_file line<CR>
"
"
" "-------------------------------------------------------------------------------
" " Menues {{{4
" "-------------------------------------------------------------------------------
"
" nnoremap <silent> [menu]u        :<C-u>Unite -buffer-name=unite -silent -winheight=20 menu<CR>
"
"
" let g:unite_source_menu_menus = {}
"
" "-------------------------------------------------------------------------------
" " Files and Dirs {{{5
" "-------------------------------------------------------------------------------
"
" nnoremap <silent>[menu]o :Unite -silent -winheight=17 menu:files<CR>
"
" let g:unite_source_menu_menus.files = {
"     \ 'description' : '          files & dirs
"         \                                          ⌘ \o',
"     \}
"
" let g:unite_source_menu_menus.files.command_candidates = [
"     \['▷ general fuzzy file search                                  ⌘ [space][space]',
"         \'Unite -buffer-name=files buffer file_mru bookmark file_rec/async'],
"     \['▷ open buffers and recently used files                       ⌘ [space]u',
"         \'Unite -buffer-name=buffers buffer file_mru'],
"     \['▷ open recently used files                                   ⌘ [space]m',
"         \'Unite file_mru'],
"     \['▷ open file                                                  ⌘ [space]o',
"         \'Unite -buffer-name=files file_rec/async file/new'],
"     \['▷ open file with recursive search                            ⌘ [space]O',
"         \'Unite -buffer-name=files file_rec/async file/new'],
"     \['▷ edit new file',
"         \'Unite -buffer-name=files file/new'],
"     \['▷ search directory',
"         \'Unite -buffer-name=dirs directory'],
"     \['▷ search recently used directories',
"         \'Unite -buffer-name=dirs directory_mru'],
"     \['▷ search directory with recursive search',
"         \'Unite -buffer-name=dirs directory_rec/async'],
"     \['▷ make new directory',
"         \'Unite -buffer-name=dirs directory/new'],
"     \['▷ change working directory',
"         \'Unite -buffer-name=dirs -default-action=lcd directory'],
"     \['▷ know current working directory',
"         \'Unite output:pwd'],
"     \['▷ save as root                                               ⌘ :w!!',
"         \'exe "write !sudo tee % >/dev/null"'],
"     \['▷ quick save                                                 ⌘ ,w',
"         \'normal ,w'],
"     \]
"
" "-------------------------------------------------------------------------------
" " File Search {{{5
" "-------------------------------------------------------------------------------
"
" nnoremap <silent>[menu]g :Unite -silent menu:grep<CR>
"
" let g:unite_source_menu_menus.grep = {
"     \ 'description' : '           search files
"         \                                          ⌘ \g',
"     \}
" let g:unite_source_menu_menus.grep.command_candidates = [
"     \['▷ grep word under cursor (ag → ack → grep)                   ⌘ [space]g',
"         \'UniteWithCursorWord -buffer-name=grep grep'],
"     \['▷ grep (ag → ack → grep)                                     ⌘ [space]G',
"         \'Unite -buffer-name=grep grep'],
"     \['▷ find                                                       ⌘ [space]n',
"         \'Unite -buffer-name=find find'],
"     \['▷ locate',
"         \'Unite -buffer-name=locate locate'],
"     \['▷ vimgrep (very slow)',
"         \'Unite -buffer-name=vimgrep vimgrep'],
"     \]
"
" "-------------------------------------------------------------------------------
" " Buffers, Tabs, and Windows {{{5
" "-------------------------------------------------------------------------------
"
" nnoremap <silent>[menu]b :Unite -silent menu:navigation<CR>
"
" let g:unite_source_menu_menus.navigation = {
"     \ 'description' : '     navigate by buffers, tabs & windows
"         \                   ⌘ \b',
"     \}
" let g:unite_source_menu_menus.navigation.command_candidates = [
"     \['▷ buffers                                                    ⌘ [space]b',
"         \'Unite -buffer-name=buffers buffer'],
"     \['▷ tabs                                                       ⌘ [space]B',
"         \'Unite -buffer-name=tabs tab'],
"     \['▷ windows',
"         \'Unite -buffer-name=windows window'],
"     \['▷ location list',
"         \'Unite -buffer-name=locations location_list'],
"     \['▷ quickfix',
"         \'Unite -buffer-name=quickfix quickfix'],
"     \['▷ resize windows                                             ⌘ C-C C-W',
"         \'WinResizerStartResize'],
"     \['▷ new vertical window                                        ⌘ |',
"         \'vsplit'],
"     \['▷ new horizontal window                                      ⌘ _',
"         \'split'],
"     \['▷ close current window                                       ⌘ ,k',
"         \'close'],
"     \['▷ toggle quickfix window                                     ⌘ ,q',
"         \'normal ,q'],
"     \['▷ zoom                                                       ⌘ ,z',
"         \'ZoomWinTabToggle'],
"     \['▷ delete buffer                                              ⌘ ,K',
"         \'bdelete'],
"     \]
"
" "-------------------------------------------------------------------------------
" " Search in Buffer {{{5
" "-------------------------------------------------------------------------------
"
" nnoremap <silent>[menu]f :Unite -silent menu:searching<CR>
"
" let g:unite_source_menu_menus.searching = {
"     \ 'description' : '      search inside the current buffer
"         \                      ⌘ \f',
"     \}
" let g:unite_source_menu_menus.searching.command_candidates = [
"     \['▷ search line                                                ⌘ [space]f',
"         \'Unite -buffer-name=search -auto-preview line'],
"     \['▷ search word under the cursor                               ⌘ [space]8',
"         \'UniteWithCursorWord -buffer-name=search -no-split -auto-preview line'],
"     \['▷ search outlines & tags (ctags)                             ⌘ ,t',
"         \'Unite -buffer-name=outline -vertical -winwidth=40 -direction=topleft -toggle outline'],
"     \['▷ search marks',
"         \'Unite -buffer-name=marks -auto-preview mark'],
"     \['▷ search folds',
"         \'Unite -buffer-name=folds -vertical -winwidth=30 -auto-highlight fold'],
"     \['▷ search changes',
"         \'Unite -buffer-name=changes change'],
"     \['▷ search jumps',
"         \'Unite -buffer-name=jumps jump'],
"     \['▷ search undos',
"         \'Unite -buffer-name=undo undo'],
"     \['▷ search todos                                               ⌘ ,;',
"         \'Unite -buffer-name=todo -toggle grep:%::FIXME|TODO|XXX|@todo|\\todo'],
"     \]
"
" "-------------------------------------------------------------------------------
" " Yanks, Registers, and History {{{5
" "-------------------------------------------------------------------------------
"
" nnoremap <silent>[menu]i :Unite -silent menu:registers<CR>
"
" let g:unite_source_menu_menus.registers = {
"     \ 'description' : '      yanks, registers & history
"         \                            ⌘ \i',
"     \}
" let g:unite_source_menu_menus.registers.command_candidates = [
"     \['▷ yanks                                                      ⌘ [space]i',
"         \'Unite -buffer-name=yanks history/yank'],
"     \['▷ commands       (history)                                   ⌘ q:',
"         \'Unite -buffer-name=commands history/command'],
"     \['▷ searches       (history)                                   ⌘ q/',
"         \'Unite -buffer-name=history history/search'],
"     \['▷ registers                                                  ⌘ [space]r',
"         \'Unite -buffer-name=registers register'],
"     \['▷ messages',
"         \'Unite output:messages'],
"     \['▷ undo tree      (gundo)                                     ⌘ ,u',
"         \'GundoToggle'],
"     \]
"
" "-------------------------------------------------------------------------------
" " Spell Checking {{{5
" "-------------------------------------------------------------------------------
"
" nnoremap <silent>[menu]s :Unite -silent menu:spelling<CR>
"
" let g:unite_source_menu_menus.spelling = {
"     \ 'description' : '       spell checking
"         \                                        ⌘ \s',
"     \}
" let g:unite_source_menu_menus.spelling.command_candidates = [
"     \['▷ spell checking in English                                  ⌘ ,se',
"         \'setlocal spell spelllang=en'],
"     \['▷ spell checking in German                                   ⌘ ,sg',
"         \'setlocal spell spelllang=de'],
"     \['▷ turn off spell checking                                    ⌘ ,so',
"         \'setlocal nospell'],
"     \['▷ jumps to next bad spell word and show suggestions          ⌘ ,sc',
"         \'normal ,sc'],
"     \['▷ jumps to next bad spell word                               ⌘ ,sn',
"         \'normal ,sn'],
"     \['▷ suggestions                                                ⌘ ,sp',
"         \'normal ,sp'],
"     \['▷ add word to dictionary                                     ⌘ ,sa',
"         \'normal ,sa'],
"     \]
"
" "-------------------------------------------------------------------------------
" " Text Editing {{{5
" "-------------------------------------------------------------------------------
"
" nnoremap <silent>[menu]e :Unite -silent -winheight=20 menu:text <CR>
"
" let g:unite_source_menu_menus.text = {
"     \ 'description' : '           text editing
"         \                                          ⌘ \e',
"     \}
" let g:unite_source_menu_menus.text.command_candidates = [
"     \['▷ toggle search results highlight                            ⌘ ,v',
"         \'set invhlsearch'],
"     \['▷ toggle line numbers                                        ⌘ ,l',
"         \'call RelativeNumberToggle()'],
"     \['▷ toggle auto-completion state (manual → disabled → auto)    ⌘ ,ea',
"         \'call ToggleNeoCompleteAutoSelect()'],
"     \['▷ show hidden chars                                          ⌘ ,eh',
"         \'set list!'],
"     \['▷ toggle fold                                                ⌘ za',
"         \'normal za'],
"     \['▷ open all folds                                             ⌘ zR',
"         \'normal zR'],
"     \['▷ close all folds                                            ⌘ zM',
"         \'normal zM'],
"     \['▷ copy to the clipboard                                      ⌘ ,y',
"         \'normal ,y'],
"     \['▷ paste from the clipboard                                   ⌘ ,p',
"         \'normal ,p'],
"     \['▷ toggle paste mode                                          ⌘ ,P',
"         \'normal ,P'],
"     \['▷ remove trailing whitespaces                                ⌘ ,et',
"         \'normal ,et'],
"     \['▷ show available digraphs',
"         \'digraphs'],
"     \['▷ insert lorem ipsum text',
"         \'exe "Loremipsum"'],
"     \['▷ show current char info                                     ⌘ ga',
"         \'normal ga'],
"     \]
"
"
" "-------------------------------------------------------------------------------
" " Git {{{5
" "-------------------------------------------------------------------------------
"
" nnoremap <silent>[menu]g :Unite -silent -winheight=29 -start-insert menu:git<CR>
"
" let g:unite_source_menu_menus.git = {
"     \ 'description' : '            admin git repositories
"         \                                ⌘ [space]g',
"     \}
" let g:unite_source_menu_menus.git.command_candidates = [
"     \['▷ tig                                                        ⌘ ,gt',
"         \'normal ,gt'],
"     \['▷ git viewer             (gitv)                              ⌘ ,gv',
"         \'normal ,gv'],
"     \['▷ git viewer - buffer    (gitv)                              ⌘ ,gV',
"         \'normal ,gV'],
"     \['▷ git status             (fugitive)                          ⌘ ,gs',
"         \'Gstatus'],
"     \['▷ git diff               (fugitive)                          ⌘ ,gd',
"         \'Gdiff'],
"     \['▷ git commit             (fugitive)                          ⌘ ,gc',
"         \'Gcommit'],
"     \['▷ git log                (fugitive)                          ⌘ ,gl',
"         \'exe "silent Glog | Unite -no-quit quickfix"'],
"     \['▷ git log - all          (fugitive)                          ⌘ ,gL',
"         \'exe "silent Glog -all | Unite -no-quit quickfix"'],
"     \['▷ git blame              (fugitive)                          ⌘ ,gb',
"         \'Gblame'],
"     \['▷ git add/stage          (fugitive)                          ⌘ ,gw',
"         \'Gwrite'],
"     \['▷ git checkout           (fugitive)                          ⌘ ,go',
"         \'Gread'],
"     \['▷ git rm                 (fugitive)                          ⌘ ,gR',
"         \'Gremove'],
"     \['▷ git mv                 (fugitive)                          ⌘ ,gm',
"         \'exe "Gmove " input("destination: ")'],
"     \['▷ git push               (fugitive, buffer output)           ⌘ ,gp',
"         \'Git! push'],
"     \['▷ git pull               (fugitive, buffer output)           ⌘ ,gP',
"         \'Git! pull'],
"     \['▷ git command            (fugitive, buffer output)           ⌘ ,gi',
"         \'exe "Git! " input("command: ")'],
"     \['▷ git edit               (fugitive)                          ⌘ ,gE',
"         \'exe "command Gedit " input(":Gedit ")'],
"     \['▷ git grep               (fugitive)                          ⌘ ,gg',
"         \'exe "silent Ggrep -i ".input("Pattern: ") | Unite -no-quit quickfix'],
"     \['▷ git grep - messages    (fugitive)                          ⌘ ,ggm',
"         \'exe "silent Glog --grep=".input("Pattern: ")." | Unite -no-quit quickfix"'],
"     \['▷ git grep - text        (fugitive)                          ⌘ ,ggt',
"         \'exe "silent Glog -S".input("Pattern: ")." | Unite -no-quit quickfix"'],
"     \['▷ git init                                                   ⌘ ,gn',
"         \'Unite output:echo\ system("git\ init")'],
"     \['▷ git cd                 (fugitive)',
"         \'Gcd'],
"     \['▷ git lcd                (fugitive)',
"         \'Glcd'],
"     \['▷ git browse             (fugitive)                          ⌘ ,gB',
"         \'Gbrowse'],
"     \]
"
" "-------------------------------------------------------------------------------
" " Code {{{5
" "-------------------------------------------------------------------------------
"
" nnoremap <silent>[menu]p :Unite -silent -winheight=42 menu:code<CR>
"
" let g:unite_source_menu_menus.code = {
"     \ 'description' : '           code tools
"         \                                            ⌘ \p',
"     \}
" let g:unite_source_menu_menus.code.command_candidates = [
"     \['▷ run python code                            (pymode)        ⌘ \r',
"         \'PymodeRun'],
"     \['▷ show docs for the current word             (pymode)        ⌘ K',
"         \'normal K'],
"     \['▷ insert a breakpoint                        (pymode)        ⌘ ,B',
"         \'normal ,B'],
"     \['▷ pylint check                               (pymode)        ⌘ ,n',
"         \'PymodeLint'],
"     \['▷ sort imports                               (isort)',
"         \'Isort'],
"     \['▷ go to definition                           (pymode-rope)   ⌘ C-C g',
"         \'call pymode#rope#goto_definition()'],
"     \['▷ find where a function is used              (pymode-rope)   ⌘ C-C f',
"         \'call pymode#rope#find_it()'],
"     \['▷ show docs for current word                 (pymode-rope)   ⌘ C-C d',
"         \'call pymode#rope#show_doc()'],
"     \['▷ reorganize imports                         (pymode-rope)   ⌘ C-C r o',
"         \'call pymode#rope#organize_imports()'],
"     \['▷ refactorize - rename                       (pymode-rope)   ⌘ C-C r r',
"         \'call pymode#rope#rename()'],
"     \['▷ refactorize - inline                       (pymode-rope)   ⌘ C-C r i',
"         \'call pymode#rope#inline()'],
"     \['▷ refactorize - move                         (pymode-rope)   ⌘ C-C r v',
"         \'call pymode#rope#move()'],
"     \['▷ refactorize - use function                 (pymode-rope)   ⌘ C-C r u',
"         \'call pymode#rope#use_function()'],
"     \['▷ refactorize - change signature             (pymode-rope)   ⌘ C-C r s',
"         \'call pymode#rope#signature()'],
"     \['▷ refactorize - rename current module        (pymode-rope)   ⌘ C-C r 1 r',
"         \'PymodeRopeRenameModule'],
"     \['▷ refactorize - module to package            (pymode-rope)   ⌘ C-C r 1 p',
"         \'PymodeRopeModuleToPackage'],
"     \['▷ syntastic toggle                           (syntastic)',
"         \'SyntasticToggleMode'],
"     \['▷ syntastic check & errors                   (syntastic)     ⌘ ,N',
"         \'normal ,N'],
"     \['▷ list virtualenvs                           (virtualenv)',
"         \'Unite output:VirtualEnvList'],
"     \['▷ activate virtualenv                        (virtualenv)',
"         \'VirtualEnvActivate'],
"     \['▷ deactivate virtualenv                      (virtualenv)',
"         \'VirtualEnvDeactivate'],
"     \['▷ run coverage2                              (coveragepy)',
"         \'call system("coverage2 run ".bufname("%")) | Coveragepy report'],
"     \['▷ run coverage3                              (coveragepy)',
"         \'call system("coverage3 run ".bufname("%")) | Coveragepy report'],
"     \['▷ toggle coverage report                     (coveragepy)',
"         \'Coveragepy session'],
"     \['▷ toggle coverage marks                      (coveragepy)',
"         \'Coveragepy show'],
"     \['▷ toggle indent lines                                        ⌘ ,L',
"         \'IndentLinesToggle'],
"     \]
"
" "-------------------------------------------------------------------------------
" " reST {{{5
" "-------------------------------------------------------------------------------
"
" nnoremap <silent>[menu]r :Unite -silent menu:rest<CR>
"
" let g:unite_source_menu_menus.rest = {
"     \ 'description' : '           reStructuredText
"     \                                      ⌘ \r',
"     \}
" let g:unite_source_menu_menus.rest.command_candidates = [
"     \['▷ CheatSheet',
"         \'RivCheatSheet'],
"     \['▷ reStructuredText Specification',
"         \'RivSpecification'],
"     \]
"
" "-------------------------------------------------------------------------------
" " Bookmarks {{{5
" "-------------------------------------------------------------------------------
"
" nnoremap <silent>[menu]m :Unite -silent menu:bookmarks<CR>
"
" let g:unite_source_menu_menus.bookmarks = {
"     \ 'description' : '      bookmarks
"         \                                             ⌘ \m',
"     \}
" let g:unite_source_menu_menus.bookmarks.command_candidates = [
"     \['▷ open bookmarks                                             ⌘ [space]m',
"         \'Unite -buffer-name=bookmarks bookmark:*'],
"     \['▷ add bookmark',
"         \'UniteBookmarkAdd'],
"     \]
"
" "-------------------------------------------------------------------------------
" " Vim {{{5
" "-------------------------------------------------------------------------------
"
" nnoremap <silent>[menu]v :Unite menu:vim -silent -start-insert<CR>
"
" let g:unite_source_menu_menus.vim = {
"     \ 'description' : '            vim
"         \                                                   ⌘ \v',
"     \}
" let g:unite_source_menu_menus.vim.command_candidates = [
"     \['▷ choose colorscheme',
"         \'Unite -buffer-name=colorschemes colorscheme -auto-preview'],
"     \['▷ mappings',
"         \'Unite -buffer-name=mappings mapping -start-insert'],
"     \['▷ edit configuration file (vimrc)',
"         \'edit $MYVIMRC'],
"     \['▷ choose filetype',
"         \'Unite -buffer-name=filetypes -start-insert filetype'],
"     \['▷ vim help                                                   ⌘ [space]h',
"         \'Unite -buffer-name=help -start-insert help'],
"     \['▷ vim commands',
"         \'Unite -buffer-name=commands -start-insert command'],
"     \['▷ vim functions',
"         \'Unite -buffer-name=functions -start-insert function'],
"     \['▷ vim runtimepath',
"         \'Unite -buffer-name=runtimepath -start-insert runtimepath'],
"     \['▷ vim command output',
"         \'Unite -buffer-name=cmdoutput output'],
"     \['▷ unite sources                                              ⌘ [space]a',
"         \'Unite -buffer-name=sources source'],
"     \['▷ kill process',
"         \'Unite -buffer-name=processes -default-action=sigkill -start-insert process'],
"     \['▷ launch executable (dmenu like)',
"         \'Unite -buffer-name=programs -start-insert launcher'],
"     \]
"
" "-------------------------------------------------------------------------------
" " Options {{{3
" "-------------------------------------------------------------------------------
"
" " use fuzzy matching
" call unite#filters#matcher_default#use(['matcher_fuzzy'])
"
" call unite#filters#sorter_default#use(['sorter_rank'])
" call unite#custom#source('file_mru,file_rec,file_rec/async,grep,locate',
"             \ 'ignore_pattern', join(['\.git/', 'tmp/', 'bundle/'], '\|'))
"
" let g:unite_source_history_yank_enable = 1
" let g:unite_enable_start_insert        = 1
" let g:unite_enable_short_source_mes    = 0
" let g:unite_force_overwrite_statusline = 0
" let g:unite_prompt         = '>>> '
" let g:unite_marked_icon    = '✓'
" " let g:unite_candidate_icon = '∘'
" let g:unite_winheight      = 15
" let g:unite_update_time    = 200
" let g:unite_split_rule     = 'botright'
" let g:unite_data_directory = $HOME.'/.vim/tmp/unite'
" let g:unite_source_buffer_time_format        = '(%d-%m-%Y %H:%M:%S) '
" let g:unite_source_file_mru_time_format      = '(%d-%m-%Y %H:%M:%S) '
" let g:unite_source_directory_mru_time_format = '(%d-%m-%Y %H:%M:%S) '
"
" if executable('ag')
"     let g:unite_source_grep_command       = 'ag'
"     let g:unite_source_grep_default_opts  = '--nocolor --nogroup -a -S'
"     let g:unite_source_grep_recursive_opt = ''
"     let g:unite_source_grep_search_word_highlight = 1
" elseif executable('ack')
"     let g:unite_source_grep_command       = 'ack'
"     let g:unite_source_grep_default_opts  = '--no-group --no-color'
"     let g:unite_source_grep_recursive_opt = ''
"     let g:unite_source_grep_search_word_highlight = 1
" endif
"
" " }}}3
"
"
" " }}}2

let g:junkfile#directory=expand($HOME."/.vim/tmp/junk")

"===============================================================================


" Programming {{{1
"===============================================================================

" highlight strings inside C comments
let c_comment_strings   = 1

" Highlight syntax errors
let c_space_errors      = 1
let java_space_errors   = 1
let python_space_errors = 1
let ruby_space_errors   = 1

" Highlight functions with java style
let java_highlight_functions = "style"

let java_allow_cpp_keywords  = 1

" activate matchit % matching
if has("eval")
  runtime! macros/matchit.vim
endif

" ignore VCS
set wildignore+=RCS,CVS,.svn,.hg,.git

" ignore tags and cscope files
set wildignore+=tags,cscope.out,types_*.vim

" ignore generated files
set wildignore+=*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.hi

" ignore qt moc and qrc source files
set wildignore+=moc_*.cpp,qrc_*.cpp

" python
set wildignore+=*.pyc,*/__pycache__/*

" ignore certificates
set wildignore+=*.pem

" abbreviations
iab #i #include
iab #d #define

" ctags
"set tags=./tags;$HOME,tags

"===============================================================================

" Relative Line Numbers {{{1
"===============================================================================

" show line numbers relative to current line
set relativenumber

"augroup vimrc_relativenumber
"  autocmd!
"
"  " only show relative numbers when window is focused
"  autocmd FocusLost   * :set number
"  autocmd FocusGained * :set relativenumber
"
"  " do not show relative numbers in insert mode
"  autocmd InsertEnter * :set number
"  autocmd InsertLeave * :set relativenumber
"augroup END

function! RelativeNumberToggle()
  if !&number && !&relativenumber
    set number
    set norelativenumber
  elseif &number && !&relativenumber
    set nonumber
    set relativenumber
  elseif !&number && &relativenumber
    set number
    set relativenumber
  else
    set nonumber
    set norelativenumber
  endif
endfunc

nnoremap <silent><Leader>l :call RelativeNumberToggle()<CR>



" autocmds {{{1
"===============================================================================
"if has("autocmd")

augroup vimrc_filetypes
  autocmd!

  " spell correct commit messages
  autocmd FileType gitcommit setlocal spell

  " xorg-server-1.8.0
  autocmd BufEnter /etc/X11/xorg.conf.d/* setf xf86conf

  " Gentoo file types
  autocmd BufEnter *.eblit setf ebuild

  autocmd BufEnter /etc/portage/env/* setf ebuild
  autocmd BufEnter /etc/portage/bashrc.d/* setf ebuild

  " /var/log/*
  autocmd BufRead /var/log/* setf messages

  " Always use tabs for indenting XML stuff
  autocmd BufEnter *.\(xml\|xsl\) set noexpandtab

  autocmd BufEnter xorg.conf set foldmethod=syntax

  " re-source vimrc when written
  "autocmd BufWritePost ~/.vimrc :source ~/.vimrc

  " remind
  autocmd BufEnter *.rem  setf remind
  autocmd FileType remind set textwidth=0

  autocmd BufEnter *.gp    setf gnuplot

  autocmd BufEnter *vimperatorrc setf vim


  " Haskell
  "autocmd FileType haskell compiler ghc
  autocmd FileType haskell set ts=4 sw=4
  autocmd FileType haskell set expandtab


  " differently name slrnrc
  autocmd BufEnter slrnrc setf slrnrc

  " ProVerif
  autocmd BufEnter *.pv setf ocaml

  " markdown
  autocmd BufEnter *.{md,mld,mark,markdown} set filetype=markdown

  autocmd BufEnter *.qrc setf xml


  " Java
  autocmd FileType java setlocal omnifunc=javacomplete#Complete
  "autocmd FileType java setlocal errorformat=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#
  "autocmd FileType java setlocal makeprg=ant\ -Dbuild.sysclasspath=ignore\ -find\ 'build.xml'
  "autocmd FileType java setlocal completefunc=javacomplete#CompleteParamsInfo
  autocmd FileType java set makeprg=ant\ -find\ 'build.xml'
  autocmd FileType java exe ":compiler ant"
  autocmd FileType java set shellpipe=2>&1\ \|\ tee

  " do not use tabs
  autocmd FileType java set expandtab

  " add separately generated java jdk tags
  autocmd FileType java set tags+=~/.vim/tags/jdk_tags

  autocmd FileType java set keywordprg=:help

  " enable gf/^wf for weird java path structures
  autocmd FileType java set path=**
  autocmd FileType java set suffixesadd=.java

  " add javadoc help files generated with vimdoclet
  autocmd FileType java set runtimepath+=~/.vim/javadoc
  autocmd FileType java set keywordprg=:help

  " insert class imports
  autocmd FileType java nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
  autocmd FileType java imap <F4> <Plug>(JavaComplete-Imports-AddSmart)
  autocmd FileType java nmap <F5> <Plug>(JavaComplete-Imports-Add)
  autocmd FileType java imap <F5> <Plug>(JavaComplete-Imports-Add)
  autocmd FileType java nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
  autocmd FileType java imap <F6> <Plug>(JavaComplete-Imports-AddMissing)
  autocmd FileType java nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
  autocmd FileType java imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)

  " Python (disabled, use settings from python-mode)
  "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  "autocmd FileType python setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
  "autocmd FileType python setlocal expandtab
  "autocmd FileType python setlocal makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
  "autocmd FileType python setlocal errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

  " web completion
  autocmd FileType css        setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html       setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType xml        setlocal omnifunc=xmlcomplete#CompleteTags

  autocmd FileType markdown   setlocal omnifunc=htmlcomplete#CompleteTags

  autocmd BufEnter *.mdwn set filetype=ikiwiki

  " csv
  autocmd BufEnter *.csv set filetype=csv scrollbind scrollopt+=hor scrollopt-=ver nowrap

augroup END

"autocmd BufEnter *.csv set tabstop=10 | call OpenCSV()
" display header line in separate window with height 1
"function! OpenCSV()
"  split
"  resize 1
"  "wincmd j
"endfunction


"endif " has("autocmd")
"===============================================================================

" Plugin Settings {{{1
"===============================================================================

" Misc {{{2
"-------------------------------------------------------------------------------

" remind file abbreviations
function! s:RemindAbbreviations()
  iab r REM
  iab m MSG
  iab pri PRIORITY
  iab d <C-r>=strftime("%a")<CR>
  iab t <C-r>=strftime("%b %d %Y")<CR>
endfunction

augroup vimrc_remind
  autocmd!

  autocmd! FileType remind call s:RemindAbbreviations()
augroup END

" Haskell
let g:haddock_browser="/usr/bin/w3m"

let g:ikiwiki_render_filetype = "markdown"

let g:markdown_fenced_languages = ['diff', 'bash=sh', 'gdb', 'python', 'perl', 'c', 'cpp']

" Disable modelines, use securemodelines.vim instead
set nomodeline
let g:secure_modelines_verbose = 0
let g:secure_modelines_modelines = 15

" misc plugins
"let g:tex_flavor = 'latex'
let g:showmarks_enable = 0

" sessionman
" nnoremap <Leader>ss  :wa<CR>:SessionSave<CR>
" nnoremap <Leader>ssa :wa<CR>:SessionSaveAs<CR>
" nnoremap <Leader>sr  :wa<CR>:SessionOpenLast<CR>
" nnoremap <Leader>so  :wa<CR>:SessionOpen<CR>
" nnoremap <Leader>sl  :SessionShowLast<CR>

" EasyGrep
let g:EasyGrepRecursive = 1

" DelimitMate
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr    = 1

" camelcasemotion
map <S-W> <Plug>CamelCaseMotion_w
map <S-B> <Plug>CamelCaseMotion_b
map <S-E> <Plug>CamelCaseMotion_e

" highlight operators
augroup vimrc_csyntaxafter
  autocmd!
  autocmd! FileType c,cpp,objc,java,javascript call CSyntaxAfter()
augroup END

"-------------------------------------------------------------------------------

" clang_format {{{2
"-------------------------------------------------------------------------------

let g:clang_format#style_options = {
      \ "AccessModifierOffset" : -4,
      \ "AllowShortIfStatementsOnASingleLine" : "true",
      \ "AlwaysBreakTemplateDeclarations" : "true",
      \ "Standard" : "C++11",
      \ "BreakBeforeBraces" : "Stroustrup"}

augroup vimrc_clang_format
  autocmd!

  " map to <Leader>cf in C++ code
  autocmd! FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
  autocmd! FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

  " needs vim-operator-user
  autocmd! FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
augroup END

"-------------------------------------------------------------------------------

" neocomplete/neocomplcache {{{2
"-------------------------------------------------------------------------------

if g:use_neocomplete
  " neocomplete {{{3
  "-------------------------------------------------------------------------------

  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplete#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  "let g:neocomplete#sources#omni#input_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
  let g:neocomplete#sources#omni#input_patterns.c    = '[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplete#sources#omni#input_patterns.cpp  = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


  " toggle the auto select feature
  function! ToggleNeoComplete()
    if !g:neocomplete#disable_auto_complete && g:neocomplete#enable_auto_select
      let g:neocomplete#disable_auto_complete = 0
      let g:neocomplete#enable_auto_select = 0
    elseif !g:neocomplete#disable_auto_complete && !g:neocomplete#enable_auto_select
      let g:neocomplete#disable_auto_complete = 1
      let g:neocomplete#enable_auto_select = 0
    elseif g:neocomplete#disable_auto_complete && !g:neocomplete#enable_auto_select
      let g:neocomplete#disable_auto_complete = 0
      let g:neocomplete#enable_auto_select = 1
    endif
  endfunction
  nnoremap <silent><Leader>ea :call ToggleNeoComplete()<CR>

else
  " neocomplcache {{{3
  "-------------------------------------------------------------------------------
  let g:neocomplcache_enable_at_startup = 1
  let g:neocomplcache_enable_smart_case = 1

  let g:neocomplcache_enable_camel_case_completion = 1
  let g:neocomplcache_enable_underbar_completion   = 1

  let g:neocomplcache_auto_completion_start_length   = 3
  let g:neocomplcache_manual_completion_start_length = 3

endif

" }}}3
"-------------------------------------------------------------------------------

" neosnippets {{{2
"-------------------------------------------------------------------------------
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
"-------------------------------------------------------------------------------

" winresize {{{2
"-------------------------------------------------------------------------------

let g:winresizer_start_key = '<C-C><C-W>'
" finish with 'r'
let g:winresizer_keycode_finish = 27

" }}}2
"===============================================================================
" }}}1


"===============================================================================
" Colors {{{1
"===============================================================================

" don't load CSApprox without gui support
if !has('gui')
  let g:CSApprox_verbose_level = 0

  " 256 colors
  set t_Co=256

  " 256 color version
  colorscheme fruity256
endif

" cursor line
set cursorline

" make directory color more readable with dark background
highlight Directory term=bold ctermfg=cyan guifg=cyan


"===============================================================================
" Local {{{1
"===============================================================================

" include local configuration
let s:vimlocalconfig = $HOME . '/.vim/local.vim'

if filereadable(s:vimlocalconfig)
  exe 'source ' . s:vimlocalconfig
endif

"===============================================================================
