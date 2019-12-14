" https://github.com/drduh/config/blob/master/vimrc
" https://vimhelp.org/vim_faq.txt.html
set nocompatible
filetype plugin indent on
syntax on
noremap ;               :
noremap <C-a>           <Home>
noremap <C-e>           <End>
noremap <C-h>           :tabNext<cr>
noremap <C-l>           :tabnext<cr>
noremap <C-n>           :tabnew<cr>
noremap <space><cr>     :nohlsearch<cr>
noremap <space><del>    :quit!<cr>
noremap <space><space>  :set list!<cr>
noremap <space>exec     :!./%<cr>
noremap <space>ws       :%s/\s\+$//<cr>
noremap <space>s        :setlocal spell!<cr>
set autoindent                  " copy indent from current line
set cursorline                  " underline cursor line
set expandtab                   " use spaces instead of tabs
set gdefault                    " use g flag to search/replace
set hidden                      " switch buffers without saving
set hlsearch                    " highlight searches
set ignorecase                  " ignore case when searching
set incsearch                   " dynamic pattern highlighting
set lazyredraw                  " no re-draw on untyped commands
set linebreak                   " break on breakat chars
set magic                       " magic search strings
set noeol                       " no newline at eof
set noerrorbells                " disable error bells
set nostartofline               " do not reset cursor to line start when moving
set number                      " enable line numbers
set paste                       " always use paste mode
set relativenumber              " use line numbers relative to cursor
set showcmd                     " show partial command as it is typed
set showmatch                   " show matching brackets
set showmode                    " show current mode
set smartcase                   " do not ignore capital letter search
set title                       " set window title
set ttyfast                     " optimize for fast terminal connections
set wildmenu                    " enhanced completion
set wrap                        " wrap lines
set backspace   =2              " intuitive backspacing in insert mode
set cmdheight   =2              " never prompt for enter or command
set encoding    =utf-8 nobomb   " use utf-8 wo bom
set history     =200            " line history
set laststatus  =2              " always show status line
set scrolloff   =3              " scroll 3 lines before horizontal border
set shiftwidth  =2              " set tab to 2 spaces
set shortmess   =atsI           " mute intro message
set softtabstop =2              " make tabs as wide as two spaces
set tabpagemax  =2              " maximum 2 tabs
set tabstop     =2              " make tabs as wide as two spaces
set updatetime  =2000           " write every 2 seconds
set backupdir   =~/.vim/backup  " backup
set directory   =~/.vim/swap    " swap
set undodir     =~/.vim/undo    " undo
set statusline  =               " set status line
set statusline +=\ 0x%04B\ %*   " character under cursor
set statusline +=%#LineNr#%=    " spacer
set statusline +=\ %F           " file path
set statusline +=\%m\ %*        " file mode
set statusline +=\ %{WC()}\     " number of words
set statusline +=\%l/%L\        " number of lines
set viminfo     =""             " disable viminfo
"set viminfo     ='10            " edited files
"set viminfo    +=/10            " pattern items
"set viminfo    +=n~/.vim/info   " viminfo file name
let g:wc        =''
function WC()
  return g:wc
endfunction
function UpdateWordCount()
  let lnum=1
  let n=0
  while lnum<=line('$')
    let lnum=lnum+1
    let n=n+len(split(getline(lnum)))
  endwhile
  let g:wc=n
endfunction
augroup WordCounter
  au! CursorHold,CursorHoldI * call UpdateWordCount()
augroup END
colorscheme slate
hi Normal ctermfg=14 ctermbg=8
hi LineNr ctermfg=10 ctermbg=0
hi Comment ctermfg=9 ctermbg=0
hi StatusLine ctermfg=0 ctermbg=3
hi clear SpellBad
hi SpellBad ctermbg=10
