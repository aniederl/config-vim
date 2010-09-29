scriptencoding utf-8

" Filename:      /etc/vim/vimrc
" Purpose:       setup file for the VIM editor
" Author:        (c) Andreas Niederl <rico32@gmx.net>
" License:       This file is licensed under the GPL v2.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


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
set runtimepath=$HOME/.vim,$ETC_VIM,$ETC_VIM/plugins,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$ETC_VIM/after,~/.vim/after

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
set statusline+=\[%{strlen(&filetype)?&filetype:'none'}]

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


" use tabs for indentation, spaces for alignment (ctab.vim)
set noexpandtab

" use smart indentation (i.e. respect indentation with blank lines in between)
set smartindent

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

let maplocalleader=','


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
nnoremap <Leader>b :call BuildProject()<CR>

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
set wildignore+=*.o,*.a,*.class,*.mo,*.la,*.so,*.obj

" ignore qt moc source files
set wildignore+=moc_*.cpp

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
set shortmess=atAI

" console dialogs instead of popups
set guioptions+=c

" report all line changes
set report=0

" extend command history
set history=1000

"===============================================================================


" autocmds {{{1
"===============================================================================
if has("autocmd")

" xorg-server-1.8.0
au BufNewFile,BufRead /etc/X11/xorg.conf.d/* setf xf86conf

" Gentoo file types
au BufNewFile,BufRead *.eblit setf ebuild

au BufNewFile,BufRead /etc/portage/env/* setf ebuild
au BufNewFile,BufRead /etc/portage/bashrc.d/* setf ebuild

" /var/log/*
au BufRead /var/log/* setf messages

" Always use tabs for indenting XML stuff
au BufNewFile,BufRead *.\(xml\|xsl\) set noexpandtab

au BufNewFile,BufRead xorg.conf set foldmethod=syntax

" re-source vimrc when written
au BufWritePost ~/.vimrc :source ~/.vimrc

" remind
au BufNewFile,BufRead *.rem   setf remind
au BufNewFile,BufRead *.rem   set textwidth=0

function! l:RemindAbbreviations()
	iab r REM
	iab m MSG
	iab pri PRIORITY
	iab d <C-r>=strftime("%a")<CR>
	iab t <C-r>=strftime("%b %d %Y")<CR>
endfunction

au BufNewFile,BufRead *.rem   call l:RemindAbbreviations()


au BufNewFile,BufRead *.gp    setf gnuplot

au BufNewFile,BufRead *vimperatorrc setf vim


" Haskell
let g:haddock_browser="/usr/bin/w3m"
au BufNewFile,BufRead *.hs compiler ghc
au BufNewFile,BufRead *.hs set ts=4 sw=4
au BufNewFile,BufRead *.hs set expandtab


" differently name slrnrc
au BufNewFile,BufRead slrnrc   setf slrnrc

" ProVerif
au BufNewFile,BufRead *.pv setf ocaml

" Java
au BufNewFile,BufRead *.java setlocal omnifunc=javacomplete#Complete
"au BufNewFile,BufRead *.java setlocal completefunc=javacomplete#CompleteParamsInfo

" Python
au BufNewFile,BufRead *.py setlocal omnifunc=pythoncomplete#Complete
au BufNewFile,BufRead *.py setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class


au BufNewFile,BufRead *.{md,mld,mark,markdown} set filetype=markdown

let g:ikiwiki_render_filetype = "markdown"
au BufNewFile,BufRead *.mdwn set filetype=ikiwiki

" csv
au BufNewFile,BufRead *.csv set filetype=csv scrollbind scrollopt+=hor scrollopt-=ver nowrap
au BufNewFile,BufRead *.csv set tabstop=10 | call OpenCSV()
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
let g:tex_flavor='latex'
let g:showmarks_enable=0
let NERDShutUp=1

" sessionman
nnoremap <Leader>ss  :wa<CR>:SessionSave<CR>
nnoremap <Leader>ssa :wa<CR>:SessionSaveAs<CR>
nnoremap <Leader>sr  :wa<CR>:SessionOpenLast<CR>
nnoremap <Leader>so  :wa<CR>:SessionOpen<CR>
nnoremap <Leader>sl  :SessionShowLast<CR>

" EasyGrep
let g:EasyGrepRecursive = 1
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
