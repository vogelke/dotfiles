" https://github.com/VitaminFarmer/VIM_Themes
hi clear
syntax reset
let g:colors_name = "Jagpanther"
if &background == "light"
    hi Boolean gui=NONE guifg=#707070 guibg=NONE
    hi ColorColumn gui=NONE guifg=NONE guibg=#f5f5f5
    hi Comment gui=NONE guifg=#969696 guibg=NONE
    hi Conceal gui=NONE guifg=#707070 guibg=NONE
    hi Conditional gui=NONE guifg=#4a4a4a guibg=NONE
    hi Constant gui=NONE guifg=#707070 guibg=NONE
    hi Cursor gui=reverse guifg=NONE guibg=NONE
    hi CursorColumn gui=NONE guifg=NONE guibg=#f5f5f5
    hi CursorLine gui=NONE guifg=NONE guibg=#f5f5f5
    hi CursorLineNr gui=NONE guifg=#969696 guibg=NONE
    hi DiffAdd gui=NONE guifg=NONE guibg=#f0fff0
    hi DiffChange gui=NONE guifg=NONE guibg=#f5f5f5
    hi DiffDelete gui=NONE guifg=NONE guibg=#fff0f0
    hi DiffText gui=NONE guifg=NONE guibg=#e3e3e3
    hi Directory gui=NONE guifg=#4a4a4a guibg=NONE
    hi Error gui=NONE guifg=NONE guibg=#fff0f0
    hi ErrorMsg gui=NONE guifg=NONE guibg=#fff0f0
    hi FoldColumn gui=NONE guifg=#c2c2c2 guibg=NONE
    hi Folded gui=NONE guifg=#969696 guibg=NONE
    hi Ignore gui=NONE guifg=NONE guibg=NONE
    hi IncSearch gui=NONE guifg=NONE guibg=#e3e3e3
    hi LineNr gui=NONE guifg=#c2c2c2 guibg=NONE
    hi MatchParen gui=NONE guifg=NONE guibg=#e3e3e3
    hi ModeMsg gui=NONE guifg=NONE guibg=NONE
    hi MoreMsg gui=NONE guifg=NONE guibg=NONE
    hi NonText gui=NONE guifg=#c2c2c2 guibg=NONE
    hi Normal gui=NONE guifg=#000000 guibg=#ffffff
    hi Number gui=NONE guifg=#707070 guibg=NONE
    hi Pmenu gui=NONE guifg=NONE guibg=#f5f5f5
    hi PmenuSbar gui=NONE guifg=NONE guibg=#ededed
    hi PmenuSel gui=NONE guifg=NONE guibg=#e3e3e3
    hi PmenuThumb gui=NONE guifg=NONE guibg=#dbdbdb
    hi Question gui=NONE guifg=NONE guibg=NONE
    hi Search gui=NONE guifg=NONE guibg=#ededed
    hi SignColumn gui=NONE guifg=#c2c2c2 guibg=NONE
    hi Special gui=NONE guifg=#707070 guibg=NONE
    hi SpecialKey gui=NONE guifg=#c2c2c2 guibg=NONE
    hi SpellBad gui=undercurl guisp=NONE guifg=NONE guibg=#fff0f0
    hi SpellCap gui=undercurl guisp=NONE guifg=NONE guibg=NONE
    hi SpellLocal gui=undercurl guisp=NONE guifg=NONE guibg=#f0fff0
    hi SpellRare gui=undercurl guisp=NONE guifg=NONE guibg=#ededed
    hi Statement gui=NONE guifg=#4a4a4a guibg=NONE
    hi StatusLine gui=NONE guifg=#262626 guibg=#ededed
    hi StatusLineNC gui=NONE guifg=#969696 guibg=#ededed
    hi StorageClass gui=NONE guifg=#4a4a4a guibg=NONE
    hi String gui=NONE guifg=#707070 guibg=NONE
    hi TabLine gui=NONE guifg=#969696 guibg=#ededed
    hi TabLineFill gui=NONE guifg=NONE guibg=#ededed
    hi TabLineSel gui=NONE guifg=#262626 guibg=#ededed
    hi Title gui=NONE guifg=#707070 guibg=NONE
    hi Todo gui=standout guifg=NONE guibg=NONE
    hi Type gui=NONE guifg=#4a4a4a guibg=NONE
    hi Underlined gui=NONE guifg=NONE guibg=NONE
    hi VertSplit gui=NONE guifg=#e3e3e3 guibg=NONE
    hi Visual gui=NONE guifg=NONE guibg=#e3e3e3
    hi VisualNOS gui=NONE guifg=NONE guibg=NONE
    hi WarningMsg gui=NONE guifg=NONE guibg=#fff0f0
    hi WildMenu gui=NONE guifg=NONE guibg=#d1d1d1
    hi lCursor gui=NONE guifg=NONE guibg=NONE
    hi Identifier gui=NONE guifg=NONE guibg=NONE
    hi PreProc gui=NONE guifg=NONE guibg=NONE
elseif &background == "dark"
    hi Boolean gui=NONE guifg=#8f8f8f guibg=NONE
    hi ColorColumn gui=NONE guifg=NONE guibg=#1c1c1c
    hi Comment gui=NONE guifg=#3d3d3d guibg=NONE
    hi Conceal gui=NONE guifg=#8f8f8f guibg=NONE
    hi Conditional gui=NONE guifg=#5de2ee guibg=NONE
    hi Constant gui=NONE guifg=#8f8f8f guibg=NONE
    hi Cursor gui=reverse guifg=NONE guibg=NONE
    hi CursorColumn gui=NONE guifg=NONE guibg=#1c1c1c
    hi CursorLine gui=NONE guifg=NONE guibg=#1c1c1c
    hi CursorLineNr gui=NONE guifg=#808080 guibg=NONE
    hi DiffAdd gui=NONE guifg=NONE guibg=#003300
    hi DiffChange gui=NONE guifg=NONE guibg=#1c1c1c
    hi DiffDelete gui=NONE guifg=NONE guibg=#330000
    hi DiffText gui=NONE guifg=NONE guibg=#3b3b3b
    hi Directory gui=NONE guifg=#a1a1a1 guibg=NONE
    hi Error gui=NONE guifg=NONE guibg=#330000
    hi ErrorMsg gui=NONE guifg=NONE guibg=#330000
    hi FoldColumn gui=NONE guifg=#6e6e6e guibg=NONE
    hi Folded gui=NONE guifg=#808080 guibg=NONE
    hi Ignore gui=NONE guifg=NONE guibg=NONE
    hi IncSearch gui=NONE guifg=NONE guibg=#3b3b3b
    hi LineNr gui=NONE guifg=#6e6e6e guibg=NONE
    hi MatchParen gui=NONE guifg=NONE guibg=#3b3b3b
    hi ModeMsg gui=NONE guifg=NONE guibg=NONE
    hi MoreMsg gui=NONE guifg=NONE guibg=NONE
    hi NonText gui=NONE guifg=#8efbf2 guibg=#748b77
    hi Normal gui=undercurl guisp=NONE guifg=#c7c7c7 guibg=#1f1f1f
    hi Number gui=NONE guifg=#ff7376 guibg=NONE
    hi Pmenu gui=NONE guifg=NONE guibg=#1c1c1c
    hi PmenuSbar gui=NONE guifg=NONE guibg=#2b2b2b
    hi PmenuSel gui=NONE guifg=NONE guibg=#3b3b3b
    hi PmenuThumb gui=NONE guifg=NONE guibg=#4a4a4a
    hi Question gui=NONE guifg=NONE guibg=NONE
    hi Search gui=NONE guifg=NONE guibg=#2b2b2b
    hi SignColumn gui=NONE guifg=#6e6e6e guibg=NONE
    hi Special gui=NONE guifg=#4497df guibg=NONE
    hi SpecialKey gui=NONE guifg=#6e6e6e guibg=NONE
    hi SpellBad gui=undercurl guisp=NONE guifg=NONE guibg=#330000
    hi SpellCap gui=undercurl guisp=NONE guifg=NONE guibg=NONE
    hi SpellLocal gui=undercurl guisp=NONE guifg=NONE guibg=#003300
    hi SpellRare gui=undercurl guisp=NONE guifg=NONE guibg=#2b2b2b
    hi Statement gui=NONE guifg=#f1ecd5 guibg=NONE
    hi StatusLine gui=NONE guifg=#b3b3b3 guibg=#2b2b2b
    hi StatusLineNC gui=NONE guifg=#808080 guibg=#2b2b2b
    hi StorageClass gui=NONE guifg=#507790 guibg=NONE
    hi String gui=NONE guifg=#b79e85 guibg=NONE
    hi TabLine gui=NONE guifg=#808080 guibg=#2b2b2b
    hi TabLineFill gui=NONE guifg=NONE guibg=#2b2b2b
    hi TabLineSel gui=NONE guifg=#b3b3b3 guibg=#2b2b2b
    hi Title gui=NONE guifg=#8f8f8f guibg=NONE
    hi Todo gui=standout guifg=NONE guibg=NONE
    hi Type gui=NONE guifg=#ffa37f guibg=NONE
    hi Underlined gui=NONE guifg=NONE guibg=NONE
    hi VertSplit gui=NONE guifg=#3b3b3b guibg=NONE
    hi Visual gui=NONE guifg=NONE guibg=#3b3b3b
    hi VisualNOS gui=NONE guifg=NONE guibg=NONE
    hi WarningMsg gui=NONE guifg=NONE guibg=#330000
    hi WildMenu gui=NONE guifg=NONE guibg=#5c5c5c
    hi lCursor gui=NONE guifg=NONE guibg=NONE
    hi Identifier gui=NONE guifg=NONE guibg=NONE
    hi PreProc gui=NONE guifg=NONE guibg=NONE
endif
