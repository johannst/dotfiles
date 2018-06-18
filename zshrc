# dotfiles -- zshrc
# author: johannst

# Key definition

typeset -A key
key[Up]="\e[A"
key[Down]="\e[B"
key[ShiftTab]="\e[Z"
key[CtrlA]="\Ca"
key[CtrlE]="\Ce"
key[CtrlR]="\Cr"
key[CtrlS]="\Cs"
key[CtrlW]="\Cw"
key[BackSpace]="\C?"

# Basic settings

setopt correctall
setopt hist_ignore_all_dups

# Basic alias

alias ls='\ls --color=auto --classify'
alias ll='\ls --color=auto --classify -l'
alias la='\ls --color=auto --classify --almost-all'
alias lt='\ls --color=auto --classify -l -t --reverse'
alias grep='\grep --color=auto -HIn'
alias rgrep='\grep --color=auto -HIrn'
alias fn='_findName'
function _findName() {
   [[ -z $1 ]] && { echo "_findName pattern [path [action]]"; return } || { n=$1; shift }
   [[ -z $1 ]] && p=. || { p=$1; shift }
   [[ -z $1 ]] && find $p -name $n || find $p -name $n -exec $@ {} \;
}

# History

HISTFILE=~/.zshist
HISTSIZE=1000
SAVEHIST=1000

# Prompt

#autoload -Uz promptinit && promptinit
#prompt walters

# Completion

autoload -Uz compinit && compinit
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' menu select

zmodload zsh/complist
bindkey -M menuselect "$key[ShiftTab]" reverse-menu-complete

# Key mappings

autoload -Uz up-line-or-beginning-search && zle -N up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search && zle -N down-line-or-beginning-search

[[ -n "$key[Up]" ]] && bindkey -- "$key[Up]" up-line-or-beginning-search || echo FALE
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search || echo FALE

# Vi mode

bindkey -v

bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search
bindkey -M viins "jj" vi-cmd-mode

[[ -n "$key[CtrlA]" ]] && bindkey -M vicmd "$key[CtrlA]" vi-digit-or-beginning-of-line
[[ -n "$key[CtrlA]" ]] && bindkey -M viins "$key[CtrlA]" vi-digit-or-beginning-of-line
[[ -n "$key[CtrlE]" ]] && bindkey -M vicmd "$key[CtrlE]" vi-end-of-line
[[ -n "$key[CtrlE]" ]] && bindkey -M viins "$key[CtrlE]" vi-end-of-line

[[ -n "$key[CtrlR]" ]] && bindkey -M viins "$key[CtrlR]" history-incremental-search-backward
[[ -n "$key[CtrlS]" ]] && bindkey -M viins "$key[CtrlS]" history-incremental-search-forward

[[ -n "$key[CtrlW]" ]] && bindkey -M viins "$key[CtrlW]" backward-kill-word
[[ -n "$key[BackSpace]" ]] && bindkey -M viins "$key[BackSpace]" backward-delete-char

# Dirstack

DIRSTACKSIZE=8
setopt autopushd pushdminus pushdsilent pushdtohome
alias dh='dirs -v'
alias d='_goDir'
function _goDir() {
   cd -$1
}

# Prompt

typeset -A color
color[noColor]='%f'
color[darkGray]='%F{242}'
color[mediumGray]='%F{246}'
color[lightGray]='%F{252}'
color[brightRed]='%F{196}'
color[pinkRed]='%F{125}'
color[babyBlue]='%F{38}'
color[darkBlue]='%F{26}'

function _installMyPrompt() {
   function zle-line-init zle-keymap-select {
       vinorm='n'
       viins='i'
       vimode="${${KEYMAP/vicmd/$color[pinkRed]$vinorm}/(main|viins)/$color[babyBlue]$viins}$color[noColor]"
       PS1="$color[mediumGray]%n$color[brightRed]::$color[lightGray]%m$color[brightRed]:$color[darkGray]%l$color[noColor] [$vimode] $color[brightRed]%(?..%? )$color[noColor]> "
       RPS1="%F$color[darkBlue]%~%f"
       zle reset-prompt
   }

   zle -N zle-line-init
   zle -N zle-keymap-select
}

_installMyPrompt

#% vim:et:fen:fdm=marker:fmr={{{,}}}:fdl=0:fdc=1
