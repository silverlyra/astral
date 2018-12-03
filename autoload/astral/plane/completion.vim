"
" auto-completion plane
"

function! astral#plane#completion#enter(options) abort
  call astral#plugin#completion#('core')
endfunction

function! astral#plane#completion#configure(options) abort
  call deoplete#enable()

  inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
  inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
endfunction
