# Created by newuser for 4.3.10

typeset -g -A key
key[Up]="\e[A"
key[Down]="\e[B"
key[ShiftTab]="\e[Z"
key[CtrlA]="\Ca"
key[CtrlE]="\Ce"
key[CtrlR]="\Cr"
key[CtrlS]="\Cs"

HISTFILE=~/.zshist
HISTSIZE=1000
SAVEHIST=1000

autoload -Uz promptinit && promptinit
prompt walters

autoload -Uz compinit && compinit
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' menu select

bindkey -v

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search
bindkey -M viins "jj" vi-cmd-mode

bindkey -M vicmd "$key[CtrlA]" vi-digit-or-beginning-of-line
bindkey -M vicmd "$key[CtrlE]" vi-end-of-line
bindkey -M viins "$key[CtrlA]" vi-digit-or-beginning-of-line
bindkey -M viins "$key[CtrlE]" vi-end-of-line

bindkey -M viins "$key[CtrlR]" history-incremental-search-backward
bindkey -M viins "$key[CtrlS]" history-incremental-search-forward

[[ -n "$key[Up]" ]] && bindkey -- "$key[Up]" up-line-or-beginning-search || echo FALE
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search || echo FALE

zmodload zsh/complist
bindkey -M menuselect "$key[ShiftTab]" reverse-menu-complete

#setopt PRINT_EXIT_VALUE

#source ~/local/completion/fd/_fd
#source ~/local/completion/rg/_rg
