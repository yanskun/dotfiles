set expandtab
set showcmd
set tabstop=2
set shiftwidth=2
set number
set cursorline
set cursorcolumn
set virtualedit=onemore
set clipboard=unnamed

" disable cross key
vnoremap  <Up>     <nop>
vnoremap  <Down>   <nop>
vnoremap  <Left>   <nop>
vnoremap  <Right>  <nop>
noremap   <Up>     <nop>
noremap   <Down>   <nop>
noremap   <Left>   <nop>
noremap   <Right>  <nop>

" setting pluins {{{
" {{{ dein.vim settings
let s:dein_dir = has('nvim') ? expand('~/.cache/dein/nvim') : expand('~/.cache/dein/vim')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let g:dein#lazy_rplugins = 1

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " syntax
  call dein#add('leafgarland/typescript-vim')
  call dein#add('stephpy/vim-yaml')

  " colorscheme

  " for development
  call dein#add('Shougo/dein.vim')
  call dein#add('Quramy/tsuquyomi')
  " for documentation

  " for develop vim/neovim plugin

  " other

  " end settings
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

function! DeinClean() abort
  let s:removed_plugins = dein#check_clean()
  if len(s:removed_plugins) > 0
    echom s:removed_plugins
    call map(s:removed_plugins, "delete(v:val, 'rf')")
    call dein#recache_runtimepath()
  endif
endfunction

command! CleanPlugins call DeinClean()
" }}}

" uninstall dein pluin
" call map(dein#check_clean(), "delete(v:val, 'rf')")
" after run => :call dein#recache_runtimepath()

syntax on
set t_Co=256
