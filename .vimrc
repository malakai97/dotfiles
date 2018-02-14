" Enable Magic---------------------------------------------------

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-ruby/vim-ruby'
Plugin 'townk/vim-autoclose'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-commentary'
call vundle#end()
filetype plugin indent on


" Search --------------------------------------------------------
" disable vim-specific search regex by inserting \v
nnoremap / /\v
vnoremap / /\v
" // makes it easy to search currently selected text, apparently
"vnoremap // y/<c-r>"<cr>
set ignorecase                  " ignore case
set smartcase                   " unless we mix case
set gdefault                    " global search by default
set hls                         " highlight search as we type
set incsearch                   " move cursor to next search match
set showmatch                   " works with above two


" Disable F1------------------------------------------------------
inoremap <F1> <ESC>
vnoremap <F1> <ESC>
nnoremap <F1> <ESC>


" Sounds ---------------------------------------------------------
set noerrorbells                " shhh
set novisualbell                " shhh
set t_vb=                       " shh?
set tm=500


" Cripple our non-vim movement----------------------------------------
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Navigation  ---------------------------------------------------------
" nnoremap j gj                   " by screen line, not file line
" nnoremap k gk                   " by screen line, not file line
"

" Smart indent when entering insert mode on empty lines --------------
function! IndentWithI()
  if len(getline('.')) == 0
    return "\"_cc"
  else
    return "i"
  endif
endfunction
nnoremap <expr> i IndentWithI()


" Quality of Life ----------------------------------------------------
set backspace=eol,start,indent  " Fix backspace
set whichwrap+=<,>,h,l          " Wrap cursor movements
set wrap                        " wrap text visually
set colorcolumn=100             " column to demark long lines
set autoread                    " Read in changes immediately
set encoding=utf8               " default to utf8
set ffs=unix,dos,mac            " assume 'nix
set number                      " line numbers
set relativenumber              " line numbers relative to current
set ruler                       " more line info
set history=700
" set shell=bash
set modelines=0                 " dodge some security issues
set autowriteall                " save on buffer switch (instead of complaining)


" Backup -------------------------------------------------------
" Turn off backup, it just clutters git
set nobackup
set nowb
set noswapfile
" set directory^=$HOME/.vim/swp//


" Tabs ----------------------------------------------------------
set expandtab                   " use spaces
set smarttab                    " be smort
set shiftwidth=2                " 2 spaces
set tabstop=2                   " 2 spaces!
set softtabstop=2
set autoindent                  " enable automatic indentation
set smartindent                 " does the right thing


" Whitespace  --------------------------------------------------
autocmd BufEnter * EnableStripWhitespaceOnSave


" Buffers ------------------------------------------------------
"set viminfo^=%                  " Keep list of last opened buffers
"set hidden                      " Allow hiding buffers
" Close current buffer without closing window
"command! Bd :bp<bar>bd#


" Project Management ---------------------------------------------
" store sessions information, then declares a function to be
" called on close where it will try to save it. Only works if the
" file exists, to avoid clutter.
"set sessionoptions=blank,buffers,curdir,resize,winpos,winsize
"au VimLeave * call SaveVimProject()
"function! SaveVimProject()
"  if filereadable("./project.vim")
"    mksession! Project.vim
"  endif
"endfunction


" Finding Files: Ctrlp--------------------------------------------
" find files by fuzzy path
" search opened and other files
"let g:ctrlp_cmd = 'CtrlPMixed'
"let g:ctrlp_working_path_mode = 0 " disable working path because we use the project thing
"let g:ctrlp_max_files=0           " no idea
let g:ctrlp_custom_ignore = '__pycache__\|node_modules\|.bundle' " ignore these dirs
" fuzzy searching in a file
map \ :CtrlPLine<cr>


" Colors-----------------------------------------------------
syntax enable                     " enable syntax highlighting
set background=dark               " dark
let g:grubbox_italic=1            " enable italics
colorscheme gruvbox               " use plugin


" Status Line: Airline
set laststatus=2                  " always display
let g:airline#extentions#tabline#enabled = 1


" vim-ruby settings -----------------------------------------------
let g:ruby_indent_block_style = 'do'  " Always indent a 'do' even if not expression start
let g:ruby_indent_assignment_style = 'variable' " No giant indents on assignment



