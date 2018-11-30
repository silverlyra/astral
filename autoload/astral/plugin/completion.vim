"
" auto-completion plugins
"
" astral uses deoplete as its completion framework.
"

let astral#plugin#completion#core = astral#plugin#new('Shougo/deoplete.nvim',
                                                      \ {'do': ':UpdateRemotePlugins'})

let astral#plugin#completion#go = astral#plugin#new('zchee/deoplete-go', {'build': 'make'})
let astral#plugin#completion#rust = astral#plugin#new('racer-rust/vim-racer')
let astral#plugin#completion#vim = astral#plugin#new('Shougo/neco-vim')
let astral#plugin#completion#zsh = astral#plugin#new('zchee/deoplete-zsh')
