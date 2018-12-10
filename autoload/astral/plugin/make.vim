"
" building and linting plugins
"

function! astral#plugin#make#(name) abort
  call eval(printf('g:astral#plugin#make#%s.use()', a:name))
endfunction

let astral#plugin#make#core = astral#plugin#new('neomake/neomake')
