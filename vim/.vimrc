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

" privider
let g:python_host_prog=$PYENV_ROOT.'/versions/neovim-2/bin/python'
let g:python3_host_prog=$PYENV_ROOT.'/versions/neovim-3/bin/python'

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

let g:rc_dir    = expand('~/Projects/github.com/yasudanaoya/dotfiles/vim/toml')
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

let g:dein#auto_recache = 1

" plugin settings

" lsp
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction
" typescript-language-server
if executable('typescript-language-server')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'typescriptreact'],
        \ })
endif

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" fern
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

" vim-better-whitespace
let g:better_whitespace_guicolor='<desired_color>'
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" blamer
let g:blamer_enabled=1
let g:blamer_date_format = '%y/%m/%d %H:%M'

" ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|.DS_Store\|\.git'
let g:ctrlp_show_hidden = 1

colorscheme onedark
hi Normal ctermbg=NONE guibg=NONE

nnoremap <silent> <Leader>f :Fern . -reveal=% -drawer -toggle -width=40<CR>
tnoremap <Esc> <C-\><C-n>
