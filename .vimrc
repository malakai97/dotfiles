set history=700

" Read in changes to the file immediately
set autoread

" Fix backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Highlight search results
set hlsearch

" Make search act like modern browsers
set incsearch

" Match brackets
set showmatch
set mat=2

" Don't make sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Enable syntax highlighting
syntax enable

" Default to utf8, assume 'nix
set encoding=utf8
set ffs=unix,dos,mac

" Turn off backup, it just clutters git
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

" I'm smort
set smarttab

" 2 spaces
set shiftwidth=2
set tabstop=2

" Always show the status line
set laststatus=2

" Line numbers
set number

" Attempt intelligence
set ai
set si

" Wrap 
set wrap
