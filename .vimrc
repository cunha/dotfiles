set nocompatible
set runtimepath+=~/.vim/plugins/dein.vim/
"{{{
call dein#begin(expand('~/.cache/dein'))
call dein#add('/home/cunha/.vim/plugins/dein.vim')
call dein#add('/home/cunha/.config/zsh/fzf.git')
call dein#add('airblade/vim-gitgutter')
call dein#add('ConradIrwin/vim-bracketed-paste')
call dein#add('cunha/vim-colors-solarized')
call dein#add('christoomey/vim-tmux-navigator')
call dein#add('kshenoy/vim-signature')
call dein#add('haya14busa/vim-poweryank')
call dein#add('machakann/vim-sandwich')
call dein#add('moll/vim-bbye')
call dein#add('scrooloose/nerdtree')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-commentary')
call dein#add('unblevable/quick-scope')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
" call dein#add('godlygeek/tabular')
" call dein#add('plasticboy/vim-markdown')
" call dein#add('prabirshrestha/async.vim')
" call dein#add('prabirshrestha/vim-lsp')
" call dein#add('scrooloose/syntastic')
" call dein#add('tpope/vim-repeat')
" call dein#add('tpope/vim-surround')
" Go:
" call dein#add('fatih/vim-go')
" LaTeX:
" call dein#add('lervag/vimtex')
" C:
" call dein#add('vim-scripts/a.vim')
" call dein#add('rhysd/vim-clang-format')
" call dein#add('Valloric/YouCompleteMe')
" call dein#add('octol/vim-cpp-enhanced-highlight')
" Rust:
" call dein#add('racer-rust/vim-racer')
" call dein#add('rust-lang/rust.vim')
" Clojure:
" call dein#add('luochen1990/rainbow')
" call dein#add('gberenfield/cljfold.vim')
" call dein#add('tpope/vim-fireplace')
" call dein#add('guns/vim-sexp')
" Python:
" call dein#add('ambv/black')
call dein#end()

" let g:lsp_signs_enabled = 1
" let g:lsp_diagnostics_echo_cursor = 1
" let g:lsp_signs_error = {'text': '✗'}
" let g:lsp_signs_warning = {'text': '‼', 'icon': '/path/to/some/icon'} " icons require GUI
" let g:lsp_signs_hint = {'icon': '/path/to/some/other/icon'} " icons require GUI
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')



source ~/.vim/settings/plugins.vim
let g:tmux_navigator_no_mappings = 1
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" let g:racer_experimental_completer = 1
" let g:racer_cmd = "/home/cunha/.cargo/bin/racer"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
" let g:yankring_history_dir = '$HOME/.cache/'

" call dein#add('Valloric/YouCompleteMe')
" call dein#add('majutsushi/tagbar')
" call dein#add('junegunn/vim-easy-align')
" call dein#add('junegunn/vim-easy-align')
" }}}

" scripts to check out {{{
" gundo
" NERDCommenter
" jedi-vim
" }}}

filetype on
filetype plugin on
filetype indent on
let mapleader = ";"
let maplocalleader = ","

" file management {{{
set hidden          " stop asking for :w all the time
set autowrite       " stop asking for :w all the time
set nobackup        " do not fill directories with crap
set updatecount=10  " write swap file after 10 updates
set updatetime=180  " write swap file after 180 seconds
" }}}

" editing {{{
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
" }}}

" make the status line look good (also, airline) {{{
set ruler
set cmdheight=1
set laststatus=2
set statusline=%<%n\ %f\ %y%h%m%r%=%-14.(%l,%c%V%)\ %P
" }}}

" save undo history between edits of the same file {{{
set undofile
set undodir=~/.vim/undo
set undoreload=10000
" }}}

" interface configuration {{{
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
" }}}

set wildmenu " {{{
set wildmode=list:longest
set wildignore+=.hg,.git,.svn                     " Version control
set wildignore+=*.aux,*.out,*.toc                 " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg    " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest  " compiled object files
set wildignore+=*.luac,*.pyc                      " byte code
set wildignore+=*.spl                             " compiled spelling word lists
set wildignore+=*.sw?                             " Vim swap files
set wildignore+=*.DS_Store                        " OSX bullshit
" }}}

" folding {{{
set foldmethod=marker
set foldminlines=0
set foldenable
set foldcolumn=3
" }}}

source ~/.vim/settings/colors.vim
source ~/.vim/settings/cscope.vim
source ~/.vim/settings/file-types.vim
source ~/.vim/settings/mappings.vim

autocmd VimLeave * call system("xsel -ib", getreg('+'))
autocmd CompleteDone * pclose

set secure
set exrc

function! SetClass()
	syntax off
	set nolist
	set colorcolumn=400
endfunction
