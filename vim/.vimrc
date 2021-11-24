language en_US

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

" dein settings {{{
let s:dein_dir = has('nvim') ? expand('~/.cache/dein/nvim') : expand('~/.cache/dein/vim')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

let g:rc_dir    = expand('~/dotfiles/vim/toml')
let s:toml      = g:rc_dir . '/dein.toml'
let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " load toml
  call dein#load_toml(s:toml,      {'lazy':0})
  call dein#load_toml(s:lazy_toml, {'lazy':1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax on

" install if not installed
if dein#check_install()
  call dein#install()
endif
" }}}

" uninstall dein pluin
call map(dein#check_clean(), "delete(v:val, 'rf')")
" after run => :call dein#recache_runtimepath()

let g:fern#drawer_keep = 1
let g:fern#default_hidden = 1
let hide_dirs  = '^\%(\.git\|node_modules\)$'
let hide_files = '\%(\.byebug\|\.ruby-\|\.DS_Store\)\+'
let g:fern#default_exclude = hide_dirs . '\|' . hide_files
let g:fern#renderer = 'nerdfont'
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END


let g:dein#auto_recache = 1

let g:better_whitespace_guicolor='<desired_color>'
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

colorscheme onedark
hi Normal ctermbg=NONE guibg=NONE

nnoremap <silent> <Leader>f :Fern . -reveal=% -drawer -toggle -width=40<CR>
tnoremap <Esc> <C-\><C-n>
