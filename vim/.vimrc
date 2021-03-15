" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Jan 26
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
"let skip_defaults_vim=1
"
"
"	Das hier ist Justus Kram 
"
"
"

"Plugins"
call plug#begin('~/.vim/plugged')
Plug 'junegunn/goyo.vim'
call plug#end()

"Header Files"
	set path=.,/usr/local/include/saga/saga_core/,/usr/include/

"Richtung des Splitten"
	set splitright
	"set splitbelow

"Splitmode Shortcuts"
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

"Tabulator auf 4 Leerzeichen
	set shiftwidth=4
	set tabstop=4
	set number

"Woerterbuch"
	map <F6> :setlocal spell! spelllang=de<CR>
	map <F7> :set spelllang=en<CR>

	autocmd FileType tex setlocal spell spelllang=de
	autocmd FileType cpp setlocal spell spelllang=en
	autocmd FileType hpp setlocal spell spelllang=en
	autocmd FileType h setlocal spell spelllang=en
	autocmd FileType gitcommit setlocal spell spelllang=en
	autocmd FileType mail setlocal spell spelllang=de

"Linenumbering"
"Das ist eine Funktion um einfach zwischen relativen und absoluten
"Zeilennummern hin und her zu schalten."
	function! RelNumberToggle()
		if(&rnu == 1)
			set nornu
		else
			set rnu
		endif
	endfunction

	map <C-n> :call RelNumberToggle()<CR>

"Tabcopletion"
	set wildmode=longest,list,full
	set wildmenu
