
highlight CursorIM guibg=Purple guifg=NONE
highlight Search guibg=DarkBlue guifg=NONE

if has("gui_macvim")
  "set gfn=Osaka-Mono:h14
  "set gfw=Osaka-Mono:h14
  set columns=180
  set lines=55
  set transparency=10
  colorscheme slate
  "set guioptions-=T
  set migemo
elseif has("gui_mac")
  set gfn=Osaka-Mono:h14
  set gfw=Osaka-Mono:h14
  set macatsui
  set noantialias
  set transparency=240
  colorscheme dw_purple
  
  highlight IMLine guibg=DarkGreen guifg=Black
  
  map <D-w> :q<CR>gT
  map <D-t> :tabnew<CR>
  map <D-n> :new<CR>
  map <D-S-t> :browse tabe<CR>
  map <D-S-n> :browse split<CR>
  map <D-]> :tabn<CR>
  map <D-[> :tabp<CR>
  map <D-M-Right> :tabn<CR>
  map <D-M-Left> :tabp<CR>
  imap <D-M-Right> <C-o>:tabn<CR>
  imap <D-M-Left> <C-o>:tabp<CR>
end

autocmd VimEnter * tab all
autocmd BufAdd * exe 'tablast | tabe "' . expand( "<afile") .'"'

" au GUIEnter * simalt ~x

" 入力モード時、ステータスラインのカラーを変更
augroup InsertHook
	autocmd!
	autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
	autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

"日本語入力をリセット
" au BufNewFile,BufRead * set iminsert=0
"タブ幅をリセット
" au BufNewFile,BufRead * set tabstop=4 shiftwidth=4
" .txtファイルで自動的に日本語入力ON
" au BufNewFile,BufRead *.txt set iminsert=2
".rhtmlと.rbでタブ幅を変更
" au BufNewFile,BufRead *.rhtml   set nowrap tabstop=2 shiftwidth=2
" au BufNewFile,BufRead *.rb  set nowrap tabstop=2 shiftwidth=2
"全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

