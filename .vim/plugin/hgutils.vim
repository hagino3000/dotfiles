"=============================================================================
" hgutils.vim : 
"=============================================================================
"
" Author:  Takeshi NISHIDA <ns9tks@DELETE-ME.gmail.com>
" Version: 0.1, for Vim 7.1
" Licence: MIT Licence
"
"
"=============================================================================
" DOCUMENT:
"
" Description: ---------------------------------------------------------- {{{1
"
" Installation: --------------------------------------------------------- {{{1
"
" Usage: ---------------------------------------------------------------- {{{1
"
" Options: -------------------------------------------------------------- {{{1
"
" ChangeLog: ------------------------------------------------------------ {{{1
"   0.1:
"     - First release.
"
" }}}1
"=============================================================================

" INCLUDE GUARD: ======================================================== {{{1
if v:version < 701
  echoerr "Sorry, hgutils.vim doesn't support this version of Vim."
  finish
elseif exists('loaded_hgutils')
  finish
endif
let loaded_hgutils = 1


" FUNCTION: ============================================================= {{{1

"-----------------------------------------------------------------------------
function! s:ExecHg(cmd, cwd, rev, arg)
  let opt_cwd = (a:cwd !~ '\S' ? '' : '--cwd ' . shellescape(a:cwd))
  let opt_rev = (a:rev !~ '\S' ? '' : '-r ' . a:rev)

  return system(join(['hg', a:cmd, opt_cwd, opt_rev, a:arg], ' '))
endfunction

"-----------------------------------------------------------------------------
function! s:DisplayInBuffer(text, name, ff)
  new
  call append(0, split(a:text, "\n"))
  normal gg0
  execute 'file ' . a:name
  let &l:filetype = a:ff
  setlocal buftype=nofile bufhidden=wipe noswapfile nomodifiable readonly
endfunction

"-----------------------------------------------------------------------------
function! s:DisplayInCmdline(text)
  echo a:text
endfunction

"-----------------------------------------------------------------------------
function! s:InputEx(cwd, pretext)
  echo a:pretext
  let branch = s:GetCurBranch(a:cwd)
  echohl Question
  let s = input('[' . branch . ']>')
  echohl None
  return s
endfunction

"-----------------------------------------------------------------------------
function! s:GetStatus(cwd)
  return s:ExecHg('status' , a:cwd, '', '')
endfunction

"-----------------------------------------------------------------------------
function! s:GetDiff(cwd, files)
  return s:ExecHg('diff' , a:cwd, '', s:FileListToCmdStr(a:files))
endfunction

"-----------------------------------------------------------------------------
function! s:GetHeads(cwd)
  return s:ExecHg('heads' , a:cwd, '', '')
endfunction

"-----------------------------------------------------------------------------
function! s:GetCurBranch(cwd)
  return matchstr(s:ExecHg('branch' , a:cwd, '', ''), "^[^\n]*")
endfunction

"-----------------------------------------------------------------------------
function! s:GetBranches(cwd)
  return s:ExecHg('branches' , a:cwd, '', '')
endfunction

"-----------------------------------------------------------------------------
function! s:GetNonCurBranches(cwd)
  let cur = s:GetCurBranch(a:cwd)
  return join(filter(split(s:GetBranches(a:cwd), "\n"), 'v:val[:len(cur) - 1] !=# cur'), "\n")
endfunction

"-----------------------------------------------------------------------------
function! s:GetTags(cwd)
  return s:ExecHg('tags' , a:cwd, '', '')
endfunction

"-----------------------------------------------------------------------------
function! s:GetLog(cwd)
  return s:ExecHg('log' , a:cwd, '', '')
endfunction

"-----------------------------------------------------------------------------
function! s:FileListToCmdStr(files)
  return join(map(a:files, 'shellescape(v:val)'), ' ')
endfunction

"-----------------------------------------------------------------------------
function! s:EchoHl(msg, hl)
  execute "echohl " . a:hl
  echo a:msg
  echohl None
endfunction

" FUNCTION: Hg: ============================================================= {{{1

"-----------------------------------------------------------------------------
function! s:HgAdd(cwd, files, msg)
  "TODO
endfunction

"-----------------------------------------------------------------------------
function! s:HgCommit(cwd, files, msg)
  if join(a:files) !~ '\S'
    call s:EchoHl("No files", "ErrorMsg")
    return
  endif

  let msg = (a:msg =~ '\S' ? a:msg : s:InputEx(a:cwd, join(a:files, "\n")))

  if msg !~ '\S'
    call s:EchoHl("Canceled", "ErrorMsg")
    return
  endif

  let opt_m = '-m ' . shellescape(msg)
  let opt_f = join(map(a:files, 'shellescape(v:val)'), ' ')

  call s:DisplayInCmdline(s:ExecHg('commit', a:cwd, '', opt_m .  ' ' . opt_f))
endfunction

"-----------------------------------------------------------------------------
function! s:HgCommitAll(cwd, msg)
  let msg = (a:msg =~ '\S' ? a:msg : s:InputEx(a:cwd, s:GetStatus(a:cwd)))

  if msg !~ '\S'
    call s:EchoHl("Canceled", "ErrorMsg")
    return
  endif

  let opt_m = '-m ' . shellescape(msg)

  call s:DisplayInCmdline(s:ExecHg('commit', a:cwd, '', opt_m .  ' -A'))
endfunction

"-----------------------------------------------------------------------------
function! s:HgTag(cwd, msg)
  let msg = (a:msg =~ '\S' ? a:msg : s:InputEx(a:cwd, s:GetTags(a:cwd)))

  if msg !~ '\S'
    call s:EchoHl("Canceled", "ErrorMsg")
    return
  endif

  call s:DisplayInCmdline(s:ExecHg('tag', a:cwd, '', shellescape(msg)))
endfunction

"-----------------------------------------------------------------------------
"TODO: 要テスト
function! s:HgBranch(cwd, msg)
  let msg = (a:msg =~ '\S' ? a:msg : s:InputEx(a:cwd, s:GetNonCurBranches(a:cwd)))

  if msg !~ '\S'
    call s:EchoHl("Canceled", "ErrorMsg")
    return
  endif

  call s:DisplayInCmdline(s:ExecHg('branch', a:cwd, '', shellescape(msg)))
endfunction

"-----------------------------------------------------------------------------
function! s:HgStatus(cwd)
  call s:DisplayInCmdline(s:GetStatus(a:cwd))
endfunction

"-----------------------------------------------------------------------------
function! s:HgHeads(cwd)
  call s:DisplayInCmdline(s:GetHeads(a:cwd))
endfunction

"-----------------------------------------------------------------------------
function! s:HgLog(cwd)
  call s:DisplayInBuffer(s:GetLog(a:cwd), '[HgLog]', '')
endfunction

"-----------------------------------------------------------------------------
function! s:HgDiff(cwd, files)
  let t = s:GetDiff(a:cwd, a:files)
  if len(t)
    call s:DisplayInBuffer(t, '[HgDiff]', 'diff')
  else
    echo "No changes"
  endif
endfunction


" GLOBAL OPTIONS: ======================================================= {{{1


" COMMANDS/AUTOCOMMANDS/MAPPINGS/ETC.: ================================== {{{1

command! -nargs=? HgCommit    call s:HgCommit   (expand('%:p:h'), [expand('%:p')], <q-args>)
command! -nargs=? HgCommitAll call s:HgCommitAll(expand('%:p:h'), <q-args>)
command! -nargs=? HgTag       call s:HgTag      (expand('%:p:h'), <q-args>)
command! -nargs=? HgBranch    call s:HgBranch   (expand('%:p:h'), <q-args>)
command! -nargs=0 HgStatus    call s:HgStatus   (expand('%:p:h'))
command! -nargs=0 HgHeads     call s:HgHeads    (expand('%:p:h'))
command! -nargs=0 HgLog       call s:HgLog      (expand('%:p:h'))
command! -nargs=0 HgDiff      call s:HgDiff     (expand('%:p:h'), [expand('%:p')])
command! -nargs=0 HgDiffAll   call s:HgDiff     (expand('%:p:h'), [])


" }}}1
"=============================================================================
" vim: set fdm=marker:

