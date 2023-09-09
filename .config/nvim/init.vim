set nocompatible

call plug#begin()
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'ggandor/leap.nvim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-sandwich'
Plug 'neovim/nvim-lspconfig'
Plug 'ojroques/vim-oscyank', {'branch': 'main'}
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
call plug#end()

" set runtimepath+=~/.vim/plugins/dein.vim/
" call dein#begin(expand('~/.cache/dein'))
" call dein#add('/home/cunha/.config/zsh/fzf.git')
" call dein#add('/home/cunha/.cache/dein/repos/github.com/Shougo/dein.vim')
" call dein#add('airblade/vim-gitgutter')
" call dein#add('ConradIrwin/vim-bracketed-paste')
" call dein#add('cunha/vim-colors-solarized')
" call dein#add('altercation/vim-colors-solarized')
" call dein#add('christoomey/vim-tmux-navigator')
" call dein#add('kshenoy/vim-signature')
" call dein#add('haya14busa/vim-poweryank')
" call dein#add('machakann/vim-sandwich')
" call dein#add('moll/vim-bbye')
" call dein#add('scrooloose/nerdtree')
" call dein#add('srcery-colors/srcery-vim')
" call dein#add('tpope/vim-fugitive')
" call dein#add('tpope/vim-commentary')
" call dein#add('unblevable/quick-scope')
" call dein#add('vim-airline/vim-airline')
" call dein#add('vim-airline/vim-airline-themes')
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
" call dein#end()

" let g:lsp_signs_enabled = 1
" let g:lsp_diagnostics_echo_cursor = 1
" let g:lsp_signs_error = {'text': '✗'}
" let g:lsp_signs_warning = {'text': '‼', 'icon': '/path/to/some/icon'} " icons require GUI
" let g:lsp_signs_hint = {'icon': '/path/to/some/other/icon'} " icons require GUI
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')

exec 'source ' . stdpath('config') . '/plugins.vim'
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
colorscheme catppuccin-frappe

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
set viminfo='100,f1,:10,/10,n$HOME/.cache/nviminfo
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
" set ttymouse=xterm
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

" source ~/.vim/settings/colors.vim
" source ~/.vim/settings/cscope.vim
" source ~/.vim/settings/file-types.vim
" source ~/.vim/settings/mappings.vim

autocmd VimLeave * call system("xsel -ib", getreg('+'))
autocmd CompleteDone * pclose

set secure
set exrc

function! SetClass()
	syntax off
	set nolist
	set colorcolumn=400
endfunction

" let g:lsp_signs_enabled = 1
" let g:lsp_diagnostics_echo_cursor = 1
" let g:lsp_signs_error = {'text': '✗'}
" let g:lsp_signs_warning = {'text': '‼', 'icon': '/path/to/some/icon'} " icons require GUI
" let g:lsp_signs_hint = {'icon': '/path/to/some/other/icon'} " icons require GUI
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')

nnoremap <C-k> :bprev<cr>
nnoremap <C-j> :bnext<cr>
nnoremap <C-b> :Bdelete<cr>
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

nnoremap <leader>ee :FZF<cr>
nnoremap <leader>ed :FZF %:h<cr>
nnoremap <leader>eh :FZF ~/<cr>
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>f :NERDTreeFocus<cr>

nnoremap <leader>x :!./%<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>W :w !sudo tee % &> /dev/null<cr>
nnoremap <leader>m :w<cr>:make<cr>

vnoremap <leader>y :OSCYank<cr>
nnoremap <leader>y <Plug>OSCYank
noremap <leader>p "+p

" delete duplicated spaces, delete trailing spaces:
noremap <leader>dds :%s/\([.]\)<space><space>/\1<space>/g<cr>
noremap <leader>dts :%s/\s\+$//<cr>
" turn on spell checking:
noremap <leader>sen :setlocal spell<cr>:setlocal spelllang=en_us<cr>
noremap <leader>spt :setlocal spell<cr>:setlocal spelllang=pt_br<cr>
noremap <leader>soff :setlocal nospell<cr>

nnoremap <leader>date "=strftime("%Y%m%d.%H%M")<cr>P
inoremap <leader>date <C-R>=strftime("%Y%m%d.%H%M")<cr>
nnoremap <leader>sdate "=strftime("%Y-%m-%d")<cr>P
inoremap <leader>sdate <C-R>=strftime("%Y-%m-%d")<cr>

inoremap <C-h> <C-w>
inoremap <C-w> <nop>
inoremap <A-Del> <C-O>dW
inoremap <C-\> <C-O>b
inoremap <Esc>\ <C-O>B
" inoremap <Esc>h <Left>
" inoremap <Esc>k <Up>
" inoremap <Esc>j <Down>
" inoremap <Esc>l <Right>


if &term =~ "rxvt"
    inoremap [3^ <C-O>dw
    inoremap [33~ <C-O>dB
    set <S-F11>=[23$
    set <S-F12>=[24$
elseif &term =~ "tmux"
    " Tmux on kitty is just like xterm
    inoremap [3;3~ <C-O>dw
    inoremap [3;5~ <C-O>dW
    inoremap  <C-O>db<C-O>x
    inoremap  <C-O>dB<C-O>x
    inoremap [1;5D <C-O>B
    inoremap [1;3D <C-O>b
    inoremap [1;5C <C-O>W
    inoremap [1;3C <C-O>w
    " Tmux on urxvt:
    " inoremap [3;5~ <C-O>dw
    " inoremap [18;2~ <C-O>db
    inoremap  <C-O>dB<C-O>x
    set <S-F11>=[23;2~
    set <S-F12>=[24;2~
elseif &term =~ "xterm"
    inoremap [3;3~ <C-O>dw
    inoremap [3;5~ <C-O>dW
    inoremap  <C-O>db<C-O>x
    inoremap  <C-O>dB<C-O>x
    inoremap [1;5D <C-O>B
    inoremap [1;3D <C-O>b
    inoremap [1;5C <C-O>W
    inoremap [1;3C <C-O>w
    set <S-F11>=[23;2~
    set <S-F12>=[24;2~
endif

nnoremap <silent> <S-F11> :TmuxNavigateLeft<cr>
nnoremap <silent> <S-F12> :TmuxNavigateRight<cr>
" nnoremap <silent> <C-a>h :TmuxNavigateLeft<cr>
nnoremap <silent> <C-a>j :TmuxNavigateDown<cr>
nnoremap <silent> <C-a>k :TmuxNavigateUp<cr>
" nnoremap <silent> <C-a>l :TmuxNavigateRight<cr>

nnoremap <leader>ev :edit ~/.vim/settings/plugins.vim<cr>:edit ~/.vim/settings/mappings.vim<cr>:edit ~/.vim/settings/file-types.vim<cr>:edit $MYVIMRC<cr>
nnoremap <leader>es :source $MYVIMRC<cr>

lua require('leap').add_default_mappings()

" map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
" \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
" \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
