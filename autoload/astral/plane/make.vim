"
" building and linting plane
"

scriptencoding utf-8

function! astral#plane#make#enter(options) abort
  call astral#plugin#make#('core')
endfunction

function! astral#plane#make#configure(options) abort
  let mode = get(a:options, 'mode', 'nrw')
  let delay = get(a:options, 'delay', 500)

  call neomake#configure#automake(mode, delay)
  let g:neomake_error_sign = {'text': '✕', 'texthl': 'NeomakeErrorSign'}

  if get(a:options, 'autolist', 1)
    let g:neomake_open_list = 2
  endif

  call astral#plane#ui#statusline#def('errors', 'astral#plane#make#error_status', {'type': 'error'})
  call astral#plane#ui#statusline#def('warnings', 'astral#plane#make#warning_status', {'type': 'warning'})
  call astral#plane#ui#statusline#add(['errors', 'warnings'], {'side': 'right'})

  call astral#plane#ui#statusline#def('overall_errors', 'astral#plane#make#overall_error_status', {'type': 'error'})
  call astral#plane#ui#statusline#def('overall_warnings', 'astral#plane#make#overall_warning_status', {'type': 'warning'})
  call astral#plane#ui#statusline#add(['overall_errors', 'overall_warnings'], {'dest': 'tabline', 'side': 'right'})

  augroup statusline#plane#make
    autocmd!
    autocmd User NeomakeFinished nested call lightline#update()
  augroup END
endfunction

function! astral#plane#make#error_status() abort
  let l:count = get(s:buffer_counts(), 'E')
  return l:count ? '✕ ' . printf('%d', l:count) : ''
endfunction

function! astral#plane#make#warning_status() abort
  let l:count = get(s:buffer_counts(), 'W')
  return l:count ? '⚠ ' . printf('%d', l:count) : ''
endfunction

function! s:buffer_counts() abort
  return neomake#statusline#get_counts(bufnr('%'))
endfunction

function! astral#plane#make#overall_error_status() abort
  let l:count = get(s:overall_counts(), 'E')
  return l:count ? '✕ ' . printf('%d', l:count) : ''
endfunction

function! astral#plane#make#overall_warning_status() abort
  let l:count = get(s:overall_counts(), 'W')
  return l:count ? '⚠ ' . printf('%d', l:count) : ''
endfunction

function! s:overall_counts() abort
  let counts = {}

  for bufcounts in values(neomake#statusline#get_counts())
    for [t, c] in items(bufcounts)
      let counts[t] = get(counts, t) + c
    endfor
  endfor

  return counts
endfunction
