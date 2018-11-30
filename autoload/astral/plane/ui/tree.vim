"
" filesystem tree view
"

function! astral#plane#ui#tree#enter(options) abort
  call g:astral#plugin#ui#tree.use()
endfunction

function! astral#plane#ui#tree#configure(options) abort
  let g:NERDTreeMinimalUI = get(a:options, 'minimal', 1)
  let g:NERDTreeWinPos = get(a:options, 'position', 'left')

  call astral#plane#ui#statusline#def_special('NERDTree', 
        \ {'type': 'nerdtree'},
        \ {'filename': {-> fnamemodify(b:NERDTree.root.path.str(), ':~:.')}})

  augroup nerdtree
    autocmd!
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTreeToggle' | wincmd p | endif
  augroup END

  if get(a:options, 'follow')
    augroup nerdtree
      autocmd BufEnter * if &modifiable && @% !=# '' && !astral#plane#ui#statusline#is_special() | NERDTreeFind | wincmd p | endif 
    augroup END
  endif

  nnoremap <leader>T :NERDTreeToggle
  nnoremap <leader>w :NERDTreeFind
endfunction
