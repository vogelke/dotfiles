" https://www.reddit.com/r/vimporn/comments/fw91su/coral_theme/
" local syntax file - set colors on a per-machine basis:
" Vim color file

hi  clear
set background=dark
if exists('syntax_on')
  syntax  reset
endif

let colors_name = 'coral'

" theme
let g:colors_name="coral"
hi  Normal                cterm=none
hi  Comment               ctermfg=222
hi  Constant              ctermfg=14        cterm=none
hi  String                ctermfg=229
hi  ModeMsg               cterm=bold
hi  Number                ctermfg=116
hi  Float                 ctermfg=116
hi  Special               ctermfg=3
hi  SpecialChar           ctermfg=1
hi  Identifier            ctermfg=45
hi  Function              ctermfg=85
hi  Statement             ctermfg=210       cterm=bold
hi  PreProc               ctermfg=10
hi  Type                  ctermfg=6
hi  Special               ctermfg=213
hi  Error                 ctermbg=9
hi  Todo                  ctermfg=8         ctermbg=209
hi  Directory             ctermfg=224
hi  StatusLine            ctermfg=200       ctermbg=111       cterm=none
hi  Search                ctermbg=198
hi  LineNr                ctermfg=247
hi  DiffAdd               ctermbg=LightBlue
hi  DiffChange            ctermbg=89
hi  DiffDelete            ctermfg=Blue      ctermbg=LightCyan
hi  DiffText              ctermbg=Red       cterm=bold
" User colors
" git branch
hi  User1                 ctermbg=33        ctermfg=236
" git status
hi  User3                 ctermbg=123       ctermfg=40
hi  User4                 ctermbg=123       ctermfg=161
hi  User5                 ctermbg=123       ctermfg=39

