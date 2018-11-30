"
" fuzzy-finding plane
"

scriptencoding utf-8

function! astral#plane#find#enter(options) abort
  call g:astral#plugin#find#core.use()
endfunction

function! astral#plane#find#configure(options) abort
  call denite#custom#var('file/rec', 'command',
        \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
  call denite#custom#var('grep', 'command', ['rg'])
  call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])

  call denite#custom#option('default', {
        \ 'auto-resize': v:true,
        \ 'direction': 'dynamicbottom',
        \ 'prompt': '❯',
        \ 'statusline': v:false,
        \ })

  call astral#plane#ui#statusline#def_special('Denite', 
        \ {'type': 'denite'},
        \ {'filename': {-> denite#get_status('sources')}})
endfunction

