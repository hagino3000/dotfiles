" ====================================================
" Basic settings
" ====================================================
"
scriptencoding utf-8

set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932,ucs-bom,default,latin1

set enc=utf-8
set ambiwidth=double

set nowritebackup
set nobackup
set noswapfile

set ignorecase
set smartcase
set incsearch
set hlsearch
set nowrapscan

set autoindent
set smartindent

set cindent
set tabstop=4
set shiftwidth=4
set expandtab

set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
set number
set noruler
set showmatch
set wrap
set textwidth=0
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
set history=1000
set mouse=a

" set autochdir
set restorescreen
set hidden

set browsedir=current
set t_vb=
set novisualbell
set noerrorbells

" Ghostty へのカーソル点滅問い合わせ(ESC[?12$p)を止める。
" 応答が VimEnter の system('im-select') 中(cooked mode)に届くと
" 画面に 12;2$y とエコーされてしまうため
set t_RC=

" set tags=~/dev/study/_vim/.tags

set imdisable
set iminsert=1
set imsearch=1

set splitbelow "Open new window below
set splitright "Open new window right

colorscheme murphy

let g:mapleader = ','

" ====================================================
" vim-plug @see https://github.com/junegunn/vim-plug
" ====================================================

if &compatible
  set nocompatible
endif

" Install vim-plug itself on first launch
let s:plug_src = expand('~/.vim/autoload/plug.vim')
if empty(glob(s:plug_src))
  silent execute '!curl -fLo ' . s:plug_src . ' --create-dirs '
    \ . 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/vim-plugged')

" Fuzzy finder (files, buffers, MRU, grep)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" File explorer
Plug 'lambdalisue/fern.vim'
let g:fern#default_hidden = 1

" Git
Plug 'tpope/vim-fugitive'

" Run current buffer
Plug 'thinca/vim-quickrun'

" Auto completion
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'

" Undo tree
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" SKK input method inside Vim (requires deno)
Plug 'vim-denops/denops.vim'
Plug 'vim-skk/skkeleton'

" Misc
Plug 'vim-scripts/scratch'
Plug 'vim-scripts/sudo.vim'
Plug 'jceb/vim-hier'
Plug 'dannyob/quickfixstatus'

" File types
Plug 'vim-scripts/octave.vim', { 'for': 'matlab' }
Plug 'vim-jp/vim-go-extra', { 'for': 'go' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }

call plug#end()

syntax on
syntax enable

" --- plugin settings ---

" quickrun
let g:quickrun_config={
            \'*': {
            \    'hook/time/enable': '1',
            \    'split': '%{winwidth(0) < winheight(0) + 200 ? "vertical" : ""}',
            \},
            \'python': {'command': 'python3'}
\}

" fugitive
nnoremap <leader>cs :<C-u>Git<CR>
nnoremap <leader>cd :<C-u>Gdiffsplit<CR>

" fzf (replaces unite.vim / neomru / ag.vim)
nnoremap <silent> <leader>fb :<C-u>Buffers<CR>
nnoremap <silent> <leader>ff :<C-u>Files<CR>
nnoremap <silent> <leader>fr :<C-u>History<CR>
nnoremap <silent> <leader>fg :<C-u>Ag<CR>
nnoremap <silent> <leader>fs :<C-u>edit ~/dev/dotfiles/snippets/general.py<CR>

" asyncomplete (replaces neocomplcache)
autocmd User asyncomplete_setup call asyncomplete#register_source(
    \ asyncomplete#sources#buffer#get_source_options({
    \     'name': 'buffer',
    \     'allowlist': ['*'],
    \     'completor': function('asyncomplete#sources#buffer#completor'),
    \ }))
let g:asyncomplete_auto_popup = 1
inoremap <expr><C-e> pumvisible() ? asyncomplete#cancel_popup() : "\<C-e>"

" skkeleton (SKK in Vim; OS side IME should stay in ascii mode)
imap <C-j> <Plug>(skkeleton-toggle)
cmap <C-j> <Plug>(skkeleton-toggle)

" Dictionaries are placed by macos/setup_skk.sh (shared with macSKK)
function! s:skkeleton_init() abort
  let l:dict_dir = expand('~/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Dictionaries')
  call skkeleton#config({
      \ 'globalDictionaries': [
      \     [l:dict_dir . '/SKK-JISYO.L', 'euc-jp'],
      \     [l:dict_dir . '/SKK-JISYO.emoji-ja.utf8', 'utf-8'],
      \     [l:dict_dir . '/SKK-JISYO.emoji.utf8', 'utf-8'],
      \     [l:dict_dir . '/skk-jisyo.utf8', 'utf-8'],
      \ ],
      \ })
endfunction
autocmd User skkeleton-initialize-pre call s:skkeleton_init()

" Suppress asyncomplete popup while typing kana
autocmd User skkeleton-enable-pre let b:asyncomplete_enable = 0
autocmd User skkeleton-disable-pre let b:asyncomplete_enable = 1

" Open SKK user dictionary
nnoremap <leader>sj :<C-u>edit ~/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Dictionaries/skk-jisyo.utf8<CR>

" Keep OS IME (macSKK) out of the way while vim is running:
" switch to ABC on enter, restore the previous input source on exit.
" Japanese input inside vim is handled by skkeleton.
" VimEnter で system() を使うと端末が一時的に cooked mode になり、
" ghostty からの起動時問い合わせ応答(Secondary DA / OSC 10,11)が
" その隙間にエコーされてしまうため、非同期の job_start() で行う
if executable('im-select')
  function! s:save_im(ch, msg) abort
    let s:saved_im = trim(a:msg)
  endfunction
  augroup ime_ascii_on_vim
    autocmd!
    autocmd VimEnter * call job_start(
          \   ['/bin/sh', '-c', 'im-select; im-select com.apple.keylayout.ABC'],
          \   {'out_cb': function('s:save_im')})
    autocmd VimLeavePre * if exists('s:saved_im')
          \ | call system('im-select ' . s:saved_im)
          \ | endif
  augroup END
endif


" ====================================================
" File type settings
" ====================================================

filetype indent on
filetype plugin indent on
filetype plugin on

augroup vimrc_file_type
    autocmd!
    autocmd BufNewFile,BufRead *.pm           set filetype=perl
    autocmd BufNewFile,BufRead *.scala        set filetype=scala
    autocmd BufNewFile,BufRead app/*/*.rhtml  set ft=mason fenc=utf-8
    autocmd BufNewFile,BufRead app/**/*.rb    set ft=ruby fenc=utf-8
    autocmd BufNewFile,BufRead app/**/*.yml   set ft=ruby fenc=utf-8
    autocmd BufNewFile,BufRead *.twig         set syntax=htmldjango

    autocmd FileType ruby       set tabstop=4 tw=0 sw=4 expandtab
    autocmd FileType eruby      set tabstop=2 tw=0 sw=2 expandtab
    autocmd FileType html       set tabstop=2 tw=0 sw=2 fenc=utf-8 expandtab
    autocmd FileType javascript set tabstop=4 tw=0 sw=4 fenc=utf-8 expandtab
    autocmd FileType coffee     set tabstop=4 tw=0
    autocmd FileType python     set fenc=utf-8
    autocmd FileType rst        set fenc=utf-8
    autocmd FileType php        set tabstop=4 tw=0 sw=4 fenc=utf-8 expandtab
    autocmd FileType perl       set tabstop=4 tw=0 sw=4 fenc=utf-8 expandtab
    autocmd FileType scss       set fenc=utf-8 tw=0 sw=4
    autocmd FileType yaml       set tabstop=2 fenc=utf-8 tw=0 sw=2

    " Also python settings are ftplygin/python

    autocmd FileType c   hi Comment ctermfg=darkcyan
    autocmd FileType cpp hi Comment ctermfg=darkcyan
    autocmd FileType cpp set tabstop=4 tw=0 sw=4 fenc=utf-8 expandtab

    autocmd FileType GITCOMMIT set fenc=utf-8

    autocmd BufRead /tmp/crontab.* :set nobackup nowritebackup

augroup END


" path
let &path="~/dev/workspace,~"
set rtp+=/usr/local/Cellar/go/1.2/libexec/misc/vim
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")

" ====================================================
" Key Mappings
" ====================================================
nnoremap <Space>w :<C-u>update<CR>
nnoremap <Space>q :<C-u>quit<CR>
nnoremap <Space>. :<C-u>edit $MYVIMRC<Enter>
nnoremap <Space>s. :<C-u>source $MYVIMRC<Enter>

inoremap jj <Esc>


" clear highlight
nmap <ESC><ESC> :nohlsearch<CR><ESC>

" help
nnoremap <expr> <Space>h ':<C-u>help ' . expand('<cword>') . '<CR>'

" Directory Tree
nnoremap <Leader>e :<C-u>Fern . -drawer -toggle<CR>

" Quickrun
nnoremap <Leader>q :<C-u>QuickRun<CR>

" line feed
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" scratch.vim
nnoremap <leader>so :<C-u>ScratchOpen<CR>
nnoremap <leader>sc :<C-u>ScratchClose<CR>

" undo
nnoremap <leader>gl :<C-u>UndotreeToggle<CR>

" Use ClipBoard
vmap <silent> sy :!pbcopy; pbpaste<CR>
map <silent> sp v:!pbpaste<CR>


augroup vimrc_file_type_nmap
    autocmd!

    " javascript
    " autocmd FileType javascript nnoremap ,jsl :!gjslint --custom_jsdoc_tags 'xtype,event,singleton' %<CR>
    autocmd FileType javascript nnoremap ,jsl :SyntasticCheck<CR>
    autocmd FileType javascript nnoremap ,jsf :!fixjsstyle --custom_jsdoc_tags 'xtype,event,singleton' %<CR>

    autocmd FileType javascript inoremap <buffer> fff function(
    autocmd FileType javascript inoremap <buffer> eee assert.equal(
    autocmd FileType javascript inoremap <buffer> iie console.error();<LEFT><LEFT>
    autocmd FileType javascript inoremap <buffer> iii console.log();<LEFT><LEFT>
    autocmd FileType javascript inoremap <buffer> iid console.dir();<LEFT><LEFT>

    " perl
    autocmd FileType perl       inoremap <buffer> iii use Data::Dumper; warn Dumper

    " python
    autocmd FileType python nnoremap <leader>py :<C-u>!python3 %<Enter>

    function! s:snowflake_after(...)
      execute ':QuickfixStatusEnable'
      execute ':HierUpdate'
    endfunction
    let g:snowflake_callbacks = {
      \ 'after_run': function('s:snowflake_after')
      \ }
    "autocmd BufWritePost *.py call snowflake#run()
    "autocmd InsertLeave *.py call snowflake#run()
    autocmd FileType python nnoremap <leader>ln :call snowflake#run()<CR>

    "@autocmd FileType python nnoremap <leader>ln :call Flake8()<CR>

    autocmd FileType python inoremap <buffer> ccc # coding=utf-8
    autocmd FileType python inoremap <buffer> iid logger.debug()<LEFT>
    autocmd FileType python inoremap <buffer> iii logger.info()<LEFT>
    autocmd FileType python inoremap <buffer> iiw logger.warning()<LEFT>
    autocmd FileType python inoremap <buffer> iie logger.error()<LEFT>
    autocmd FileType python inoremap <buffer> iic logger.critical()<LEFT>
augroup END

" insert date
inoremap <expr> ,df strftime('%Y-%m-%dT%H:%M:%S')
inoremap <expr> ,dd strftime('%Y-%m-%d')
inoremap <expr> ,dt strftime('%H:%M:%S')

" select last changed text
nnoremap gc `[v`]
vnoremap gc :<C-u>normal gc<Enter>
onoremap gc :<C-u>normal gc<Enter>

" memo
nnoremap <leader>sn :<C-u>edit ~/dev/dotfiles/snippets/<Enter>

" search
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" Auto complete
vnoremap ` "zdi`<C-R>z`<ESC>
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap " "zdi"<C-R>z"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

" buffer control
nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>
" nnoremap <C-W> :bd<CR>

" window move
nnoremap <C-J> <C-W>j
nnoremap <C-B> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

" window resize
nnoremap + <C-W>>
nnoremap ; <C-W><
nnoremap = <C-W>+
nnoremap - <C-W>-

" tab
nnoremap <Space>n :<C-u>tabn<CR>
nnoremap <Space>p :<C-u>tabp<CR>

" hg
nnoremap <leader>hd :<C-u>HgDiff<CR>

" quickrun
nnoremap <leader>q :<C-u>QuickRun<CR>


" makefile
nnoremap <leader>mc :<C-u>!make concat<CR>
nnoremap <leader>mt :<C-u>!make test<CR>

autocmd BufRead svn* call TemplateSVN()
function! TemplateSVN()
        set fileencoding=utf-8
endfunction

" ====================================================
" Commands
" ====================================================
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

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

" create directory automatically
augroup vimrc-auto-mkdir
    autocmd!
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
    function! s:auto_mkdir(dir, force)
        if !isdirectory(a:dir) && (a:force ||
            \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
            call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
        endif
    endfunction
augroup END

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

" ===================================
" memo 
" ===================================
" show messages
" :messages
"
" show quickfixlist (mypy ....)
" :copen
"
" Git commands
" :Gbrame
" :Gstatus
" :Gwrite -> git add
" :Gremove -> git rm
" :Gdiff
" :Gcommit
" See http://yuku-tech.hatenablog.com/entry/20110427/1303868482

" autocmd QuickFixCmdPost grep,vimgrep cw
"
" Reopen current file by other encoding
" :e ++enc=cp932
"
" Vim Tree
" gs: Go out from safe mode
" N: Create New file
" r: rename
" 
" 一括置換
" :args *.py
" :args
" :argdo %s/import/immmmm/g | update
"
" Jump to next char
" f<char>
" Jump to previous char
" F<char>
" Delete words until white spase
" dw
" dW
"
" 改行置換(CRコードは ctrl-v ctrl-m で入力)
" :%s/    /    /g
"
" JSON Format
" :%!python -m json.tool
" JSON veirfy
" !cat % | json_verify
"
" Check key binds
" :map
