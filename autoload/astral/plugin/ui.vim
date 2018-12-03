"
" user interface plugins
"

function! astral#plugin#ui#(name) abort
  call eval(printf('g:astral#plugin#ui#%s.use()', a:name))
endfunction

let astral#plugin#ui#statusline = astral#plugin#new('itchyny/lightline.vim')
let astral#plugin#ui#tree = astral#plugin#new('scrooloose/nerdtree')
let astral#plugin#ui#tree_syntax = astral#plugin#new('tiagofumo/vim-nerdtree-syntax-highlight')
