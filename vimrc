scriptencoding utf-8

" Filename:      /etc/vim/vimrc
" Purpose:       setup file for the VIM editor
" Author:        (c) Andreas Niederl <rico32@gmx.net>
" License:       This file is licensed under the GPL v2.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let maplocalleader=','

" tasklist.vim shortcut
map <LocalLeader>u <Plug>TaskList

" activate pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


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


" statusline {{{2
"-------------------------------------------------------------------------------

" always show status line
set laststatus=2


" custom statusline format
set statusline=

" show buffer number first with width always 3
" %-0{minwid}.{maxwid}{item}
set statusline+=%-3.3n\      " trailing whitespace

" truncate at start
set statusline+=%<

" filename
set statusline+=%f\          " trailing whitespace

" status flags
set statusline+=%h%m%r

" show filetype
set statusline+=%y

" show fugitive info
set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}

" separation point; following fields are right aligned
set statusline+=%=

" show byte value under cursor in hex
set statusline+=0x%-8B\ \  " trailing whitespace

" show line, column and virtual column number
set statusline+=%-14.(%l,%c%V%)

" position in file
set statusline+=%P


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

" use tabs for indentation, spaces for alignment (ctab.vim)
set noexpandtab

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

au BufEnter *.tex setlocal wildignore+=*.log

"===============================================================================

" highlight trailing whitespaces and whitespaces before tabs {{{1
" \ze sets end of match for highlighting
highlight TrailingSpaces term=standout cterm=bold ctermbg=red ctermfg=white gui=bold guibg=red guifg=white
autocmd BufWinEnter * match TrailingSpaces /\s\+$\| \+\ze\t/


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

" used to track the quickfix window
augroup QFixToggle
 autocmd!
 autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
 autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
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

" shortcut for ex cmds
"nnoremap ; :


" CreateMaps from NERD_commenter.vim
function! s:CreateMaps(target, combo)
	if !hasmapto(a:target, 'n')
		exec 'nmap ' . a:combo . ' ' . a:target
	endif

	if !hasmapto(a:target, 'v')
		exec 'vmap ' . a:combo . ' ' . a:target
	endif
endfunction

let g:NERDCreateMyMappings = 1
if g:NERDCreateMyMappings
	call s:CreateMaps('<plug>NERDCommenterComment',    '<LocalLeader>cc')
	call s:CreateMaps('<plug>NERDCommenterToggle',     '<LocalLeader>c<space>')
	call s:CreateMaps('<plug>NERDCommenterMinimal',    '<LocalLeader>cm')
	call s:CreateMaps('<plug>NERDCommenterSexy',       '<LocalLeader>cs')
	call s:CreateMaps('<plug>NERDCommenterInvert',     '<LocalLeader>ci')
	call s:CreateMaps('<plug>NERDCommenterYank',       '<LocalLeader>cy')
	call s:CreateMaps('<plug>NERDCommenterAlignLeft',  '<LocalLeader>cl')
	call s:CreateMaps('<plug>NERDCommenterAlignBoth',  '<LocalLeader>cb')
	call s:CreateMaps('<plug>NERDCommenterNest',       '<LocalLeader>cn')
	call s:CreateMaps('<plug>NERDCommenterUncomment',  '<LocalLeader>cu')
	call s:CreateMaps('<plug>NERDCommenterToEOL',      '<LocalLeader>c$')
	call s:CreateMaps('<plug>NERDCommenterAppend',     '<LocalLeader>cA')

	if !hasmapto('<plug>NERDCommenterAltDelims', 'n')
		nmap <LocalLeader>ca <plug>NERDCommenterAltDelims
	endif
endif


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
nnoremap <silent> <LocalLeader>n :nohlsearch<CR>

" build buffer and show errors
nnoremap <LocalLeader>m :call BuildProject()<CR>

" update tags and types file
nnoremap <Leader>u :UpdateTypesFile!<CR>

" toggle quickfix window using Vim Tip 1008
let g:jah_Quickfix_Win_Height = 10
nnoremap <silent> <LocalLeader>ff :QFix<CR>

nnoremap <silent> <LocalLeader>fn :cnext<CR>
nnoremap <silent> <LocalLeader>fp :cprevious<CR>

" nerdtree
nnoremap <silent> <LocalLeader>d :NERDTreeToggle<CR>

" toggle taglist window
nnoremap <silent> <LocalLeader>t :TlistToggle<CR>

" navigate through quickfix buffer with main window following errors
nnoremap <silent> <C-j> :cnext<CR>
nnoremap <silent> <C-k> :cprevious<CR>

" better vmappings for surround.vim
vmap <Leader>s <Plug>Vsurround
vmap <Leader>S <Plug>VSurround


" fuzzyfinder
nnoremap <Leader>f :FufFile<CR>
nnoremap <Leader>F :FufFileWithCurrentBufferDir<CR>
nnoremap <Leader>d :FufDir<CR>
nnoremap <Leader>g :FufBuffer<CR>

" define recursive search with shell globbing
try
	call fuf#defineLaunchCommand('FufFileRecursive', 'file', '"**/"')
	nnoremap <Leader>/ :FufFileRecursive<CR>
catch
endtry

" bindings for alternate.vim
imap <LocalLeader>r  <C-O>:A<CR>
nmap <LocalLeader>r  :A<CR>
imap <LocalLeader>aa <C-O>:A<CR>
nmap <LocalLeader>aa :A<CR>
imap <LocalLeader>as <C-O>:AS<CR>
nmap <LocalLeader>as :AS<CR>
imap <LocalLeader>av <C-O>:AV<CR>
nmap <LocalLeader>av :AV<CR>
imap <LocalLeader>at <C-O>:AT<CR>
nmap <LocalLeader>at :AT<CR>
imap <LocalLeader>an <C-O>:AN<CR>
nmap <LocalLeader>an :AN<CR>


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


" switch ` and ' (` jumps to line and column)
nnoremap ' `
nnoremap ` '


"===============================================================================


" Programming {{{1
"===============================================================================

" highlight strings inside C comments
let c_comment_strings=1

" Highlight syntax errors
let c_space_errors = 1
let java_space_errors = 1
let python_space_errors = 1
let ruby_space_errors = 1

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

"===============================================================================

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
if has("autocmd")

" xorg-server-1.8.0
au BufEnter /etc/X11/xorg.conf.d/* setf xf86conf

" Gentoo file types
au BufEnter *.eblit setf ebuild

au BufEnter /etc/portage/env/* setf ebuild
au BufEnter /etc/portage/bashrc.d/* setf ebuild

" /var/log/*
au BufRead /var/log/* setf messages

" Always use tabs for indenting XML stuff
au BufEnter *.\(xml\|xsl\) set noexpandtab

au BufEnter xorg.conf set foldmethod=syntax

" re-source vimrc when written
au BufWritePost ~/.vimrc :source ~/.vimrc

" remind
au BufEnter *.rem  setf remind
au FileType remind set textwidth=0

function! l:RemindAbbreviations()
	iab r REM
	iab m MSG
	iab pri PRIORITY
	iab d <C-r>=strftime("%a")<CR>
	iab t <C-r>=strftime("%b %d %Y")<CR>
endfunction

au FileType remind call l:RemindAbbreviations()


au BufEnter *.gp    setf gnuplot

au BufEnter *vimperatorrc setf vim


" Haskell
let g:haddock_browser="/usr/bin/w3m"
au FileType haskell compiler ghc
au FileType haskell set ts=4 sw=4
au FileType haskell set expandtab


" differently name slrnrc
au BufEnter slrnrc setf slrnrc

" ProVerif
au BufEnter *.pv setf ocaml

" markdown
au BufEnter *.{md,mld,mark,markdown} set filetype=markdown

au BufEnter *.qrc setf xml


" Java
au FileType java setlocal omnifunc=javacomplete#Complete
"au FileType java setlocal completefunc=javacomplete#CompleteParamsInfo

" Python
au FileType python setlocal omnifunc=pythoncomplete#Complete
au FileType python setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
au FileType python setlocal expandtab

" web completion
au FileType css        setlocal omnifunc=csscomplete#CompleteCSS
au FileType html       setlocal omnifunc=htmlcomplete#CompleteTags
au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
au FileType xml        setlocal omnifunc=xmlcomplete#CompleteTags

au FileType markdown   setlocal omnifunc=htmlcomplete#CompleteTags

let g:ikiwiki_render_filetype = "markdown"
au BufEnter *.mdwn set filetype=ikiwiki

" csv
au BufEnter *.csv set filetype=csv scrollbind scrollopt+=hor scrollopt-=ver nowrap
au BufEnter *.csv set tabstop=10 | call OpenCSV()
" display header line in separate window with height 1
function! OpenCSV()
	split
	resize 1
	"wincmd j
endfunction


endif " has("autocmd")
"===============================================================================

" Plugin Settings {{{1
"===============================================================================

" Disable modelines, use securemodelines.vim instead
set nomodeline
let g:secure_modelines_verbose = 0
let g:secure_modelines_modelines = 15

" misc plugins
let g:tex_flavor = 'latex'
let g:showmarks_enable = 0
let NERDShutUp = 1
let g:NERDCreateDefaultMappings = 0

" sessionman
nnoremap <Leader>ss  :wa<CR>:SessionSave<CR>
nnoremap <Leader>ssa :wa<CR>:SessionSaveAs<CR>
nnoremap <Leader>sr  :wa<CR>:SessionOpenLast<CR>
nnoremap <Leader>so  :wa<CR>:SessionOpen<CR>
nnoremap <Leader>sl  :SessionShowLast<CR>

" EasyGrep
let g:EasyGrepRecursive = 1

" DelimitMate
nnoremap <LocalLeader>s :DelimitMateSwitch<CR>
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr    = 1

" Neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1

let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion   = 1

let g:neocomplcache_auto_completion_start_length   = 3
let g:neocomplcache_manual_completion_start_length = 3


"===============================================================================

" }}}1

" Colors {{{1
"===============================================================================

" don't load CSApprox without gui support
if !has('gui')
	let g:CSApprox_verbose_level = 0
endif

colorscheme fruity256

" cursor line
set cursorline

"===============================================================================
