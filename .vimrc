set nocompatible

filetype on
filetype plugin on
filetype indent on
let mapleader = ";"
let maplocalleader = ","

" file management
set hidden          " stop asking for :w all the time
set autowrite       " stop asking for :w all the time
set nobackup        " do not fill directories with crap
set updatecount=10  " write swap file after 10 updates
set updatetime=180  " write swap file after 180 seconds

" editing
set wrap
set breakindent       " indent wrapped lines
set linebreak         " break on sensible characters (breakat)
set showmatch
set incsearch
set history=1000
set viminfo='100,f1,:10,/10,n$HOME/.cache/viminfo
set autoindent
set nosmartindent
set joinspaces
set formatoptions=tc  " format according to text-width
set formatoptions+=q  " allow gq
set formatoptions+=1  " do not break before one-letter words
set formatoptions+=j  " remove comment leader when joining lines
set formatoptions+=n  " format lists
set formatoptions+=b  " smarter handling of long lines
set formatlistpat=^\\s*\\d\\+[\\]:.)}]\\s\\+\\\\|^\\s*[-*+]\\s\\+\\\\|^\\s*(\\a)\\s\\+
set printoptions=formfeed:y  " use ^L to break pages

" make the status line look good (also, airline)
set ruler
set cmdheight=1
set laststatus=2
set statusline=%<%n\ %f\ %y%h%m%r%=%-14.(%l,%c%V%)\ %P

" save undo history between edits of the same file
set undofile
set undodir=~/.vim/undo
set undoreload=10000

" interface configuration
set noshowmode
set notitle
set number
set nohls
set smartcase
set cursorline
set scrolloff=3
set scroll=5
set colorcolumn=80
set t_Co=16
set list
set listchars=tab:»\ ,eol:¬,trail:·,extends:<,precedes:>
set backspace=2
set mouse=a
set ttymouse=xterm
set timeoutlen=250
set ttimeoutlen=0
set complete=.,w,b,u,t,i " buffers, tags, included files
set completeopt+=longest

set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn                     " Version control
set wildignore+=*.aux,*.out,*.toc                 " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg    " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest  " compiled object files
set wildignore+=*.luac,*.pyc                      " byte code
set wildignore+=*.spl                             " compiled spelling word lists
set wildignore+=*.sw?                             " Vim swap files
set wildignore+=*.DS_Store                        " OSX bullshit

" folding
set foldmethod=marker
set foldminlines=0
set foldenable
set foldcolumn=3

autocmd CompleteDone * pclose

set secure
set exrc

function! SetClass()
	syntax off
	set nolist
	set colorcolumn=400
endfunction
