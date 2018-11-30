function! s:ensure_plug() abort
  if !empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    return
  endif

  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  augroup bootstrap
    autocmd!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endfunction

function! s:ensure_paths() abort
  if empty(get(g:, 'nvim_home', ''))
    let g:nvim_home = (empty($XDG_DATA_HOME) ? '~/.local/share' : $XDG_DATA_HOME) . '/nvim'
  endif
  if empty(get(g:, 'plug_home', ''))
    let g:plug_home = g:nvim_home . '/plugged'
  endif
endfunction
