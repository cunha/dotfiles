" Disable Netrw
" let loaded_netrwPlugin = 1

" NERDTree
let g:NERDTreeMapMenu='M'
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['\~$',
	\ '\.pyc$', '^__pycache__$']
autocmd FileType nerdtree setlocal nolist

" NERDCommenter
" let g:NERDTrimTrailingWhitespace = 1
" let g:NERDSpaceDelims = 1

let g:airline_theme = 'solarized'
let g:airline_powerline_fonts = 1
let g:airline_detect_spell = 1
" let g:airline_enable_fugitive = 0
" let g:airline_enable_syntastic = 0

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.whitespace = '☰'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.readonly = ''
let g:airline_symbols.spell = '§'

let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

let g:airline_extensions = ['quickfix', 'tabline', 'vimtex', 'whitespace',
	\ 'wordcount']
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline#extensions#wordcount#formatter#default#fmt = '%sw'
let g:airline#extensions#wordcount#formatter#default#fmt_short = '%sw'

let g:black_fast = 0
" let g:black_linelength = 99
let g:black_skip_string_normalization = 0
let g:black_virtualenv = '~/.vim/black'
" autocmd BufWritePre *.py execute ':Black'

" vim-lsp
if executable('clangd')
    augroup lsp_clangd
        autocmd!
        " autocmd FileType c setlocal omnifunc=lsp#complete
        " autocmd FileType cpp setlocal omnifunc=lsp#complete
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                    \ })
    augroup end
endif
" if executable('rls')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'rls',
"         \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
"         \ 'whitelist': ['rust'],
"         \ })
" endif

" clojure rainbow parens
let g:rainbow_active = 1
let g:rainbow_conf = {
      \  'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
      \  'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
      \  'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
      \  'separately': {
      \      '*': 0,
      \      'clojure': {},
      \  }
      \}

" configure clojure folding
let g:clojure_foldwords = "def,defn,defmacro,defmethod,defschema,defprotocol,defrecord"

" evaluate top level form
" au BufEnter *.clj nnoremap <buffer> cpt :Eval<CR>
" show last evaluation in temp file
" au BufEnter *.clj nnoremap <buffer> cpl :Last<CR>
