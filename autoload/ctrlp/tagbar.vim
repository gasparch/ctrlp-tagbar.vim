" =============================================================================
" File:          autoload/ctrlp/tagbar.vim
" Description:   tagbar extension for ctrlp.vim
" =============================================================================

" Change the name of the g:loaded_ variable to make it unique
if ( exists('g:loaded_ctrlp_tagbar') && g:loaded_ctrlp_tagbar )
      \ || !exists(':TagbarToggle')
      \ || v:version < 700 || &cp
  finish
endif
let g:loaded_ctrlp_tagbar = 1

" The main variable for this extension.
"
" The values are:
" + the name of the input function (including the brackets and any argument)
" + the name of the action function (only the name)
" + the long and short names to use for the statusline
" + the matching type: line, path, tabs, tabe
"                      |     |     |     |
"                      |     |     |     `- match last tab delimited str
"                      |     |     `- match first tab delimited str
"                      |     `- match full line like file/dir path
"                      `- match full line
let s:tagbar_var = {
      \ 'init':   'ctrlp#tagbar#init()',
      \ 'accept': 'ctrlp#tagbar#accept',
      \ 'lname':  'tagbar',
      \ 'sname':  'tbar',
      \ 'type':   'line',
      \ 'sort':   0,
      \ 'nolim':  1,
      \ }


" Append s:tagbar_var to g:ctrlp_ext_vars
if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:tagbar_var)
else
  let g:ctrlp_ext_vars = [s:tagbar_var]
endif


" Provide a list of strings to search in
"
" Return: command
function! ctrlp#tagbar#init()
  let tag_list = []
  try
    let tagdict = tagbar#state#get_current_file(0)._tagdict
    let tag_list = keys(tagdict)
  catch
  endtry

  call filter(tag_list, '!empty(v:val)')
  return tag_list
endfunction


" The action to perform on the selected string.
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
func! ctrlp#tagbar#accept(mode, str)
  call ctrlp#exit()

  let taginfo = []
  try
    let tagsinfo = tagbar#state#get_current_file(0)
    let taginfo = tagsinfo.getTagsByName(a:str)
  catch
  endtry

  if !empty(taginfo)
    execute taginfo[0].fields.line
  endif
endfunc


" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
" Allow it to be called later
function! ctrlp#tagbar#id()
  return s:id
endfunction


" vim:fen:fdl=0:ts=2:sw=2:sts=2
