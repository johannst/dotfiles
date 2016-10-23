" dotfiles -- vim/colors/johannst
" author: johannst
" derived from buddy 

set background=dark
if version > 580
   hi clear
   if exists("syntax_on")
      syntax reset
   endif
endif

set t_Co=256
let g:colors_name = "johannst"

"{{{ Vim Basic 

hi Normal ctermfg=253 ctermbg=234 cterm=NONE
hi Folded ctermfg=146 ctermbg=238 cterm=NONE
hi Title ctermfg=230 ctermbg=NONE cterm=bold
hi Todo ctermfg=232 ctermbg=222 cterm=NONE
hi NonText ctermfg=247 ctermbg=236 cterm=NONE   
hi SpecialKey ctermfg=247 ctermbg=236 cterm=NONE
hi Visual ctermfg=230 ctermbg=238 cterm=NONE
hi VertSplit ctermfg=59 ctermbg=238 cterm=NONE

"}}}
"{{{ Cursor & LineNumber 

"hi Cursor       ctermfg=NONE  ctermbg=241  cterm=NONE
hi LineNr       ctermfg=239  ctermbg=234  cterm=NONE
hi CursorLineNR ctermfg=255  ctermbg=208  cterm=bold 
hi CursorLine   ctermfg=NONE ctermbg=236  cterm=NONE
hi CursorColumn ctermfg=NONE ctermbg=236  cterm=NONE
hi MatchParen   ctermfg=208  ctermbg=89   cterm=underline 

"}}}
"{{{ Tabline 

hi TabLine     ctermbg=235 ctermfg=244 cterm=none
hi TabLineSel  ctermbg=208 ctermfg=255 cterm=bold
hi TabLineFill ctermbg=235 ctermfg=0 cterm=NONE 
if exists('g:buftabline_enable')
   hi BufTabLineActive ctermbg=69
endif

"}}}
"{{{ Statusline 

hi StatusLine   ctermfg=0   ctermbg=38  cterm=NONE 
hi StatusLineNC ctermfg=144 ctermbg=238 cterm=NONE

"}}}
"{{{ Diff 

hi DiffChange ctermfg=10 ctermbg=17 cterm=NONE 
hi DiffText   ctermfg=10 ctermbg=88 cterm=NONE 
hi DiffAdd    ctermfg=10 ctermbg=17 cterm=NONE 
hi DiffDelete ctermfg=10 ctermbg=17 cterm=NONE 

"}}}
"{{{ Popup Menu 

hi PMenu      ctermfg=NONE ctermbg=235  cterm=NONE
hi PMenuSel   ctermfg=255  ctermbg=208  cterm=NONE
hi PMenuSbar  ctermfg=NONE ctermbg=NONE cterm=NONE
hi PMenuThumb ctermfg=NONE ctermbg=101  cterm=NONE

"}}}
"{{{ Language 

hi Comment ctermfg=144 ctermbg=NONE cterm=NONE
hi Label   ctermfg=221 ctermbg=NONE cterm=NONE

" TODO sort
hi Typedef ctermfg=11 ctermbg=NONE cterm=NONE
hi PreCondit ctermfg=167 ctermbg=NONE cterm=NONE
hi Identifier ctermfg=221 ctermbg=NONE cterm=NONE
hi Special ctermfg=221 ctermbg=NONE cterm=NONE
hi Delimiter ctermfg=194 ctermbg=NONE cterm=NONE
hi Operator ctermfg=11 ctermbg=NONE cterm=NONE
hi Function ctermfg=208 ctermbg=NONE cterm=NONE
hi Exception ctermfg=11 ctermbg=NONE cterm=NONE
hi Keyword ctermfg=11 ctermbg=NONE cterm=NONE
hi Tag ctermfg=194 ctermbg=NONE cterm=NONE

hi Define  ctermfg=167 ctermbg=NONE cterm=NONE
hi PreProc ctermfg=167 ctermbg=NONE cterm=NONE
hi Macro   ctermfg=167 ctermbg=NONE cterm=NONE
hi Include ctermfg=167 ctermbg=NONE cterm=NONE

hi Type         ctermfg=214 ctermbg=NONE cterm=NONE
hi Boolean      ctermfg=11  ctermbg=NONE cterm=NONE
hi Character    ctermfg=167 ctermbg=NONE cterm=NONE
hi SpecialChar  ctermfg=159 ctermbg=NONE cterm=NONE
hi String       ctermfg=81  ctermbg=NONE cterm=NONE
hi Constant     ctermfg=167 ctermbg=NONE cterm=NONE
hi Number       ctermfg=167 ctermbg=NONE cterm=NONE
hi Float        ctermfg=208 ctermbg=NONE cterm=NONE
hi Structure    ctermfg=214 ctermbg=NONE cterm=NONE
hi StorageClass ctermfg=208 ctermbg=NONE cterm=NONE

hi Repeat      ctermfg=11  ctermbg=NONE cterm=NONE
hi Statement   ctermfg=220 ctermbg=NONE cterm=NONE
hi Conditional ctermfg=11  ctermbg=NONE cterm=NONE

"}}}
"{{{ not classified yet 
"hi Debug ctermfg=194 ctermbg=NONE cterm=NONE
"hi IncSearch
"hi WildMenu
"hi SignColumn
"hi CTagsMember
"hi CTagsGlobalConstant
"hi ErrorMsg
"hi Ignore
"hi CTagsImport
"hi Search
"hi CTagsGlobalVariable
"hi SpellRare
"hi EnumerationValue
"hi Union
"hi Question
"hi WarningMsg
"hi VisualNOS
"hi ModeMsg
"hi FoldColumn
"hi EnumerationName
"hi MoreMsg
"hi SpellCap
"hi DiffChange
"hi SpellLocal
"hi Error
"hi DefinedName
"hi LocalVariable
"hi SpellBad
"hi CTagsClass
"hi Directory
"hi Underlined
"hi clear
"hi SpecialComment 
"}}}
