" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
" Italo Cunha       cunha@dcc.ufmg.br               2016/10/31

if has("cscope")
    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " search cscope first; set to 1 if you want to search ctags first
    set cscopetagorder=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    endif

    " show msg when any other cscope db added
    set cscopeverbose

    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls

    " All of the maps involving the <cfile> macro use '^<cfile>$':
    " this is so that searches over '#include <time.h>" return only
    " references to 'time.h', and not 'sys/time.h', etc. (by default
    " cscope will return all files that contain 'time.h' as part of
    " their name).

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

    "nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    "nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    "nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>

    "nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    "nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    "nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
endif


