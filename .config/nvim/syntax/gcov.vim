" Vim syntax file
" Language:     gcov (gcc coverage testing output)
" Maintainer:   Saikat Guha <saikat@cs.cornell.edu>
" Modified By:  Keith Rarick <kr@xph.us>
" Last Change:  2009-06-12

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Tag lines
syn match  gcovTag          "^\s*-:\s*0:" nextgroup=gcovTagName
syn match  gcovTagName      contained "[^:]\+" nextgroup=gcovTagColon
syn match  gcovTagColon contained ":" nextgroup=gcovTagValue
syn match  gcovTagValue     contained ".*$"

" Source lines
syn match  gcovNoCode       "^\s*-:\s*[1-9]\d*:.*"
syn match  gcovNotExecuted  "^\s*#####:\s*[1-9]\d*:.*"
syn match  gcovExecuted     "^\s*[1-9]\d*:\s*[1-9]\d*:.*"

" Basic blocks
syn match  gcovBlockNotExecuted   "^\s*\$\$\$\$\$:\s*[1-9]\d*-block\s\+\d*"
syn match  gcovBlockExecuted      "^\s*[1-9]\d*:\s*[1-9]\d*-block\s\+\d*"

" Branches
syn match  gcovBranchNotExecuted  "^branch\s\+\d* never executed"
syn match  gcovBranchTaken        "^branch\s\+\d* taken\s\+[1-9]\d*.*$"
syn match  gcovBranchNeverTaken   "^branch\s\+\d* taken\s\+0.*$"
syn match  gcovUBranchNotExecuted "^unconditional\s\+\d* never executed"
syn match  gcovUBranchTaken       "^unconditional\s\+\d* taken\s\+[1-9]\d*.*$"

" Calls
syn match  gcovCallNotExecuted    "^call\s\+\d* never executed"
syn match  gcovCallExecuted       "^call\s\+\d* returned\s\+\d*"

" Functions
syn match  gcovfunctionExecuted       "^function\s\+\w*\s\+called\s\+[1-9]\d*.*"
syn match  gcovfunctionNotExecuted    "^function\s\+\w*\s\+called\s\+0.*"

" Define the default highlighting.
" Only used when an item doesn't have highlighting yet
hi def link gcovTag                     Comment
hi def link gcovTagColon                Comment
hi def link gcovTagName                 Identifier
hi def link gcovTagValue                Constant
hi def link gcovNoCode                  Comment
hi def link gcovNotExecuted             Error
"hi def link gcovExecuted                none " no highlight

"hi def link gcovSpecialExecuted         none " no highlight
hi def link gcovSpecialNotExecuted      Error


hi def link gcovBlockNotExecuted        gcovSpecialNotExecuted
hi def link gcovBlockExecuted           gcovSpecialExecuted

hi def link gcovBranchNotExecuted       gcovSpecialNotExecuted
hi def link gcovBranchTaken             gcovSpecialExecuted
hi def link gcovUBranchNotExecuted      gcovSpecialNotExecuted
hi def link gcovUBranchTaken            gcovSpecialExecuted
hi def link gcovBranchNeverTaken        gcovSpecialNotExecuted

hi def link gcovCallNotExecuted         gcovSpecialNotExecuted
hi def link gcovCallExecuted            gcovSpecialExecuted

hi def link gcovFunctionNotExecuted     gcovSpecialNotExecuted
hi def link gcovFunctionExecuted        gcovSpecialExecuted

let b:current_syntax = "gcov"

" vim: ts=8 sw=2 sts=2 et
