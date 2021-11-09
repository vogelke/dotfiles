" LOCAL VERSION based on morning plus murphy
"
" $Revision: 1.2+1 $ $Date: 2016-11-25 19:29:25-05 $
" $Source: /home/vogelke/.vim/colors/RCS/local.vim,v $
" $Host: furbag.my.domain $
" $UUID: c58d3691-c09d-50d0-bf5d-259697b44828 $
"
" Reset background, then reset everything to defaults:
highlight clear

set background=dark
if exists("syntax_on")
  syntax reset
endif

let colors_name   = "local+murphy"
let g:colors_name = "local+murphy"

" First set Normal to regular black on light-gray
hi Normal       ctermfg=Black ctermbg=255      guifg=Black guibg=255
hi StatusLine   ctermfg=white ctermbg=darkgray cterm=NONE
hi StatusLineNC ctermfg=blue  ctermbg=darkgray cterm=NONE

hi Comment    term=bold          ctermfg=LightRed   guifg=Orange
hi Constant   term=underline     ctermfg=LightGreen guifg=White   gui=NONE
hi Identifier term=underline     ctermfg=LightCyan  guifg=#00ffff
hi Ignore     ctermfg=black      guifg=bg
hi PreProc    term=underline     ctermfg=LightBlue  guifg=Wheat
hi Search     term=reverse       guifg=white        guibg=Blue
hi Special    term=bold          ctermfg=LightRed   guifg=magenta
hi Statement  term=bold          ctermfg=Yellow     guifg=#ffff00 gui=NONE
hi Type       ctermfg=LightGreen guifg=grey         gui=none
hi Error      term=reverse       ctermbg=Red        ctermfg=White guibg=Red        guifg=White
hi Todo       term=standout      ctermbg=Yellow     ctermfg=Black guifg=Blue       guibg=Yellow

" From the source:
hi Cursor       guifg=Orchid      guibg=fg
hi Directory    term=bold         ctermfg=LightCyan    guifg=Cyan
hi ErrorMsg     term=standout     ctermbg=DarkRed      ctermfg=White guibg=Red      guifg=White
hi IncSearch    term=reverse      cterm=reverse        gui=reverse
hi LineNr       term=underline    ctermfg=Yellow       guifg=Yellow
hi ModeMsg      term=bold         cterm=bold           gui=bold
hi MoreMsg      term=bold         ctermfg=LightGreen   gui=bold      guifg=SeaGreen
hi NonText      term=bold         ctermfg=Blue         gui=bold      guifg=Blue
hi Question     term=standout     ctermfg=LightGreen   gui=bold      guifg=Cyan
hi SpecialKey   term=bold         ctermfg=LightBlue    guifg=Cyan
hi StatusLine   term=reverse,bold cterm=reverse        gui=NONE      guifg=White    guibg=darkblue
hi StatusLineNC term=reverse      cterm=reverse        gui=NONE      guifg=white    guibg=#333333
hi Title        term=bold         ctermfg=LightMagenta gui=bold      guifg=Pink
hi WarningMsg   term=standout     ctermfg=LightRed     guifg=Red
hi Visual       term=reverse      cterm=reverse        gui=NONE      guifg=white    guibg=darkgreen

