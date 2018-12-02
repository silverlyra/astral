"
" git intergation plane
"
scriptencoding utf-8

function! astral#plane#git#enter(options)
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/gv.vim'

  Plug 'mhinz/vim-signify'
  let g:signify_vcs_list = ['git']
endfunction

function! astral#plane#git#configure(options) abort
  call astral#plane#ui#statusline#def('git', 'fugitive#head')
  call astral#plane#ui#statusline#add(['git'], {'side': 'left', 'priority': 1})
endfunction
