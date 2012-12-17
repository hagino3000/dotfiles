set nocompatible

set enc=utf-8
set ambiwidth=double

set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch

set autoindent
set smartindent
set cindent
set tabstop=2
set shiftwidth=2
set expandtab

set number
set noruler
set nolist
set showmatch
set wrap
set title
set showcmd
set cmdheight=2
set laststatus=2
set statusline=%F%m%r%h%w\ [%{&ff}][%{&fenc!=''?&fenc:&enc}][%Y][pos:%04l,%04v][%p%%][rows:%L]
set wildmenu
set nocursorline

set backspace=2
set scrolloff=5
set formatoptions+=mM
set nobackup
set history=1000
set mouse=a

" set autochdir
set restorescreen
set hidden

set browsedir=current
set nohlsearch
set nowrapscan

" set tags=~/dev/study/_vim/.tags


set imdisable
set iminsert=1
set imsearch=1

set splitbelow "新しいウィンドウを下に開く
set splitright "新しいウィンドウを右に開く

syntax on

" ====================================================
" vundle settings
" 
" To install vundle
" mkdir .vim/bundle
" cd .vim/bundle
" git clone http://github.com/gmarik/vundle.git
" ====================================================
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'vcscommand.vim'
Bundle 'octave.vim'
Bundle 'QuickBuf'
Bundle 'scratch'
Bundle 'skk.vim-B'
Bundle 'sudo.vim'
Bundle 'The-NERD-tree'
Bundle 'neocomplcache'
Bundle 'thinca/vim-quickrun'
Bundle 'Syntastic'
Bundle 'vim-coffee-script'
Bundle 'ack.vim'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'

" Show undo history
Bundle 'Gundo'
nnoremap <F5> :GundoToggle<CR>

 " Brief help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Bundle command are not allowed..

" ====================================================

" SKK
let skk_jisyo = "/Users/t-nishibayashi/Library/Application Support/AquaSKK/skk-jisyo.utf8"
let skk_large_jisyo = "/Users/t-nishibayashi/Library/Application Support/AquaSKK/SKK-JISYO.L"
let skk_egg_like_newline = 1


filetype indent on
filetype plugin indent on
filetype plugin on

autocmd FileType ruby set tabstop=2 tw=0 sw=2 expandtab
autocmd FileType eruby set tabstop=2 tw=0 sw=2 expandtab
autocmd FileType html set tabstop=2 tw=0 sw=2 expandtab fenc=utf-8
autocmd BufNewFile,BufRead *.ejs set filetype=html
autocmd FileType javascript set tabstop=2 tw=0 sw=2 fenc=utf-8 expandtab
autocmd FileType python set tabstop=4 tw=0 sw=4 fenc=utf-8 expandtab fileencoding=utf-8

autocmd FileType c hi Comment ctermfg=darkcyan
autocmd FileType cpp hi Comment ctermfg=darkcyan
autocmd FileType cpp set tabstop=4 tw=0 sw=4 fenc=utf-8 expandtab
autocmd FileType coffee set tabstop=2 tw=2

autocmd FileType rst set fenc=utf-8

autocmd BufRead /tmp/crontab.* :set nobackup nowritebackup

autocmd BufNewFile,BufRead app/*/*.rhtml set ft=mason fenc=utf-8
autocmd BufNewFile,BufRead app/**/*.rb set ft=ruby fenc=utf-8
autocmd BufNewFile,BufRead app/**/*.yml set ft=ruby fenc=utf-8

autocmd FileType GITCOMMIT set fenc=utf-8
autocmd FileType VCSCOMMIT set fenc=utf-8

autocmd FileType php set tabstop=4 tw=0 sw=4 fenc=utf-8 expandtab
autocmd BufRead,BufNewFile *.twig set syntax=htmldjango

"autocmd BufWrite *.* :call didSaveFile()
"function! didSaveFile()
"
"endfunction

" =========================================
" Plugin settings
" =========================================
let format_join_spaces = 4
let format_allow_over_tw = 1

" Quickrun.vim
let g:quickrun_config={'*': {
\'hook/time/enable': '1',
\'split': '%{winwidth(0) < winheight(0) + 200 ? "vertical" : ""}',
\}}

" rails.vim
let g:rails_level=4
let g:rails_default_file="app/controllers/application.rb"
let g:rails_default_database="sqlite3"

" rubycomplete.vim
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

" neocomplecache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 4
let g:neocomplcache_manual_completion_start_length = 4
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1


" path
let &path="~/dev/workspace,~"
let main_syntax="html"


"======================= Key Mappings ======================
let mapleader = ','
nnoremap <Space>w :<C-u>update<CR>
nnoremap <Space>. :<C-u>edit $MYVIMRC<Enter>
nnoremap <Space>s. :<C-u>source $MYVIMRC<Enter>

" help
nnoremap <expr> <Space>h ':<C-u>help ' . expand('<cword>') . '<CR>'

" line feed
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" scratch.vim
nnoremap <leader>so :<C-u>ScratchOpen<CR>
nnoremap <leader>sc :<C-u>ScratchClose<CR>

" Use ClipBoard
vmap <silent> sy :!pbcopy; pbpaste<CR>
map <silent> sp v:!pbpaste<CR>

" javascript
" autocmd FileType javascript nnoremap ,jsl :!gjslint --custom_jsdoc_tags 'xtype,event,singleton' %<CR>
autocmd FileType javascript nnoremap ,jsl :!SyntasticCheck<CR>
autocmd FileType javascript nnoremap ,jsf :!fixjsstyle --custom_jsdoc_tags 'xtype,event,singleton' %<CR>

autocmd FileType javascript inoremap <buffer> fff function(
autocmd FileType javascript inoremap <buffer> eee assert.equal(
autocmd FileType javascript inoremap <buffer> iie console.error();<LEFT><LEFT>
autocmd FileType javascript inoremap <buffer> iii console.log();<LEFT><LEFT>
autocmd FileType javascript inoremap <buffer> iid console.dir();<LEFT><LEFT>

" python
autocmd FileType python nnoremap <leader>py :<C-u>!python %<Enter>

" insert date
inoremap <expr> ,df strftime('%Y-%m-%dT%H:%M:%S')
inoremap <expr> ,dd strftime('%Y-%m-%d')
inoremap <expr> ,dt strftime('%H:%M:%S')

" select last changed text
nnoremap gc `[v`]
vnoremap gc :<C-u>normal gc<Enter>
onoremap gc :<C-u>normal gc<Enter>

" search
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" Auto complete
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap " "zdi"<C-R>z"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

" buffer control
nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>
nnoremap <F3> :bd<CR>

" window
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

" tab
nnoremap <Space>n :<C-u>tabn<CR>
nnoremap <Space>p :<C-u>tabp<CR>

" filefinder
nnoremap <leader>fr :<C-u>FufBuffer<CR>
nnoremap <leader>fe :<C-u>FufFile<CR>
nnoremap <leader>ff :<C-u>FufCoverageFile<CR>

" hg
nnoremap <leader>hd :<C-u>HgDiff<CR>

" VCS
nnoremap <leader>cd :<C-u>VCSDiff<CR>
nnoremap <leader>cc :<C-u>VCSCommit<CR>

" NERD_tree
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" makefile
nnoremap <leader>mc :<C-u>!make concat<CR>
nnoremap <leader>mt :<C-u>!make test<CR>

" rakefile
nnoremap <leader>rc :<C-u>!rake concat<CR>
nnoremap <leader>rd :<C-u>!rake debug<CR>
nnoremap <leader>rt :<C-u>!rake test<CR>

if has('multi_byte_ime') || has('xim')
	" 日本語入力ON時のカーソルの色を設定
	highlight CursorIM guibg=Purple guifg=NONE
endif

hi Search term=reverse ctermbg=Darkcyan ctermfg=NONE

colorscheme ron

" edit binary file
"augroup BinaryXXD
"	autocmd!
"	autocmd BufReadPre  *.bin let &binary =1
"	autocmd BufReadPost * if &binary | silent %!xxd -g 1
"	autocmd BufReadPost * set ft=xxd | endif
"	autocmd BufWritePre * if &binary | %!xxd -r | endif
"	autocmd BufWritePost * if &binary | silent %!xxd -g 1
"	autocmd BufWritePost * set nomod | endif
"augroup END
"
"
autocmd BufRead svn* call TemplateSVN()
function! TemplateSVN()
        set fileencoding=utf-8
endfunction

augroup vimrc-auto-cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
  autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
  autocmd WinEnter * call s:auto_cursorline('WinEnter')
  autocmd WinLeave * call s:auto_cursorline('WinLeave')

  let s:cursorline_lock = 0
  function! s:auto_cursorline(event)
    if a:event ==# 'WinEnter'
      setlocal cursorline
      let s:cursorline_lock = 2
    elseif a:event ==# 'WinLeave'
      setlocal nocursorline
    elseif a:event ==# 'CursorMoved'
      if s:cursorline_lock
        if 1 < s:cursorline_lock
          let s:cursorline_lock = 1
        else
          setlocal nocursorline
          let s:cursorline_lock = 0
        endif
      endif
    elseif a:event ==# 'CursorHold'
      setlocal cursorline
      let s:cursorline_lock = 1
    endif
  endfunction
augroup END

" memo
" show messages
" :messages

