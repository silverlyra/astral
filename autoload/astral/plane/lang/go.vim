"
" golang plane
"

function! astral#plane#lang#go#enter(options) abort
  call g:astral#plugin#lang#('go')

  " TODO: how to make this more selective
  call g:astral#plugin#completion#('go')
endfunction

function! astral#plane#lang#go#configure(options) abort
  if has_key(a:options, 'gocode')
    let g:deoplete#sources#go#gocode_binary = fnamemodify(a:options.gocode, ':p')
  endif

  " TODO: only set this if the `make` plane is enabled
  let g:go_fmt_fail_silently = 1
endfunction

