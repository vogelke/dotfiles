" Vim syntax file
" Language: crontab
" Maintainer: David Necas (Yeti) <yeti@physics.muni.cz>
" Original Maintainer: John Hoelzel johnh51@users.sourceforge.net
" License: This file can be redistribued and/or modified under the same terms
"   as Vim itself.
" Filenames: /tmp/crontab.* used by "crontab -e"
" URL: http://trific.ath.cx/Ftp/vim/syntax/crontab.vim
" Last Change: 2006-04-20
"
" crontab line format:
" Minutes   Hours   Days   Months   Days_of_Week   Commands # comments

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_crontab_syn_inits")
  if version < 508
    let did_crontab_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink crontabCmnt            Comment
  delcommand HiLink
endif

let b:current_syntax = "crontab"

" vim: ts=8
