set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932
set fileformats=unix,dos

set mouse=n
set ttymouse=xterm2

set number
set title
set showcmd

" color
syntax on

" 行末の半角スペースハイライト
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

"colorschem on

command! Trim :%s/\s\+$//

" Search
set ignorecase
set smartcase
set wrapscan
set hlsearch

" Edit
set autoindent
set showmatch
set smartindent
set cindent

" Tab
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set shiftround

"set autoindent
autocmd FileType ruby :set ts=2 sw=2 fenc=utf-8
autocmd FileType cucumber :set ts=2 sw=2 fenc=utf-8

set nowrap

" datetime
inoremap <Leader>c <C-R>=strftime('%Y-%m-%dT%H:%M:%S+09:00')<CR>


imap <c-b> <Left>
imap <c-n> <Down>
imap <c-p> <Up>
imap <c-f> <Right>

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc'

" My Bundles here:
"
" Note: You don't set neobundle setting in .gvimrc!
" Original repos on github

NeoBundle 'itchyny/lightline.vim'
set laststatus=2
set t_Co=256

NeoBundle 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_php_checkers = ['phpcs']
let g:syntastic_check_on_open = 1
let g:syntastic_echo_current_error = 1
let g:syntastic_enable_signs = 1
let g:syntastic_enable_balloons = 0
let g:syntastic_enable_highlighting = 1
let g:syntastic_auto_jump = 0
let g:syntastic_auto_loc_list = 2
let g:syntastic_loc_list_height = 5
let g:syntastic_mode_map = { 'mode': 'active',
                          \ 'active_filetypes': ['ruby', 'php'],
                          \ 'passive_filetypes': [] }
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
let g:syntastic_php_phpcs_post_args = '--standard=psr2'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}
NeoBundle 'Shougo/Vimfiler'
NeoBundle 'Shougo/Vimshell'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neocomplcache-rsense'
NeoBundle 'taichouchou2/vim-endwise.git'

"TweetVimとその依存関係のプラグイン
NeoBundle 'basyura/TweetVim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'basyura/twibill.vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'basyura/bitly.vim'
NeoBundle 'Shougo/unite.vim'

" vim-scripts repos
NeoBundle 'L9'
NeoBundle 'rails.vim'
" Non github repos
NeoBundle 'git://git.wincent.com/command-t.git'
" Non git repos

" ...

filetype plugin indent on     " Required!
"
" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Installation check.
NeoBundleCheck
