"
" fuzzy-finding plane
"

scriptencoding utf-8

function! astral#plane#find#enter(options) abort
  call astral#plugin#find#('core')
endfunction

function! astral#plane#find#configure(options) abort
  call astral#plane#ui#statusline#def_special('Ish',
        \ {'type': 'ish'},
        \ {'filename': function('s:status')})
endfunction

function! s:status() abort
  let status = ish#status()
  if !status.open
    return ''
  endif

  let label = status.source
  if has_key(status, 'root')
    let label .= ' ' . status.root
  endif

  return label
endfunction
