" Vim color file - buddy_modified

set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "buddy"

"hi IncSearch -- no settings --
"hi WildMenu -- no settings --
"hi SignColumn -- no settings --
"hi CTagsMember -- no settings --
"hi CTagsGlobalConstant -- no settings --
"hi ErrorMsg -- no settings --
"hi Ignore -- no settings --
hi Normal guifg=#d9d9d9 guibg=#202020 guisp=#202020 gui=NONE ctermfg=253 ctermbg=234 cterm=NONE
"hi CTagsImport -- no settings --
"hi Search -- no settings --
"hi CTagsGlobalVariable -- no settings --
"hi SpellRare -- no settings --
"hi EnumerationValue -- no settings --
"hi Union -- no settings --
hi TabLine ctermbg=235 ctermfg=244 cterm=none
hi TabLineSel ctermbg=208 ctermfg=255 cterm=bold
hi TabLineFill ctermbg=235 ctermfg=0 cterm=NONE 
"TODO if tabline activated
hi BufTabLineActive ctermbg=69

"hi Question -- no settings --
"hi WarningMsg -- no settings --
"hi VisualNOS -- no settings --
"hi ModeMsg -- no settings --
"hi FoldColumn -- no settings --
"hi EnumerationName -- no settings --
"hi MoreMsg -- no settings --
"hi SpellCap -- no settings --
"hi DiffChange -- no settings --
"hi SpellLocal -- no settings --
"hi Error -- no settings --
"hi DefinedName -- no settings --
"hi LocalVariable -- no settings --
"hi SpellBad -- no settings --
"hi CTagsClass -- no settings --
"hi Directory -- no settings --
"hi Underlined -- no settings --
"hi clear -- no settings --
hi SpecialComment guifg=#f3cf64 guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi Typedef guifg=#fff200 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi Title guifg=#fffcf0 guibg=NONE guisp=NONE gui=bold ctermfg=230 ctermbg=NONE cterm=bold
hi Folded guifg=#b8c1ca guibg=#384048 guisp=#384048 gui=NONE ctermfg=146 ctermbg=238 cterm=NONE
hi PreCondit guifg=#c25643 guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE
hi Include guifg=#c25643 guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE
hi Float guifg=#e66450 guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE
hi StatusLineNC guifg=#9f9385 guibg=#444444 guisp=#444444 gui=NONE ctermfg=144 ctermbg=238 cterm=NONE
hi NonText guifg=#9a9a9a guibg=#303030 guisp=#303030 gui=NONE ctermfg=247 ctermbg=236 cterm=NONE

"hi DiffText guifg=NONE guibg=#575757 guisp=#575757 gui=NONE ctermfg=NONE ctermbg=240 cterm=NONE
"hi DiffChange guifg=NONE guibg=#575757 guisp=#575757 gui=NONE ctermfg=NONE ctermbg=DarkMagenta cterm=NONE
"hi DiffAdd guifg=NONE guibg=#5b802c guisp=#5b802c gui=NONE ctermfg=NONE ctermbg=2 cterm=NONE
"hi DiffDelete guifg=NONE guibg=#8a3636 guisp=#8a3636 gui=NONE ctermfg=NONE ctermbg=95 cterm=NONE
hi DiffChange cterm=NONE ctermfg=10 ctermbg=17 
hi DiffText   cterm=NONE ctermfg=10 ctermbg=88 
hi DiffAdd    cterm=NONE ctermfg=10 ctermbg=17 
hi DiffDelete cterm=NONE ctermfg=10 ctermbg=17 


hi PMenu ctermfg=NONE ctermbg=235 cterm=NONE
hi PMenuSel ctermfg=255 ctermbg=208 cterm=NONE

hi Debug guifg=#f0ffe2 guibg=NONE guisp=NONE gui=NONE ctermfg=194 ctermbg=NONE cterm=NONE
hi PMenuSbar guifg=NONE guibg=#000000 guisp=#000000 gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Identifier guifg=#f3cf64 guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#b5eeff guibg=NONE guisp=NONE gui=NONE ctermfg=159 ctermbg=NONE cterm=NONE
hi Conditional guifg=#fff200 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi StorageClass guifg=#f0911d guibg=NONE guisp=NONE gui=NONE ctermfg=208 ctermbg=NONE cterm=NONE
hi Todo guifg=#a9a9a9 guibg=NONE guisp=NONE gui=italic ctermfg=248 ctermbg=NONE cterm=NONE
hi Special guifg=#f3cf64 guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi LineNr guifg=#4d4d4d guibg=#1d1d1d guisp=#1d1d1d gui=NONE ctermfg=239 ctermbg=234 cterm=NONE
hi StatusLine ctermbg=38 ctermfg=0 cterm=NONE term=NONE gui=NONE
hi Label guifg=#f3cf64 guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi Delimiter guifg=#f0ffe2 guibg=NONE guisp=NONE gui=NONE ctermfg=194 ctermbg=NONE cterm=NONE
hi Statement guifg=#ffdd00 guibg=NONE guisp=NONE gui=NONE ctermfg=220 ctermbg=NONE cterm=NONE
hi Comment guifg=#b3b0a3 guibg=NONE guisp=NONE gui=italic ctermfg=144 ctermbg=NONE cterm=NONE
hi Character guifg=#e66450 guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE
hi Number guifg=#e66450 guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE
hi Boolean guifg=#fff200 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi Operator guifg=#fff200 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi CursorLine guifg=NONE guibg=#2d2d2d guisp=#2d2d2d gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi CursorColumn guifg=NONE guibg=#2d2d2d guisp=#2d2d2d gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi Define guifg=#c25643 guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE
hi Function guifg=#f0811f guibg=NONE guisp=NONE gui=NONE ctermfg=208 ctermbg=NONE cterm=NONE
hi PreProc guifg=#cc442f guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE
hi Visual guifg=#fffcf0 guibg=#444444 guisp=#444444 gui=NONE ctermfg=230 ctermbg=238 cterm=NONE
hi VertSplit guifg=#5e5e5e guibg=#444444 guisp=#444444 gui=NONE ctermfg=59 ctermbg=238 cterm=NONE
hi Exception guifg=#fff200 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi Keyword guifg=#fff200 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi Type guifg=#ffb700 guibg=NONE guisp=NONE gui=NONE ctermfg=214 ctermbg=NONE cterm=NONE
hi Cursor guifg=NONE guibg=#656565 guisp=#656565 gui=NONE ctermfg=NONE ctermbg=241 cterm=NONE
hi SpecialKey guifg=#9a9a9a guibg=#343434 guisp=#343434 gui=NONE ctermfg=247 ctermbg=236 cterm=NONE
hi Constant guifg=#e66450 guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE
hi Tag guifg=#f0ffe2 guibg=NONE guisp=NONE gui=NONE ctermfg=194 ctermbg=NONE cterm=NONE
hi String guifg=#5dd2fd guibg=NONE guisp=NONE gui=NONE ctermfg=81 ctermbg=NONE cterm=NONE
hi PMenuThumb guifg=NONE guibg=#857b6f guisp=#857b6f gui=NONE ctermfg=NONE ctermbg=101 cterm=NONE
hi MatchParen guifg=#fffcf0 guibg=#857b6f guisp=#857b6f gui=bold ctermfg=230 ctermbg=101 cterm=bold
hi Repeat guifg=#fff200 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi Structure guifg=#ffb700 guibg=NONE guisp=NONE gui=NONE ctermfg=214 ctermbg=NONE cterm=NONE
hi Macro guifg=#c25643 guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE
