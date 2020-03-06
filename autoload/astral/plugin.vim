"
" plugin definitions
"
" these files centralize the definition of plugins that are used by planes. all planes that need
" (e.g.) a language server protocol client can simply request it, and it will be added to vim-plug
" and appropriately configured with its `make install` step once.
"

function! astral#plugin#new(name, ...) abort
  let l:options = get(a:, 1, {})

  let plugin = {'name': a:name, 'options': l:options, 'used': 0}

  function plugin.use() abort
    if self.used
      return
    endif

    let self.used = 1
    Plug self.name, self.options
  endfunction

  return plugin
endfunction

let astral#plugin#languageclient = astral#plugin#new('autozimu/LanguageClient-neovim',
  \ {'build': 'bash install.sh'})
