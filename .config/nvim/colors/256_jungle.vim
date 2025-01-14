if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "256_jungle"
set background=dark

"hi IncSearch -- no settings --
"hi WildMenu -- no settings --
hi SignColumn guifg=#dadada guibg=#1c1c1c guisp=#1c1c1c gui=NONE ctermfg=253 ctermbg=234 cterm=NONE
hi SpecialComment guifg=#d78700 guibg=NONE guisp=NONE gui=NONE ctermfg=172 ctermbg=NONE cterm=NONE
hi Typedef guifg=#d75f00 guibg=NONE guisp=NONE gui=NONE ctermfg=166 ctermbg=NONE cterm=NONE
"hi Title -- no settings --
hi Folded guifg=#af5f87 guibg=NONE guisp=NONE gui=NONE ctermfg=132 ctermbg=NONE cterm=NONE
hi PreCondit guifg=#767676 guibg=NONE guisp=NONE gui=NONE ctermfg=243 ctermbg=NONE cterm=NONE
hi Include guifg=#767676 guibg=NONE guisp=NONE gui=NONE ctermfg=243 ctermbg=NONE cterm=NONE
hi TabLineSel guifg=#8787d7 guibg=#303030 guisp=#303030 gui=NONE ctermfg=104 ctermbg=236 cterm=NONE
hi StatusLineNC guifg=#a8a8a8 guibg=#4e4e4e guisp=#4e4e4e gui=NONE ctermfg=248 ctermbg=239 cterm=NONE
"hi CTagsMember -- no settings --
hi NonText guifg=#8787ff guibg=NONE guisp=NONE gui=NONE ctermfg=105 ctermbg=NONE cterm=NONE
"hi CTagsGlobalConstant -- no settings --
hi DiffText guifg=#d700ff guibg=#808080 guisp=#808080 gui=NONE ctermfg=165 ctermbg=8 cterm=NONE
hi ErrorMsg guifg=#d70000 guibg=#8a8a8a guisp=#8a8a8a gui=NONE ctermfg=160 ctermbg=245 cterm=NONE
hi Ignore guifg=#ffd75f guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi Debug guifg=#d78700 guibg=NONE guisp=NONE gui=NONE ctermfg=172 ctermbg=NONE cterm=NONE
hi PMenuSbar guifg=#9e9e9e guibg=#121212 guisp=#121212 gui=NONE ctermfg=247 ctermbg=233 cterm=NONE
hi Identifier guifg=#afaf00 guibg=NONE guisp=NONE gui=NONE ctermfg=142 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#d78700 guibg=NONE guisp=NONE gui=NONE ctermfg=172 ctermbg=NONE cterm=NONE
hi Conditional guifg=#d75f00 guibg=NONE guisp=NONE gui=NONE ctermfg=166 ctermbg=NONE cterm=NONE
hi StorageClass guifg=#d75f00 guibg=NONE guisp=NONE gui=NONE ctermfg=166 ctermbg=NONE cterm=NONE
hi Todo guifg=#d70087 guibg=NONE guisp=NONE gui=NONE ctermfg=162 ctermbg=NONE cterm=NONE
hi Special guifg=#d78700 guibg=NONE guisp=NONE gui=NONE ctermfg=172 ctermbg=NONE cterm=NONE
hi LineNr guifg=#808080 guibg=#121212 guisp=#121212 gui=NONE ctermfg=8 ctermbg=233 cterm=NONE
hi StatusLine guifg=#00afff guibg=#4e4e4e guisp=#4e4e4e gui=NONE ctermfg=39 ctermbg=239 cterm=NONE
hi Normal guifg=#dadada guibg=0 guisp=#1c1c1c gui=NONE ctermfg=253 ctermbg=0 cterm=NONE
hi Label guifg=#d75f00 guibg=NONE guisp=NONE gui=NONE ctermfg=166 ctermbg=NONE cterm=NONE
"hi CTagsImport -- no settings --
hi PMenuSel guifg=#5f87ff guibg=#080808 guisp=#080808 gui=NONE ctermfg=69 ctermbg=232 cterm=NONE
hi Search guifg=#af005f guibg=NONE guisp=NONE gui=NONE ctermfg=125 ctermbg=NONE cterm=NONE
"hi CTagsGlobalVariable -- no settings --
hi Delimiter guifg=#d78700 guibg=NONE guisp=NONE gui=NONE ctermfg=172 ctermbg=NONE cterm=NONE
hi Statement guifg=#d78700 guibg=NONE guisp=NONE gui=NONE ctermfg=172 ctermbg=NONE cterm=NONE
"hi SpellRare -- no settings --
"hi EnumerationValue -- no settings --
hi Comment guifg=#585858 guibg=NONE guisp=NONE gui=NONE ctermfg=240 ctermbg=NONE cterm=NONE
hi Character guifg=#5fd700 guibg=NONE guisp=NONE gui=NONE ctermfg=76 ctermbg=NONE cterm=NONE
"hi Float -- no settings --
hi Number guifg=#5fd700 guibg=NONE guisp=NONE gui=NONE ctermfg=76 ctermbg=NONE cterm=NONE
hi Boolean guifg=#d78700 guibg=NONE guisp=NONE gui=NONE ctermfg=172 ctermbg=NONE cterm=NONE
hi Operator guifg=#d75f00 guibg=NONE guisp=NONE gui=NONE ctermfg=166 ctermbg=NONE cterm=NONE
"hi CursorLine -- no settings --
"hi Union -- no settings --
hi TabLineFill guifg=#4e4e4e guibg=#4e4e4e guisp=#4e4e4e gui=NONE ctermfg=239 ctermbg=239 cterm=NONE
"hi Question -- no settings --
"hi WarningMsg -- no settings --
"hi VisualNOS -- no settings --
"hi DiffDelete -- no settings --
"hi ModeMsg -- no settings --
"hi CursorColumn -- no settings --
hi Define guifg=#767676 guibg=NONE guisp=NONE gui=NONE ctermfg=243 ctermbg=NONE cterm=NONE
hi Function guifg=#afaf00 guibg=NONE guisp=NONE gui=NONE ctermfg=142 ctermbg=NONE cterm=NONE
hi FoldColumn guifg=#af5f87 guibg=NONE guisp=NONE gui=NONE ctermfg=132 ctermbg=NONE cterm=NONE
hi PreProc guifg=#767676 guibg=NONE guisp=NONE gui=NONE ctermfg=243 ctermbg=NONE cterm=NONE
"hi EnumerationName -- no settings --
hi Visual guifg=#a8a8a8 guibg=#444444 guisp=#444444 gui=NONE ctermfg=248 ctermbg=238 cterm=NONE
"hi MoreMsg -- no settings --
"hi SpellCap -- no settings --
hi VertSplit guifg=#4e4e4e guibg=#4e4e4e guisp=#4e4e4e gui=NONE ctermfg=239 ctermbg=239 cterm=NONE
hi Exception guifg=#d75f00 guibg=NONE guisp=NONE gui=NONE ctermfg=166 ctermbg=NONE cterm=NONE
hi Keyword guifg=#d75f00 guibg=NONE guisp=NONE gui=NONE ctermfg=166 ctermbg=NONE cterm=NONE
hi Type guifg=#d75f00 guibg=NONE guisp=NONE gui=NONE ctermfg=166 ctermbg=NONE cterm=NONE
"hi DiffChange -- no settings --
hi Cursor guifg=#dadada guibg=#5f00ff guisp=#5f00ff gui=NONE ctermfg=253 ctermbg=57 cterm=NONE
"hi SpellLocal -- no settings --
hi Error guifg=NONE guibg=#ff0000 guisp=#ff0000 gui=NONE ctermfg=NONE ctermbg=196 cterm=NONE
hi PMenu guifg=#5f5fd7 guibg=#121212 guisp=#121212 gui=NONE ctermfg=62 ctermbg=233 cterm=NONE
hi SpecialKey guifg=#5faf00 guibg=NONE guisp=NONE gui=NONE ctermfg=70 ctermbg=NONE cterm=NONE
hi Constant guifg=#5fd700 guibg=NONE guisp=NONE gui=NONE ctermfg=76 ctermbg=NONE cterm=NONE
"hi DefinedName -- no settings --
hi Tag guifg=#d78700 guibg=NONE guisp=NONE gui=NONE ctermfg=172 ctermbg=NONE cterm=NONE
hi String guifg=#5fd700 guibg=NONE guisp=NONE gui=NONE ctermfg=76 ctermbg=NONE cterm=NONE
hi PMenuThumb guifg=#a8a8a8 guibg=#121212 guisp=#121212 gui=NONE ctermfg=248 ctermbg=233 cterm=NONE
"hi MatchParen -- no settings --
"hi LocalVariable -- no settings --
hi Repeat guifg=#d75f00 guibg=NONE guisp=NONE gui=NONE ctermfg=166 ctermbg=NONE cterm=NONE
"hi SpellBad -- no settings --
"hi CTagsClass -- no settings --
hi Directory guifg=#5f00ff guibg=#e4e4e4 guisp=#e4e4e4 gui=NONE ctermfg=57 ctermbg=254 cterm=NONE
hi Structure guifg=#d75f00 guibg=NONE guisp=NONE gui=NONE ctermfg=166 ctermbg=NONE cterm=NONE
hi Macro guifg=#767676 guibg=NONE guisp=NONE gui=NONE ctermfg=243 ctermbg=NONE cterm=NONE
"hi Underlined -- no settings --
"hi DiffAdd -- no settings --
hi TabLine guifg=#8a8a8a guibg=#4e4e4e guisp=#4e4e4e gui=NONE ctermfg=245 ctermbg=239 cterm=NONE
hi mbenormal guifg=#cfbfad guibg=#2e2e3f guisp=#2e2e3f gui=NONE ctermfg=187 ctermbg=237 cterm=NONE
hi perlspecialstring guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
hi doxygenspecial guifg=#fdd090 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE
hi mbechanged guifg=#eeeeee guibg=#2e2e3f guisp=#2e2e3f gui=NONE ctermfg=255 ctermbg=237 cterm=NONE
hi mbevisiblechanged guifg=#eeeeee guibg=#4e4e8f guisp=#4e4e8f gui=NONE ctermfg=255 ctermbg=60 cterm=NONE
hi doxygenparam guifg=#fdd090 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE
hi doxygensmallspecial guifg=#fdd090 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE
hi doxygenprev guifg=#fdd090 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE
hi perlspecialmatch guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
hi cformat guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
hi lcursor guifg=#404040 guibg=#8fff8b guisp=#8fff8b gui=NONE ctermfg=238 ctermbg=120 cterm=NONE
hi cursorim guifg=#404040 guibg=#8b8bff guisp=#8b8bff gui=NONE ctermfg=238 ctermbg=105 cterm=NONE
hi doxygenspecialmultilinedesc guifg=#ad600b guibg=NONE guisp=NONE gui=NONE ctermfg=130 ctermbg=NONE cterm=NONE
hi taglisttagname guifg=#808bed guibg=NONE guisp=NONE gui=NONE ctermfg=105 ctermbg=NONE cterm=NONE
hi doxygenbrief guifg=#fdab60 guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi mbevisiblenormal guifg=#cfcfcd guibg=#4e4e8f guisp=#4e4e8f gui=NONE ctermfg=252 ctermbg=60 cterm=NONE
hi user2 guifg=#7070a0 guibg=#3e3e5e guisp=#3e3e5e gui=NONE ctermfg=103 ctermbg=60 cterm=NONE
hi user1 guifg=#00ff8b guibg=#3e3e5e guisp=#3e3e5e gui=NONE ctermfg=48 ctermbg=60 cterm=NONE
hi doxygenspecialonelinedesc guifg=#ad600b guibg=NONE guisp=NONE gui=NONE ctermfg=130 ctermbg=NONE cterm=NONE
hi doxygencomment guifg=#ad7b20 guibg=NONE guisp=NONE gui=NONE ctermfg=130 ctermbg=NONE cterm=NONE
hi cspecialcharacter guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
"hi clear -- no settings --
hi underline guifg=#afafff guibg=NONE guisp=NONE gui=NONE ctermfg=147 ctermbg=NONE cterm=NONE
hi GitSignsChange guifg=yellow
