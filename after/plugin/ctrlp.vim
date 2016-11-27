if !exists('g:loaded_ctrlp') || g:loaded_ctrlp == 0
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

if !get(g:, 'ctrlp_tagbar_disable', 0)
  command! CtrlPTagbar call ctrlp#init(ctrlp#tagbar#id())
endif

let &cpo = s:save_cpo
unlet s:save_cpo
