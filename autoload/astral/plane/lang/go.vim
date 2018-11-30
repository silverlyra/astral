"
" golang plane
"

function! astral#plane#lang#go#enter(options) abort
  call g:astral#plugin#lang#go.use()

  " TODO: how to make this more selective
  call g:astral#plugin#completion#go.use()
endfunction

function! astral#plane#lang#go#configure(options) abort
  if has_key(a:options, 'gocode')
    let g:deoplete#sources#go#gocode_binary = fnamemodify(a:options.gocode, ':p')
  endif
endfunction

