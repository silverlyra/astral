"
"                  ______     ______     ______   ______     ______     __
"                 /\  __ \   /\  ___\   /\__  _\ /\  == \   /\  __ \   /\ \
"                 \ \  __ \  \ \___  \  \/_/\ \/ \ \  __<   \ \  __ \  \ \ \____
"                  \ \_\ \_\  \/\_____\    \ \_\  \ \_\ \_\  \ \_\ \_\  \ \_____\
"                   \/_/\/_/   \/_____/     \/_/   \/_/ /_/   \/_/\/_/   \/_____/
"
"                                      vim on a higher plane
"

let s:planes = []

function! astral#begin() abort
  call s:ensure_paths()
  call plug#begin(g:plug_home)

  " Plug 'silverlyra/astral'

  call s:define_commands()
endfunction

" FIXME: remove
function! s:ensure_paths() abort
  if empty(get(g:, 'nvim_home', ''))
    let g:nvim_home = (empty($XDG_DATA_HOME) ? '~/.local/share' : $XDG_DATA_HOME) . '/nvim'
  endif
  if empty(get(g:, 'plug_home', ''))
    let g:plug_home = g:nvim_home . '/plugged'
  endif
endfunction

function! astral#end() abort
  call plug#end()

  for plane in s:planes
    let Configure = s:plane_hook(plane.name, 'configure')
    call Configure(plane.options)
  endfor
endfunction

function! astral#use(plane, ...) abort
  let l:options = get(a:, 1, {})

  let Enter = s:plane_hook(a:plane, 'enter')
  call Enter(l:options)

  call add(s:planes, {'name': a:plane, 'options': l:options})
endfunction

function! s:define_commands() abort
  command! -nargs=+ -bar Plane call astral#use(<args>)
endfunction

function! s:plane_hook(plane, hook) abort
  let name = substitute(a:plane, '/', '#', 'g')
  return function(printf('astral#plane#%s#%s', name, a:hook))
endfunction
