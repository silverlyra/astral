"
" language support plugins
"

function! astral#plugin#lang#(name) abort
  call eval(printf('g:astral#plugin#lang#%s.use()', a:name))
endfunction

let astral#plugin#lang#go = astral#plugin#new('fatih/vim-go')

let astral#plugin#lang#typescript = astral#plugin#new('mhartington/nvim-typescript',
      \{'do': './install.sh'})
let astral#plugin#lang#typescript_syntax = astral#plugin#new('HerringtonDarkholme/yats.vim')
