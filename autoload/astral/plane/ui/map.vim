"
" which-key plane
"

scriptencoding utf-8

function! astral#plane#ui#map#enter(options) abort
  call astral#plugin#ui#('map')
endfunction

function! astral#plane#ui#map#configure(options) abort
  nnoremap <silent> <leader> :<c-u>WhichKey ','<CR>
  vnoremap <silent> <leader> :<c-u>WhichKeyVisual ','<CR>
endfunction
