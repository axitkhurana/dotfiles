syntax on
set background=dark
set ruler                     " show the line number on the bar
set more                      " use more prompt
set autoread                  " watch for file changes
set number                    " line numbers
set hidden
set noautowrite               " don't automagically write on :next
set lazyredraw                " don't redraw when don't have to
set showmode
set showcmd
set nocompatible              " vim, not vi
set autoindent smartindent    " auto/smart indent
set smarttab                  " tab and backspace are smart
set tabstop=4                 "  spaces
set softtabstop=4
set textwidth=80
set expandtab
set shiftwidth=4
set scrolloff=5               " keep at least 5 lines above/below
set sidescrolloff=5           " keep at least 5 lines left/right
set history=200
set backspace=indent,eol,start
set linebreak
set cmdheight=2               " command line two lines high
set undolevels=1000           " 1000 undos
set updatecount=100           " switch every 100 chars
set complete=.,w,b,u,U,t,i,d  " do lots of scanning on tab completion
set ttyfast                   " we have a fast terminal
set noerrorbells              " No error bells please
set shell=bash
set fileformats=unix
set ff=unix
filetype on                   " Enable filetype detection
filetype indent on            " Enable filetype-specific indenting
filetype plugin on            " Enable filetype-specific plugins
set wildmode=longest:full
set wildmenu                  " menu has tab completion
let maplocalleader=','        " all my macros start with ,
set laststatus=2

"  searching
set incsearch                 " incremental search
set ignorecase                " search ignoring case
set hlsearch                  " highlight the search
set showmatch                 " show matching bracket
set diffopt=filler,iwhite     " ignore all whitespace and sync

"  backup
set backup
set backupdir=~/.vim_backup
set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo
"set viminfo='100,f1

" spelling
if v:version >= 700
  " Enable spell check for text files
  autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en
endif

" mappings
" toggle list mode
nmap <LocalLeader>tl :set list!<cr>
" toggle paste mode
nmap <LocalLeader>pp :set paste!<cr>

:fu FuncHaikuCheck()
	call matchadd('Search', '\%>80v.\+', -1) " line over 80 char
	call matchadd('Search', '^\s* \s*', -1)  " spaces instead of tabs
	call matchadd('Search', '\(for\|if\|select\|while\)(', -1)
		"missing space after control statement
	call matchadd('Search', '//\S', -1) " Missing space at comment start
	call matchadd('Search', '\w[,=>+\-*;]\w', -1)
		"operator without space around it (without false positive on
		"templated<type>)
	call matchadd('Search', '^[^#].*[^<]\zs\w*/\w', -1)
		"operator without space around it (without false positive on
		"#include <dir/file.h>)
	call matchadd('Search', '^[^/]\{2}.*\zs[^*][=/+\-< ]$', -1)
		"operator at end of line (without false positives on /* and */, nor
		"char*\nClass::method())
	call matchadd('Search', '^[^#].*\zs[^<]>$', -1)
		" > operator at end of line (without false positive on #include <file.h>)
	call matchadd('Search', '){', -1) " Missing space after method header
	call matchadd('Search', '}\n\s*else', -1) " Malformed else
	call matchadd('Search', '\s$', -1) "Spaces at end of line
	call matchadd('Search', ',\S', -1) " Missing space after comma
	call matchadd('Search', '^}\n\{1,2}\S', -1) " Less than 2 lines between functions
	call matchadd('Search', '^}\n\{4,}\S', -1) " More than 2 lines between functions
:endfu
