"
" File: csv2table.vim
" file created in 2014/08/18 14:10:01.
" LastUpdated:2014/08/18 15:27:27.
" Author: iNo <wdf7322@yahoo.co.jp>
" Version: 1.0
" License: MIT License {{{
"   Permission is hereby granted, free of charge, to any person obtaining
"   a copy of this software and associated documentation files (the
"   "Software"), to deal in the Software without restriction, including
"   without limitation the rights to use, copy, modify, merge, publish,
"   distribute, sublicense, and/or sell copies of the Software, and to
"   permit persons to whom the Software is furnished to do so, subject to
"   the following conditions:
"
"   The above copyright notice and this permission notice shall be included
"   in all copies or substantial portions of the Software.
"
"   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"

if exists('g:loaded_csv2table')
  finish
endif
let g:loaded_csv2table = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:convert(line)
  let str = "<tr>\n"
  for item in split(a:line, ",")
    let str .= "<td>" . item . "</td>\n"
  endfor
  let str .= "</tr>\n"
  return str
endfunction

function! s:csv2table(file)
  if filereadable(a:file)
    let resultStr = ''
    for line in readfile(a:file)
      let resultStr .= s:convert(line)
    endfor
    " 改行コード \n を正常に出力するために split を使用してリストを渡す
    " split の第3引数に非0の値を渡して空要素の除外を防ぐ
    call append(line('.'), split(resultStr, "", 1))
  else
    echoe 'File not found : ' . a:file
  endif
endfunction

command! -nargs=1 -complete=file Csv2table call s:csv2table(<q-args>)


let &cpo = s:save_cpo
unlet s:save_cpo

" vim:fdl=0 fdm=marker:ts=2 sw=2 sts=0:
