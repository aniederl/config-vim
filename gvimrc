scriptencoding utf-8

" Filename:      /etc/vim/vimrc
" Purpose:       setup file for the VIM editor
" Author:        (c) Andreas Niederl <rico32@gmx.net>
" License:       This file is licensed under the GPL v2.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" include gentoo specific gvimrc (with sane defaults) if available {{{1
if filereadable(expand("$ETC_VIM/gvimrc.gentoo"))
  source $ETC_VIM/gvimrc.gentoo
endif

" Basic Settings {{{1
"===============================================================================

" hide mouse cursor when typing
set mousehide

" show line numbers
set number

" remove menu bar
set guioptions-=m

" remove icon toolbar
set guioptions-=T

" default font
"set guifont=DejaVu\ Sans\ Mono\ 11

" powerline/airline font
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11

" always show tabline
set showtabline=2

"===============================================================================

" Colors {{{1
"===============================================================================

" white on black
"highlight Normal guifg=white guibg=black

" green bold cursor
"highlight Cursor  guibg=Green guifg=NONE

" cyan for :lmap
"highlight lCursor guibg=Cyan  guifg=NONE

" yellow visual mode
"highlight Visual guifg=black guibg=yellow gui=none

" cyan folds
"highlight Folded guifg=black guibg=cyan

" status line colors
"highlight StatusLine   guibg=white  guifg=red
"highlight StatusLineNC guibg=yellow guifg=blue

colorscheme fruity

" cursor line
highlight CursorLine guibg=Gray20
set cursorline

"===============================================================================

" $HOME/.gvimrc.local {{{1
if filereadable($HOME/'.gvimrc.local')
  source $HOME/'.gvimrc.local'
endif

