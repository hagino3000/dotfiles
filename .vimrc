" ====================================================
" Basic settings
" ====================================================
"
scriptencoding utf-8

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

let g:mapleader = ','

" ====================================================
" Dein @see https://github.com/Shougo/dein.vim
" ====================================================
if &compatible
  set nocompatible
endif
set runtimepath+=~/dev/dotfiles/vendor/dein/repos/github.com/Shougo/dein.vim

if dein#load_state(expand('~/dev/dotfiles/.vim/dein'))
  call dein#begin(expand('~/dev/dotfiles/.vim/dein'))

  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/vimproc.vim', {'build': 'make'})

  call dein#add('Shougo/neocomplete.vim', {'on_i': 1})
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/neosnippet')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('vim-scripts/Gundo', {'on_cmd': 'GundoToggle'})
  call dein#add('rking/ag.vim')

  call dein#add('thinca/vim-quickrun')
  let g:quickrun_config={'*': {
            \'hook/time/enable': '1',
            \'split': '%{winwidth(0) < winheight(0) + 200 ? "vertical" : ""}',
            \}}

  " Git ----------------------------------------------------------------
  call dein#add('tpope/vim-fugitive')
  nnoremap <leader>cs :<C-u>Gstatus<CR>
  nnoremap <leader>cd :<C-u>Gdiff<CR>

  " Unite --------------------------------------------------------------
  call dein#add('Shougo/unite.vim', {
              \'hook_add': '
              \" Use vimfiler to open directory
              \call unite#custom_default_action("source/bookmark/directory", "vimfiler")
              \call unite#custom_default_action("directory", "vimfiler")
              \call unite#custom_default_action("directory_mru", "vimfiler")
              \'
              \})

  " Use ag to grep
  if executable("ag")
      let g:unite_source_grep_command = "ag"
      let g:unite_source_grep_default_opts = "--nogroup --nocolor --column"
      let g:unite_source_grep_recursive_opt = ""
  endif

  nnoremap [unite] <Nop>
  nmap <leader>f [unite]
  nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
  nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
  nnoremap <silent> [unite]r :<C-u>Unite file_mru buffer<CR>
  nnoremap <silent> [unite]g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
  nnoremap <silent> [unite]v :<C-u>UniteResume search-buffer<CR>
  nnoremap <silent> [unite]s :<C-u>edit ~/dev/dotfiles/snippets/general.py<ENTER>

  " let g:unite_enable_start_insert = 1
  let g:unite_enable_ignore_case = 1
  let g:unite_enable_smart_case = 1

  " Configure keymaps
  function! s:unite_settings()
      "imap <buffer> <Esc><Esc> <Plug>(unite_exit)
      nmap <buffer> <C-W> <Plug>(unite_exit)
  endfunction
  autocmd FileType unite call s:unite_settings()

  " vimfiler -----------------------------------------------------------
  call dein#add('Shougo/vimfiler', {
              \'depends': ['unite.vim'],
              \'on_map': ['<Plug>(vimfiler_switch)'],
              \'on_cmd': ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
              \})

  function! s:vimfiler_settings()
      nmap <buffer> u <Plug>(vimfiler_switch_to_parent_directory)
      " Refresh (Because I want to use <C-l> to move window)
      nmap <buffer> R <Plug>(vimfiler_redraw_screen)
      " Back <C-l> to my setting
      nnoremap <buffer> <C-L> <C-W>l
  endfunction
  autocmd FileType vimfiler call s:vimfiler_settings()

  let g:vimfiler_ignore_pattern = '\%(\.DS_Store\|\.hg$\|\.git$\|\.pyc$\|\.pyo$\|\.o$\|\.swp$\|\.swo$\)'
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_enable_auto_cd = 1



  " Octave
  call dein#add('vim-scripts/octave.vim')

  " Enable scratch buffer
  call dein#add('vim-scripts/scratch')

  " Enable :SudoRead :SudoWrite
  call dein#add('vim-scripts/sudo.vim')

  " For go
  call dein#add('vim-jp/vim-go-extra', {'on_ft': 'go'})

  " For python --------------------------------------------------------
  call dein#add('nvie/vim-flake8', {'on_ft': ['python', 'python3']})
  call dein#add('hynek/vim-python-pep8-indent', {
              \'on_ft': ['python', 'python3'],
              \'on_i': 1
              \})

  " Refs http://qiita.com/ryo2851/items/125beff66e4106f7843c
  let g:jedi#use_tabs_not_buffers = 1
  let g:jedi#popup_select_first = 0
  let g:jedi#popup_on_dot = 0
  let g:jedi#completions_command = '<C-M>'
  let g:jedi#goto_assignments_command = '<leader>g'
  let g:jedi#goto_definitions_command = '<leader>d'
  let g:jedi#documentation_command = 'K'
  let g:jedi#usages_command = '<leader>n'
  let g:jedi#rename_command = '<leader>R' "quick-runと競合しないように
  autocmd FileType python setlocal completeopt-=preview

  call dein#add('davidhalter/jedi-vim', {
              \'on_ft': ['python', 'python3', 'djangohtml']
              \})


  " JavaScript
  call dein#add('vim-scripts/OOP-javascript-indentation', {'on_ft': 'javascript', 'on_i': 1})

  call dein#end()
  call dein#save_state()
endif

augroup PluginInstall
  autocmd!
  autocmd VimEnter * if dein#check_install() | call dein#install() | endif
augroup END


syntax on
syntax enable

let format_join_spaces = 4
let format_allow_over_tw = 1

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
nnoremap <Leader>e :<C-u>VimFilerExplorer<CR>

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
nnoremap <leader>gl :<C-u>GundoToggle<CR>

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
    autocmd FileType python nnoremap <leader>py :<C-u>!python %<Enter>
    autocmd FileType python nnoremap <leader>ln :call Flake8()<CR>
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
