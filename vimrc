scriptencoding utf-8

" Filename:      /etc/vim/vimrc
" Purpose:       setup file for the VIM editor
" Author:        (c) Andreas Niederl <rico32@gmx.net>
" License:       This file is licensed under the GPL v2.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Plugin Initialization Settings {{{1
"===============================================================================

" map '-' to ',' so it can be used for reverse character search with f/t/F/T
nnoremap - ,

" use ',' as leader
let mapleader = ','

" use '\' as local leader
let maplocalleader = '\\'

" tasklist.vim shortcut
map <Leader>u <Plug>TaskList

"===============================================================================


" NeoBundle Plugins {{{1
"===============================================================================

" Setup {{{2
"-------------------------------------------------------------------------------

filetype off

if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundle 'Shougo/neobundle.vim'


"-------------------------------------------------------------------------------
" vimproc {{{2
"-------------------------------------------------------------------------------

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }


"-------------------------------------------------------------------------------
" neocomplete {{{2
"-------------------------------------------------------------------------------

" use new neocomplete completion if possible
if v:version >= 704 && has('lua')
  let g:use_neocomplete = 1
  NeoBundle 'Shougo/neocomplete'
else
  NeoBundle 'Shougo/neocomplcache'
endif


"-------------------------------------------------------------------------------
" snippets {{{2
"-------------------------------------------------------------------------------

" snippets
NeoBundle 'Shougo/neosnippet'

" snippet collection for different languages
NeoBundle 'honza/vim-snippets'


"-------------------------------------------------------------------------------
" statusline {{{2
"-------------------------------------------------------------------------------

" powerline statusline
"NeoBundle 'lokaltog/powerline'

" airline statusline
NeoBundle 'bling/vim-airline'


"-------------------------------------------------------------------------------
" git {{{2
"-------------------------------------------------------------------------------

" git integration
NeoBundle 'tpope/vim-fugitive', { 'augroup' : 'fugitive' }
NeoBundle 'tpope/vim-git'


"-------------------------------------------------------------------------------
" Motions and Regions {{{2
"-------------------------------------------------------------------------------

" motions for CamelCase
NeoBundle 'camelcasemotion'

" extend % matching
NeoBundle 'matchit.zip'
NeoBundle 'ruby-matchit'
NeoBundle 'voithos/vim-python-matchit'

" surroundings, quoting, tags, etc.
NeoBundle 'tpope/vim-surround'

" narrow region extraction/editing
NeoBundle 'chrisbra/NrrwRgn'


"-------------------------------------------------------------------------------
" Sessions {{{2
"-------------------------------------------------------------------------------

" session manager
NeoBundle 'sessionman.vim'

" session obsession
NeoBundle 'tpope/vim-obsession'


"-------------------------------------------------------------------------------
" General {{{2
"-------------------------------------------------------------------------------

" custom operators
NeoBundle 'kana/vim-operator-user'

" secure modelines
NeoBundle 'ciaranm/securemodelines'

" mapping pairs
NeoBundle 'tpope/vim-unimpaired'

" smart casing substition, abbreviation and coercion
NeoBundle 'tpope/vim-abolish'

" alignment
NeoBundle 'junegunn/vim-easy-align'

" colorschemes
NeoBundle 'flazz/vim-colorschemes'

" display signs at interesting lines
NeoBundle 'tomtom/quickfixsigns_vim'

" highlight several words in different colors simultaneously
NeoBundle 'Mark--Karkat'

" powerful file explorer
NeoBundle 'Shougo/vimfiler.vim'

" create junk files for scratch editing
NeoBundle 'Shougo/junkfile.vim'


"-------------------------------------------------------------------------------
" General Coding {{{2
"-------------------------------------------------------------------------------

" smart tabs: tabs for indentation, spaces for alignment
"NeoBundle 'Smart-Tabs'

" auto-balancing delimiters
NeoBundle 'Raimondi/delimitMate'

" intelligent commenting
NeoBundle 'tomtom/tcomment_vim'

" powerful syntax checker
NeoBundle 'scrooloose/syntastic'

" highlight custom types and classes
NeoBundle 'TagHighlight'

" end structures automatically
NeoBundle 'tpope/vim-endwise'

" detect file indentation settings and warn on inconsistencies
NeoBundle 'IndentConsistencyCop'
NeoBundle 'IndentConsistencyCopAutoCmds'

" textobject 'a' for function/method arguments
NeoBundle 'argtextobj.vim'


"-------------------------------------------------------------------------------
" General Editing {{{2
"-------------------------------------------------------------------------------

" ansi escape sequences
NeoBundle 'AnsiEsc.vim'

" graphical undo
NeoBundle 'Gundo'

" repeat some plugin commands with '.'
NeoBundle 'tpope/vim-repeat'

" table movement and alignment
NeoBundle 'godlygeek/tabular'

" accumulate all spelling errors in the quickfix buffer
NeoBundle 'SpellCheck'


"-------------------------------------------------------------------------------
" Unite {{{2
"-------------------------------------------------------------------------------

NeoBundle 'Shougo/unite.vim'

" show an outline
NeoBundle 'Shougo/unite-outline'


" switch through colorschemes
NeoBundle 'ujihisa/unite-colorscheme'

" locate
NeoBundle 'ujihisa/unite-locate'

" fonts
NeoBundle 'ujihisa/unite-font'


" unite everything
NeoBundle 'sgur/unite-everything'


" filetypes
NeoBundle 'osyo-manga/unite-filetype'

" folds
NeoBundle 'osyo-manga/unite-fold'

" quickfix
NeoBundle 'osyo-manga/unite-quickfix'


" help
NeoBundle 'tsukkee/unite-help'

" tags
NeoBundle 'tsukkee/unite-tag'


" marks
NeoBundle 'tacroe/unite-mark'

" aliases
NeoBundle 'tacroe/unite-alias'


" tasklist
NeoBundle 'junkblocker/unite-tasklist'

" history
NeoBundle 'thinca/vim-unite-history'


"-------------------------------------------------------------------------------
" C/C++ {{{2
"-------------------------------------------------------------------------------

" clang completer for C and C++
NeoBundle 'Rip-Rip/clang_complete'

" clang formatter
NeoBundle 'rhysd/vim-clang-format'

" cscope
NeoBundle 'autoload_cscope.vim'

" highlight operators in C-like languages
NeoBundle 'cSyntaxAfter'


"-------------------------------------------------------------------------------
" Java {{{2
"-------------------------------------------------------------------------------

" basic java completion
NeoBundle 'javacomplete'


"-------------------------------------------------------------------------------
" Octave {{{2
"-------------------------------------------------------------------------------

NeoBundle 'octave.vim'


"-------------------------------------------------------------------------------
" Python {{{2
"-------------------------------------------------------------------------------

" Python-mode
NeoBundle 'klen/python-mode'

" conceal
NeoBundle 'ehamberg/vim-cute-python'

" nose unit tests
NeoBundle 'lambdalisue/nose.vim'


"-------------------------------------------------------------------------------
" Perl {{{2
"-------------------------------------------------------------------------------

" perl editing in vim
NeoBundle 'vim-perl/vim-perl'

" completion
NeoBundle 'c9s/perlomni.vim'

" documentation
NeoBundle 'hotchpotch/perldoc-vim'


"-------------------------------------------------------------------------------
" Ruby {{{2
"-------------------------------------------------------------------------------

" editing Ruby with vim
NeoBundle 'vim-ruby/vim-ruby'

" refactoring
NeoBundle 'ecomba/vim-ruby-refactoring'

" testing with cucumber
NeoBundle 'tpope/vim-cucumber'

" browser Ruby documentation from inside Vim
NeoBundle 'danchoi/ri.vim'

" HTML-embedded ruby
NeoBundle 'eruby.vim'

" Haml, Sass, SCSS
NeoBundle 'tpope/vim-haml'


"-------------------------------------------------------------------------------
" Haskell {{{2
"-------------------------------------------------------------------------------

" Vim to Haskell
NeoBundle 'dag/vim2hs'

" ghc integration
NeoBundle 'eagletmt/ghcmod-vim'

" completion with ghc
NeoBundle 'ujihisa/neco-ghc'


"-------------------------------------------------------------------------------
" Scala {{{2
"-------------------------------------------------------------------------------

NeoBundle 'derekwyatt/vim-scala'


"-------------------------------------------------------------------------------
" HTML/CSS {{{2
"-------------------------------------------------------------------------------

" HTML, CSS, etc.
NeoBundle 'mattn/emmet-vim'


"-------------------------------------------------------------------------------
" LaTeX {{{2
"-------------------------------------------------------------------------------

" LaTeXSuite
NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex'

"-------------------------------------------------------------------------------
" Markdown {{{2
"-------------------------------------------------------------------------------

" markdown
NeoBundle 'tpope/vim-markdown'

" pandoc
NeoBundle 'pdc.vim'


"-------------------------------------------------------------------------------
" Misc. Syntax {{{2
"-------------------------------------------------------------------------------

" gitolite
NeoBundle 'tmatilai/gitolite'

" gtk
NeoBundle 'gtk-vim-syntax'

" lighttpd
NeoBundle 'lighttpd-syntax'

" nagios
NeoBundle 'nagios-syntax'

" Nmap
NeoBundle 'Nmap-syntax-highlight'

" ntp
NeoBundle 'ntp.vim'

" pam
NeoBundle 'pam.vim'

" qmake
NeoBundle 'qmake--syntax.vim'

" udev
NeoBundle 'syntaxudev.vim'

" xquery
NeoBundle 'XQuery-syntax'

" xslt
NeoBundle 'XSLT-syntax'


"-------------------------------------------------------------------------------
" Check and Load {{{2
"-------------------------------------------------------------------------------

" Required for Check
filetype plugin indent on

NeoBundleCheck

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


" spell checking {{{2
"-------------------------------------------------------------------------------

" check for spelling errors
set spell

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


" " custom statusline format
" set statusline=
"
" " show buffer number first with width always 3
" " %-0{minwid}.{maxwid}{item}
" set statusline+=%-3.3n\      " trailing whitespace
"
" " truncate at start
" set statusline+=%<
"
" " filename
" set statusline+=%f\          " trailing whitespace
"
" " status flags
" set statusline+=%h%m%r
"
" " show filetype
" set statusline+=%y
"
" " fileformat
" set statusline+=\%{(&fileformat!='unix'?'['.&fileformat.']':'')}
"
" " file encoding
" function! StatusLineFileEncoding()
"   let default='utf-8'
"   let status=''
"   let encoding=''
"   if (&fenc != '') && (&fenc != default)
"   encoding=&fenc
" elseif (&enc != '') && (&enc != default)
" encoding=&enc
"   endif
"   if (encoding != '')
"     status = '[' . encoding . ']'
"   endif
"   return status
" endfunction
" set statusline+=\%{StatusLineFileEncoding()}
"
" " show fugitive info
" set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
"
" " separation point; following fields are right aligned
" set statusline+=%=
"
" " show byte value under cursor in hex
" set statusline+=0x%-8B\ \  " trailing whitespace
"
" " show line, column and virtual column number
" set statusline+=%-14.(%l,%c%V%)
"
" " position in file
" set statusline+=%P
"

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
set foldmethod=marker

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
  autocmd BufWinEnter * match SpaceError /\s\+$\| \+\ze\t/
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

" Fugitive {{{2
"-------------------------------------------------------------------------------

nnoremap <Leader>gn  :Unite output:echo\ system("git\ init")<CR>
nnoremap <Leader>gs  :Gstatus<CR>
nnoremap <Leader>gw  :Gwrite<CR>
nnoremap <Leader>go  :Gread<CR>
nnoremap <Leader>gR  :Gremove<CR>
nnoremap <Leader>gm  :Gmove<CR>
nnoremap <Leader>gc  :Gcommit<CR>
nnoremap <Leader>gd  :Gdiff<CR>
nnoremap <Leader>gp  :Git! push<CR>
nnoremap <Leader>gP  :Git! pull<CR>
nnoremap <Leader>gi  :Git!<Space>
nnoremap <Leader>ge  :Gedit<CR>
nnoremap <Leader>gE  :Gedit<Space>
nnoremap <Leader>gl  :exe "silent Glog <Bar> Unite -no-quit quickfix"<CR>:redraw!<CR>
nnoremap <Leader>gL  :exe "silent Glog -- <Bar> Unite -no-quit quickfix"<CR>:redraw!<CR>
nnoremap <Leader>gt  :!tig<CR>:redraw!<CR>
nnoremap <Leader>gg  :exe 'silent Ggrep -i '.input("Pattern: ").'<Bar>Unite -no-quit quickfix'<CR>
nnoremap <Leader>ggm :exe 'silent Glog --grep='.input("Pattern: ").'<Bar>Unite -no-quit quickfix'<CR>
nnoremap <Leader>ggt :exe 'silent Glog -S='.input("Pattern: ").'<Bar>Unite -no-quit quickfix'<CR>
nnoremap <Leader>ggc :silent! Ggrep -i<Space>

" diff mode
nnoremap <Leader>du :diffupdate<CR>

if !exists(":Gdiffoff")
  command Gdiffoff diffoff | q | Gedit
endif
nnoremap <Leader>dq :Gdiffoff<CR>

" }}}2

" navigate tabs like vimperator
noremap <silent> <C-n> :tabnext<CR>
noremap <silent> <C-p> :tabprev<CR>

" toggle line numbers
nnoremap <F7> :set number!<CR>

" toggle list mode
nnoremap <F8> :set list!<CR>

" pastetoogle key, enter paste mode for disabling autoindentation when
" pasting something into vim
nnoremap <silent> <Leader>p :set invpaste<CR>

" remove highlighting from previous search
nnoremap <silent> <Leader>v :nohlsearch<CR>

" build buffer and show errors
nnoremap <LocalLeader>m :call BuildProject()<CR>

" update tags and types file
" nnoremap <Leader>u :UpdateTypesFile!<CR>

" toggle quickfix window using Vim Tip 1008
let g:jah_Quickfix_Win_Height = 10
nnoremap <silent> <LocalLeader>ff :QFix<CR>

nnoremap <silent> <LocalLeader>fn :cnext<CR>
nnoremap <silent> <LocalLeader>fp :cprevious<CR>

" toggle taglist window
"nnoremap <silent> <LocalLeader>t :TlistToggle<CR>

" toggle tagbar window
nnoremap <silent> <LocalLeader>t :TagbarToggle<CR>

" ctrlp mappings
"nnoremap <silent> <Leader>f :CtrlP<CR>
"nnoremap <silent> <Leader>b :CtrlPBuffer<CR>
"nnoremap <silent> <Leader>T :CtrlPBufTag<CR>
"nnoremap <silent> <Leader>t :CtrlPTag<CR>
"nnoremap <silent> <Leader>F :CtrlPCurWD<CR>
"nnoremap <silent> <Leader>M :CtrlPMRUFiles<CR>
"nnoremap <silent> <Leader>m :CtrlPMixed<CR>
"nnoremap <silent> <Leader>l :CtrlPLine<CR>

" navigate through quickfix buffer with main window following errors
nnoremap <silent> <C-j> :cnext<CR>
nnoremap <silent> <C-k> :cprevious<CR>


" relative tab nav
nnoremap <silent> <C-h> :tabprevious<CR>
nnoremap <silent> <C-l> :tabnext<CR>

" relative tab move
nnoremap <silent> <A-Left>  :execute 'silent! tabmove ' . (tabpagenr() - 2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr())<CR>

function! CloseTab()
  if winnr("$") == 1  && tabpagenr() > 1 && tabpagenr() < tabpagenr("$")
    tabclose | tabprev
  else
    quit
  endif
endfunction
nmap <silent> Q :call CloseTab()<CR>

nnoremap te :tabe
nnoremap td :tab drop
nnoremap ts :tab split<CR>


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

" ignore certificates
set wildignore+=*.pem

" abbreviations
iab #i #include
iab #d #define

" ctags
set tags=./tags;$HOME,tags

"===============================================================================

" Relative Line Numbers {{{1
"===============================================================================

" show line numbers relative to current line
set relativenumber

augroup vimrc_relativenumber
  autocmd!

  " only show relative numbers when window is focused
  autocmd FocusLost   * :set number
  autocmd FocusGained * :set relativenumber

  " do not show relative numbers in insert mode
  autocmd InsertEnter * :set number
  autocmd InsertLeave * :set relativenumber
augroup END

function! RelativeNumberToggle()
  if (&relativenumber == 0)
    set relativenumber
  else
    set number
  endif
endfunc

nnoremap <C-n> :call RelativeNumberToggle()<CR>

" Misc {{{1
"===============================================================================
" write changes on buffer switch or :make
set autowrite

" read a file unasked when unchanged in vim but changed outside
set autoread

" Show the current mode
set showmode

" show matching parenthesises
set showmatch

" do not flicker around
set novisualbell

" context for scrolling
set scrolloff=3

" backspace over autoindent, line breaks and start of insert mode
set backspace=indent,eol,start

" always show line number and names of matching files when grepping
set grepprg=grep\ -nH\ $*

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
  autocmd FileType haskell compiler ghc
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
function! l:RemindAbbreviations()
  iab r REM
  iab m MSG
  iab pri PRIORITY
  iab d <C-r>=strftime("%a")<CR>
  iab t <C-r>=strftime("%b %d %Y")<CR>
endfunction

augroup vimrc_remind
  autocmd!

  autocmd! FileType remind call l:RemindAbbreviations()
augroup END

" airline
let g:airline_symbols       = get(g:, 'airline_symbols', {})
let g:airline_symbols.space = "\ua0"

" Haskell
let g:haddock_browser="/usr/bin/w3m"

let g:ikiwiki_render_filetype = "markdown"

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
nnoremap <LocalLeader>s :DelimitMateSwitch<CR>
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

" airline
let g:airline_powerline_fonts = 1

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

" }}}2
"===============================================================================
" }}}1

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

"===============================================================================
