"
" fuzzy finder plugins
"

function! astral#plugin#find#(name) abort
  call eval(printf('g:astral#plugin#find#%s.use()', a:name))
endfunction

let astral#plugin#find#core = astral#plugin#new('silverlyra/ish')
