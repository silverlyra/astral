"
" statusline plane
"

scriptencoding utf-8

let s:special_filenames = {}
let s:special_filetypes = {'help': {'name': 'Help', 'filename': {-> expand('%:t')}}}

function! astral#plane#ui#statusline#enter(options) abort
  call astral#plugin#ui#('statusline')
  if get(a:options, 'tabline') ==# 'buffers'
    call astral#plugin#ui#('statusline_buftabs')
  endif
endfunction

function! astral#plane#ui#statusline#configure(options) abort
  let g:lightline = {
    \   'colorscheme': get(a:options, 'colorscheme', 'wombat'),
    \   'active': {
    \     'left': [['mode', 'paste'], ['readonly', 'filename']],
    \     'right': [['percent'], ['lineinfo'], ['filetype']]
    \   },
    \   'inactive': {
    \     'left': [['filename']],
    \     'right': [['percent']],
    \   },
    \   'tabline': {
    \     'left': [['tabs']],
    \     'right': [['close']],
    \   },
    \   'component_expand': {
    \     'inactive_filename': 'astral#plane#ui#statusline#inactive_filename'
    \   },
    \   'component_type': {
    \     'readonly': 'warning'
    \   },
    \   'component_function': {
    \     'mode': 'astral#plane#ui#statusline#mode',
    \     'filename': 'astral#plane#ui#statusline#filename',
    \     'readonly': 'astral#plane#ui#statusline#read_only',
    \     'filetype': 'astral#plane#ui#statusline#filetype'
    \   },
    \   'separator': {'left': '', 'right': ''},
    \   'subseparator': {'left': '', 'right': ''}
    \ }

  if get(a:options, 'tabline') ==# 'buffers'
    let g:lightline.tabline.left = [['buffers']]
    let g:lightline.component_expand.buffers = 'lightline#bufferline#buffers'
    let g:lightline.component_type.buffers = 'tabsel'

    let g:lightline#bufferline#unicode_symbols = 1
    let g:lightline#bufferline#min_buffer_count = 1
  endif
  if get(a:options, 'tabline_close', 1) ==# 0
    let g:lightline.tabline.right = []
  endif
endfunction

function! astral#plane#ui#statusline#def(name, impl, ...) abort
  let a:options = get(a:, 1, {})
  let type = get(a:options, 'type', '')

  let g:lightline.component_expand[a:name] = a:impl

  if strlen(type) > 0
    let g:lightline.component_type[a:name] = type
  endif
endfunction

function! astral#plane#ui#statusline#add(component, ...) abort
  let a:options = get(a:, 1, {})
  let dest = get(a:options, 'dest', 'active')
  let side = get(a:options, 'side', 'right')
  let priority = get(a:options, 'priority', 0)

  let target = get(g:lightline, dest)

  if side ==# 'left'
    if priority
      for i in range(len(l:target.left))
        if index(l:target.left[i], 'filename') >= 0
          call insert(l:target.left, a:component, i)
          break
        endif
      endfor
    else
      call add(l:target.left, a:component)
    endif
  elseif side ==# 'right'
    if priority
      for i in range(len(l:target.right))
        if index(l:target.right[i], 'filetype') >= 0
          call insert(l:target.right, a:component, i + 1)
          break
        endif
      endfor
    else
      call add(l:target.right, a:component)
    endif
  endif
endfunction

function! astral#plane#ui#statusline#def_special(name, match, ...) abort
  let a:options = get(a:, 1, {})

  let special = copy(a:options)
  let special.name = a:name

  if has_key(a:match, 'name')
    let s:special_filenames[a:match.name] = special
  elseif has_key(a:match, 'type')
    let s:special_filetypes[a:match.type] = special
  else
    throw 'statusline#def_special requires a filename or filetype to match'
  endif
endfunction

function! astral#plane#ui#statusline#special() abort
  return get(s:special_filenames, expand('%:t'), get(s:special_filetypes, &filetype, {}))
endfunction

function! astral#plane#ui#statusline#is_special() abort
  return len(astral#plane#ui#statusline#special()) > 0
endfunction

function! astral#plane#ui#statusline#mode() abort
  let special = astral#plane#ui#statusline#special()

  if has_key(special, 'mode')
    return type(special.mode) == type('') ? special.mode : call(special.mode, [])
  elseif has_key(special, 'name')
    return special.name
  else
    return lightline#mode()
  endif
endfunction

function! astral#plane#ui#statusline#filename() abort
  let special = astral#plane#ui#statusline#special()

  if has_key(special, 'filename')
    return call(special.filename, [])
  elseif has_key(special, 'name')
    return ''
  endif

  let filename = winwidth(0) > 70 ? expand('%') : expand('%:t')
  let modified = &modified ? ' +' : ''
  if filename ==# ''
    let filename = '[no name]'
  endif
  return fnamemodify(filename, ':~:.') . modified
endfunction

function! astral#plane#ui#statusline#inactive_filename() abort
  let filename = astral#plane#ui#statusline#filename()
  return strlen(filename) > 0 ? filename : astral#plane#ui#statusline#mode()
endfunction

function! astral#plane#ui#statusline#read_only() abort
  return &readonly && !astral#plane#ui#statusline#is_special() ? 'RO' : ''
endfunction

function! astral#plane#ui#statusline#filetype() abort
  let special = astral#plane#ui#statusline#special()
  if has_key(special, 'filetype')
    return call(special.filetype, [])
  elseif has_key(special, 'name')
    return ''
  endif

  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction
