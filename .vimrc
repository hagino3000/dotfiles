" ====================================================
" Basic settings
" ====================================================
"
set nocompatible

set fileencodings=iso-2022-jp,utf-8,euc-jp,cp932,ucs-bom,default,latin1

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

" set tags=~/dev/study/_vim/.tags

set imdisable
set iminsert=1
set imsearch=1

set splitbelow "Open new window below
set splitright "Open new window right

colorscheme ron
syntax on

let mapleader = ','

" ====================================================
" NeoBundle @see https://github.com/Shougo/neobundle.vim
" ====================================================
let s:noplugin = 0
let s:bundle_root = expand('~/.vim/bundle')
let s:neobundle_root = s:bundle_root . '/neobundle.vim'
if !isdirectory(s:neobundle_root) || v:version < 702
    " NeoBundleが存在しない、もしくはVimのバージョンが古い
    let s:noplugin = 1
else
    if has('vim_starting')
       set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif

    call neobundle#rc(expand('~/.vim/bundle/'))

    " Use https instead of git to fetch
    " let g:neobundle_default_git_protocol='https'

    " Let NeoBundle manage NeoBundle
    NeoBundleFetch 'Shougo/neobundle.vim'

    " Git commands
    NeoBundle 'tpope/vim-fugitive'
    nnoremap <leader>cs :<C-u>Gstatus<CR>
    nnoremap <leader>cd :<C-u>Gdiff<CR>

    " Octave
    NeoBundle 'octave.vim'

    " Enable scratch buffer
    NeoBundle 'scratch'

    " Use SKK
    NeoBundleLazy 'skk.vim-B', {
                \ "autoload": {"insert": 1}}
    let skk_jisyo = "~/Library/Application Support/AquaSKK/skk-jisyo.utf8"
    let skk_large_jisyo = "~/Library/Application Support/AquaSKK/SKK-JISYO.L"
    let skk_egg_like_newline = 1

    " Enable :SudoRead :SudoWrite
    NeoBundle 'sudo.vim'

    NeoBundle "Shougo/vimproc", {
            \ "build": {
            \   "windows"   : "make -f make_mingw32.mak",
            \   "cygwin"    : "make -f make_cygwin.mak",
            \   "mac"       : "make -f make_mac.mak",
            \   "unix"      : "make -f make_unix.mak",
            \ }}

    " Unite
    NeoBundle "Shougo/unite.vim"
    let s:hooks = neobundle#get_hooks("unite.vim")
    function! s:hooks.on_source(bundle)
        " let g:unite_enable_start_insert = 1
        let g:unite_enable_ignore_case = 1
        let g:unite_enable_smart_case = 1

        " Use ag to grep
        if executable('ag')
            let g:unite_source_grep_command = 'ag'
            let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
            let g:unite_source_grep_recursive_opt = ''
        endif

        nnoremap [unite] <Nop>
        nmap <leader>f [unite]
        nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
        nnoremap <silent> [unite]b :<C-u>Unite file_mru buffer<CR>
        nnoremap <silent> [unite]g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
        nnoremap <silent> [unite]r :<C-u>UniteResume search-buffer<CR>
        nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>

        " Use vimfiler to open directory
        call unite#custom_default_action("source/bookmark/directory", "vimfiler")
        call unite#custom_default_action("directory", "vimfiler")
        call unite#custom_default_action("directory_mru", "vimfiler")

        " Configure keymaps
        autocmd FileType unite call s:unite_settings()
        function! s:unite_settings()
            imap <buffer> <Esc><Esc> <Plug>(unite_exit)
            nmap <buffer> <C-w> <Plug>(unite_exit)
        endfunction
    endfunction


    " Complete
    NeoBundleLazy 'Shougo/neocomplete.vim', {
                \ "autoload": {"insert": 1}}
    let g:neocomplete#enable_smart_case = 1

    " Filer Viewer
    NeoBundleLazy 'Shougo/vimfiler', {
                \ "depends": ["Shougo/unite.vim"],
                \ "autoload": {
                \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
                \   "mappings": ['<Plug>(vimfiler_switch)'],
                \   "explorer": 1,
                \ }}
    let s:hooks = neobundle#get_hooks("vimfiler")
    function! s:hooks.on_source(bundle)
        let g:vimfiler_ignore_pattern = '\%(\.DS_Store\|\.hg$\|\.git$\|\.pyc$\|\.pyo$\|\.o$\|\.swp$\|\.swo$\)'
        let g:vimfiler_as_default_explorer = 1
        let g:vimfiler_enable_auto_cd = 1

        " Configure keymaps
        autocmd FileType vimfiler call s:vimfiler_settings()
        function! s:vimfiler_settings()
            " Move parent directory
            nmap <buffer> u <Plug>(vimfiler_switch_to_parent_directory)
            " Refresh (Because I want to use <C-l> to move window)
            nmap <buffer> R <Plug>(vimfiler_redraw_screen)
            " Back <C-l> to my setting
            nnoremap <buffer> <C-l> <C-w>l
        endfunction
    endfunction


    " Run with ,r
    NeoBundle 'thinca/vim-quickrun'
    let g:quickrun_config={'*': {
    \'hook/time/enable': '1',
    \'split': '%{winwidth(0) < winheight(0) + 200 ? "vertical" : ""}',
    \}}

    " Syntax check
    NeoBundleLazy 'Syntastic', {
                \ "autoload": {"insert": 1}}
    "let g:syntastic_mode_map = {
    "      \'mode':'passive',
    "      \'active_filetypes':['vim','sh','ruby'],
    "      \'passive_filetypes':['html','python','javascript']
    "      \}

    " Shoe redo undo tree
    NeoBundleLazy 'Gundo', {
                \ "autoload": {"commands": ["GundoToggle"]}}

    " Coffee
    NeoBundleLazy 'vim-coffee-script', {
                \ "autoload": {"filetypes": ["coffee"]}}

    " JavaScript Indent
    NeoBundleLazy 'OOP-javascript-indentation', {
                \ "autoload": {"insert": 1}, "filetypes": ["javascript"]}

    " Ack
    NeoBundle 'ack.vim'

    " ag
    NeoBundle 'rking/ag.vim'

    " flake8
    NeoBundleLazy 'hynek/vim-python-pep8-indent', {
                \ "autoload": {"insert": 1, "filetypes": ["python", "python3", "djangohtml"]},}

    NeoBundleCheck
endif


filetype plugin indent on

let format_join_spaces = 4
let format_allow_over_tw = 1

" ====================================================
" File type settings
" ====================================================

filetype indent on
filetype plugin indent on
filetype plugin on

autocmd BufNewFile,BufRead *.ejs          set filetype=html
autocmd BufNewFile,BufRead *.pm           set filetype=perl
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

" Also python settings are ftplygin/python

autocmd FileType c   hi Comment ctermfg=darkcyan
autocmd FileType cpp hi Comment ctermfg=darkcyan
autocmd FileType cpp set tabstop=4 tw=0 sw=4 fenc=utf-8 expandtab

autocmd FileType GITCOMMIT set fenc=utf-8

autocmd BufRead /tmp/crontab.* :set nobackup nowritebackup

"autocmd BufWrite *.* :call didSaveFile()
"function! didSaveFile()
"
"endfunction


" path
let &path="~/dev/workspace,~"
let main_syntax="html"

" ====================================================
" Key Mappings
" ====================================================
nnoremap <Space>w :<C-u>update<CR>
nnoremap <Space>. :<C-u>edit $MYVIMRC<Enter>
nnoremap <Space>s. :<C-u>source $MYVIMRC<Enter>

" clear highlight
nnoremap <buffer> <ESC><ESC> :nohlsearch<CR><ESC>

" help
nnoremap <expr> <Space>h ':<C-u>help ' . expand('<cword>') . '<CR>'

" Directory Tree
nnoremap <Leader>d :<C-u>VimFilerExplorer<CR>

" line feed
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" scratch.vim
nnoremap <leader>so :<C-u>ScratchOpen<CR>
nnoremap <leader>sc :<C-u>ScratchClose<CR>

" gundo
nnoremap <leader>gl :<C-u>GundoToggle<CR>

" Use ClipBoard
vmap <silent> sy :!pbcopy; pbpaste<CR>
map <silent> sp v:!pbpaste<CR>

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
autocmd FileType python nnoremap <leader>py :<C-u>!python %<Enter>
autocmd FileType python nnoremap <leader>ln :call Flake8()<CR>
autocmd FileType python inoremap <buffer> ccc # -*- coding: utf-8 -*-
autocmd FileType python inoremap <buffer> iid logger.debug()<LEFT>
autocmd FileType python inoremap <buffer> iii logger.info()<LEFT>
autocmd FileType python inoremap <buffer> iiw logger.warning()<LEFT>
autocmd FileType python inoremap <buffer> iie logger.error()<LEFT>
autocmd FileType python inoremap <buffer> iic logger.critical()<LEFT>

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
vnoremap ` "zdi`<C-R>z`<ESC>
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap " "zdi"<C-R>z"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

" buffer control
nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>
nnoremap <C-W> :bd<CR>

" window move
nnoremap <C-J> <C-W>j
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
" Git commands
" :Gbrame
" :Gstatus
" :Gwrite -> git add
" :Gremove -> git rm
" :Gdiff
" :Gcommit

" autocmd QuickFixCmdPost grep,vimgrep cw
"
