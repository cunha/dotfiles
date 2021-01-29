augroup ftplugin_filetypes
    autocmd!
    autocmd BufNewFile,BufRead *plot setlocal filetype=gnuplot
    autocmd BufNewFile,BufRead *cunha_wp_wordpress* setlocal filetype=markdown
    autocmd BufNewFile,BufRead mail.google.com* setlocal filetype=mail
    autocmd BufNewFile,BufRead *mail setlocal filetype=mail
augroup end

augroup ftplugin_clang
    autocmd!
    autocmd FileType c setlocal cindent
    autocmd FileType c setlocal noexpandtab
    autocmd FileType c setlocal tabstop=8 softtabstop=8 shiftwidth=8
    autocmd FileType c imap <buffer> <localleader>logea logea(__FILE__, __LINE__, NULL);
    autocmd FileType cpp setlocal cindent
    autocmd FileType cpp setlocal expandtab
    autocmd FileType cpp setlocal tabstop=2 softtabstop=2 shiftwidth=2
    " autocmd FileType c setlocal omnifunc=lsp#complete
    " autocmd FileType cpp setlocal omnifunc=lsp#complete
augroup end

augroup ftplugin_html
    autocmd!
    autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    autocmd FileType html vmap <buffer> <localleader>p "vc<lt>p><C-R>v</p><ESC>
    autocmd FileType html nmap <buffer> <localleader>i viWB<ESC>i<lt>i><ESC>Ea</i><ESC>
    autocmd FileType html nmap <buffer> <localleader>b viWB<ESC>i<lt>b><ESC>Ea</b><ESC>
augroup end

augroup ftplugin_htmldjango
    autocmd!
    autocmd FileType htmldjango setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    autocmd FileType htmldjango vmap <buffer> <localleader>p "vc<lt>p><C-R>v</p><ESC>
    autocmd FileType htmldjango nmap <buffer> <localleader>i viWB<ESC>i<lt>i><ESC>Ea</i><ESC>
    autocmd FileType htmldjango nmap <buffer> <localleader>b viWB<ESC>i<lt>b><ESC>Ea</b><ESC>
augroup end


let g:is_posix = 1
let g:sh_noisk = 1 " please, don't fuck with me
augroup ftplugin_shellscript
    autocmd!
    autocmd FileType sh setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
    autocmd FileType sh setlocal path+=~/bin/ include=^\\s*\\.
    autocmd FileType sh setlocal errorformat=%f:%l:%m makeprg=shellcheck\ --format=gcc\ %
augroup end

augroup ftplugin_vim
    autocmd!
    autocmd FileType vim setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
augroup end

let python_highlight_all = 1
let python_slow_sync = 1
augroup ftplugin_pythonlang
    autocmd!
    autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
    autocmd FileType python setlocal errorformat=%f:%l:%m makeprg=python3\ -m\ pylint\ %
    " autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType python nnoremap <buffer> <localleader>3 :set makeprg=python3\ -m\ pylint\ %
    autocmd FileType python nnoremap <buffer> <localleader>2 :set makeprg=python2\ -m\ pylint\ %
augroup end

augroup ftplugin_rustlang
    autocmd!
    autocmd FileType rust setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
    autocmd FileType rust let g:syntastic_rust_checkers = ['cargo']
    " autocmd FileType rust setlocal omnifunc=lsp#complete
augroup end

augroup ftplugin_text
    autocmd!
    autocmd FileType mail setlocal textwidth=68 spell foldmethod=expr
    autocmd FileType mail setlocal foldexpr=strlen(substitute(substitute(getline(v:lnum),'\\s','',\"g\"),'[^>].*','',''))
    autocmd FileType text setlocal textwidth=68 spell
    autocmd FileType gitcommit setlocal textwidth=68
    " autocmd FileType markdown setlocal textwidth=68 tabstop=2 softtabstop=2 shiftwidth=2 expandtab spell
    autocmd FileType markdown setlocal textwidth=72 tabstop=2 softtabstop=2 shiftwidth=2 expandtab spell
    autocmd FileType markdown setlocal comments=fb:>,fb:*,fb:+,fb:-
    autocmd FileType xml,yaml,json setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
augroup end

let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_anchorexpr = "'{#'.v:anchor.'}'"

let g:tex_flavor = "latex"
let g:tex_no_error = 0
let g:tex_indent_items = 0
let g:tex_indent_brace = 0

let g:vimtex_view_method = 'zathura'
" let g:vimtex_view_general_viewer = 'evince'
let g:vimtex_quickfix_open_on_warning = 0

let g:vimtex_format_enabled = 0
let g:vimtex_indent_enabled = 0
let g:vimtex_indent_bib_enabled = 1
let g:vimtex_indent_ignored_envs = ['abstract', 'document', 'figure', 'table',
    \ 'tabular', 'itemize', 'enumerate', 'description', 'verbatim',
    \ 'comment', 'abstract']

let g:vimtex_toc_config = {'layer_status': { 'content': 1, 'label': 0, 'todo': 0, 'include': 0 }}

augroup ftplugin_latex
    autocmd!
    autocmd FileType tex setlocal nocopyindent noautoindent nosmartindent nocindent
    autocmd FileType tex setlocal spell textwidth=68 expandtab
    autocmd FileType tex nmap <buffer> <localleader>em viWB<ESC>i\emph{<ESC>ea}<ESC>
    autocmd FileType tex nmap <buffer> <localleader>tt viWB<ESC>i\texttt{<ESC>ea}<ESC>
    autocmd FileType tex nmap <buffer> <localleader>sc viWB<ESC>i\textsc{<ESC>ea}<ESC>
    autocmd FileType tex nmap <buffer> <localleader>bf viWB<ESC>i\textbf{<ESC>ea}<ESC>
    autocmd FileType tex nmap <buffer> <localleader>sf viWB<ESC>i\textsf{<ESC>ea}<ESC>
    autocmd FileType tex nmap <buffer> <localleader>ve viWB<ESC>i\verb+<ESC>ea+<ESC>
    autocmd FileType tex nmap <buffer> <localleader>ssf viWB<ESC>i\ssf{<ESC>mlvE:s/\%V_/\\_/g<RETURN>`lEa}<ESC>
    " autocmd FileType tex let g:vimtex_toc_config['layers'] = [ 'content' ]
    " autocmd FileType tex nmap <leader>q gwap:wa<RETURN>:make<RETURN>
augroup end

augroup ftplugin_java
    autocmd!
    autocmd FileType java setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd FileType java setlocal nowrap
    autocmd FileType java inoremap <buffer> <c-@> <c-x><c-u>
    autocmd FileType java nnoremap <buffer> <localleader>r :JavaRename 
    autocmd FileType java nnoremap <buffer> <localleader>i :JavaImportOrganize<cr>
    autocmd FileType java nnoremap <buffer> <localleader>f :%JavaFormat<cr>
    autocmd FileType java nnoremap <buffer> <localleader>c :JavaCorrect<cr>
    autocmd FileType java nnoremap <buffer> <localleader>n :JavaNew<cr>
    autocmd FileType java nnoremap <buffer> <localleader>d :JavaDocSearch -x declarations<cr>
augroup end



autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> <leader>.. :edit %:h<CR> |
  \ endif

autocmd BufReadPost fugitive://* set bufhidden=delete
