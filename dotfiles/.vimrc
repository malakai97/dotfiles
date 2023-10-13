" Enable Magic---------------------------------------------------

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
" Plugin 'NLKNguyen/papercolor-theme'
" Plugin 'sonph/onehalf', {'rtp': 'vim/'}
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-ruby/vim-ruby'
Plugin 'townk/vim-autoclose'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-commentary'
Plugin 'airblade/vim-gitgutter'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'preservim/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

" Confirmed not broken in WSL
Plugin 'nathanaelkane/vim-indent-guides'

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
" The problem with these is I am then unable to scroll up or down
" through empty lines. That's probably fixable but meh.

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
set colorcolumn=90              " column to demark long lines
set autoread                    " Read in changes immediately
set encoding=utf8               " default to utf8
set ffs=unix,dos,mac            " assume 'nix
set number                      " line numbers
" set relativenumber              " line numbers relative to current
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

" Rebinds -----------------------------------------------------
let mapleader=","

" Whitespace  --------------------------------------------------
autocmd BufEnter * EnableStripWhitespaceOnSave
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
" Prevents it from being overrided by later colorscheme commands
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
"highlight ExtraWhitespace ctermbg=red guibg=red
" less obtrusive version
" highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
" another option
" highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
" match ExtraWhitespace /\t/ " this thing is too laggy

let g:better_whitespace_enabled = 1
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0

" GitGutter-----------------------------------------------------
set signcolumn=yes

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


" Colors-----------------------------------------------------
syntax enable                     " enable syntax highlighting
set t_Co=256                      " enable 256 colors (but probably do nothing)
set t_ut=                         " disable background color erase
if exists('+termguicolors')       " enable true colors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set background=dark               " dark
let g:gruvbox=1          " enable italics
colorscheme gruvbox               " use plugin


" Status Line: Airline
set laststatus=2                  " always display
let g:airline#extentions#tabline#enabled = 1
let g:airline_theme='gruvbox'

" fzf -------------------------------------------------------------
set rtp+=fzf
nnoremap <C-f> :Files<CR>
nnoremap <C-F> :GFiles<CR>
" nnoremap <Leader>f :Files<CR>
" nnoremap <Leader>F :GFiles<CR>

" nerdree  --------------------------------------------------------
nnoremap <Leader>d :NERDTreeToggle<CR>
nnoremap <Leader>e :NERDTreeFind<CR>
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
let g:NERDTreeGitStatusConcealBrackets = 1


" ripgrep  --------------------------------------------------------
set grepprg=rg\ --vimgrep
nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>

" vim-ruby settings -----------------------------------------------
let g:ruby_indent_block_style = 'do'  " Always indent a 'do' even if not expression start
let g:ruby_indent_assignment_style = 'variable' " No giant indents on assignment

" Indent Guides-----------------------------------------------------
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
