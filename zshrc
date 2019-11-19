# dotfiles -- zshrc
# author: johannst


ZDOTDIR=$HOME/.cache/zsh
[[ ! -d $ZDOTDIR ]] && mkdir -p $ZDOTDIR

# zshPlug -- simple GitHub plugin installer

# $1: [req]    github repository
# $2: [opt]    sub-folder containing *plugin.zsh file
function zshPlug() {
   local install=$HOME/.zshplug
   local git_repo=$1

   # download
   [[ ! -d $install/$git_repo ]] && {
      echo "[zshPlug]: installing $git_repo"
      git clone https://github.com/$git_repo $install/$git_repo &> /dev/null
   }

   # load plugin
   local plugin=$git_repo/$2
   local init=$(ls $install/$plugin/*plugin.zsh)
   [[ ! -f $init ]] && {
      echo "No plugin file found for $plugin, skipping ..."
   } || {
      source $init
   }
}

# Plugins

zshPlug 'zsh-users/zsh-autosuggestions'
zshPlug 'chriskempson/base16-shell'

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

# Color definition

typeset -A color
color[noColor]='%f'
color[darkGray]='%F{242}'
color[mediumGray]='%F{246}'
color[lightGray]='%F{252}'
color[brightRed]='%F{196}'
color[pinkRed]='%F{125}'
color[babyBlue]='%F{38}'
color[darkBlue]='%F{26}'
color[green]='%F{2}'
color[lightOrange]='%F{222}'


# Basic settings

setopt correctall
setopt hist_ignore_all_dups
setopt interactivecomments

# Basic alias

if ! which exa &> /dev/null; then
   alias ls='ls --color=auto'
   alias ll='ls --color=auto -l'
   alias la='ls --color=auto -a'
   alias lt='ls --color=auto -l -t --reverse'
else
   alias ls='exa --color=auto --git'
   alias ll='exa --color=auto --git -l'
   alias la='exa --color=auto --git -a'
   alias lt='exa --color=auto --git -l --sort newest'
fi
alias grep='\grep --color=auto -HIn'
alias rgrep='\grep --color=auto -HIrn'

# Colorful man pages

man() {
    LESS_TERMCAP_md=$'\e[01;35m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;31;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# History

HISTFILE=~/.zshist
HISTSIZE=1000
SAVEHIST=1000

# Completion

autoload -Uz compinit && compinit
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
# keep matches of same type in separate lists
zstyle ':completion:*' group-name ''
# description for each match list (%d expdanded to short desc)
zstyle ':completion:*:descriptions' format "$color[lightOrange] -- %d --$color[noColor]"

zmodload zsh/complist
bindkey -M menuselect "$key[ShiftTab]" reverse-menu-complete

# Key mappings

autoload -Uz up-line-or-beginning-search && zle -N up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search && zle -N down-line-or-beginning-search

[[ -n "$key[Up]" ]] && bindkey -- "$key[Up]" up-line-or-beginning-search || echo FALE
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search || echo FALE

# Vi mode

bindkey -v

[[ -n "$key[Up]" ]] && bindkey -M vicmd "$key[Up]" up-line-or-beginning-search
[[ -n "$key[Up]" ]] && bindkey -M viins "$key[Up]" up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -M vicmd "$key[Down]" down-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -M viins "$key[Down]" down-line-or-beginning-search
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

# Prompt: git helper

function git_info() {
   # check if in git repo, can this be cheaper?
   if ! git rev-parse --git-dir &> /dev/null; then return; fi

   # get current branch
   local branch=$(command git symbolic-ref --short HEAD 2> /dev/null)
   # check if tree is dirty
   local dirty=$(command git status --porcelain 2> /dev/null | wc -l)
   [[ $dirty -ne 0 ]] && {
      dirty="$GIT_PROMPT_DIRTY+$dirty"
   } || {
      dirty=$GIT_PROMPT_CLEAN
   }
   # check if branch is ahead
   local ahead
   [[ -n $(command git rev-list origin/${branch}..HEAD 2> /dev/null) ]] && {
      ahead=$GIT_PROMPT_AHEAD
   }

   # assemble git prompt info
   echo -n "${GIT_PROMPT_PREFIX}${branch}${dirty}${ahead}${GIT_PROMPT_SUFFIX}"
}

# Prompt

function printBase16() {
   for i in $(seq 0 15); do
      print -P "%F{$i} Color $i %f";
   done
}

function _installMyPrompt() {
   function zle-line-init zle-keymap-select {
       vinorm='n'
       viins='i'
       vimode="${${KEYMAP/vicmd/$color[pinkRed]$vinorm}/(main|viins)/$color[babyBlue]$viins}$color[noColor]"
       PS1="$color[mediumGray]%n$color[brightRed]::$color[lightGray]%m$color[brightRed]:$color[darkGray]%2~$color[noColor] [$vimode] $color[brightRed]%(?..%? )$color[noColor]> "
       RPS1="%F$color[darkBlue]%~$color[noColor]"
       zle reset-prompt
   }

   zle -N zle-line-init
   zle -N zle-keymap-select
}

function _installMyPromptBase16() {
   function zle-line-init zle-keymap-select {
       vinorm='n'
       viins='i'
       c_del='%F{7}'
       c_usr='%F{6}'
       c_hos='%F{5}'
       c_tty='%F{8}'
       c_dir='%F{14}'
       c_dir2='%F{242}'
       c_ret='%F{1}'
       c_vii='%F{14}'
       c_vic='%F{16}'
       vimode="${${KEYMAP/vicmd/$c_vic$vinorm}/(main|viins)/$c_vii$viins}$color[noColor]"

       c_git_branch='%F{5}'
       c_git_dirty='%F{9}'
       c_git_ahead='%F{4}'
       GIT_PROMPT_PREFIX="${c_del}(${c_git_branch}"
       GIT_PROMPT_DIRTY="${c_del}:${c_git_dirty}Δ"
       GIT_PROMPT_CLEAN=""
       GIT_PROMPT_AHEAD="${c_del}:${c_git_ahead}↑"
       GIT_PROMPT_SUFFIX="${c_del})$color[noColor] "

       PS1="$c_usr%n$c_del::$c_hos%m$c_del:$c_dir%2~$color[noColor] [$vimode] $(git_info)$c_ret%(?..%? )$c_del$color[noColor]> "
       RPS1="%F$c_dir2%~$color[noColor]"
       zle reset-prompt
   }

   zle -N zle-line-init
   zle -N zle-keymap-select
}

function _uninstallMyPrompt() {
   zle -D zle-line-init
   zle -D zle-keymap-select
}

#_installMyPrompt
_installMyPromptBase16

# hooks see man zshmisc(1)

function preexec_cmdTime() {
    timer=$SECONDS
}

function precmd_cmdTime() {
    [[ ! -z $timer ]] &&  print -P "\-> $color[green]$(($SECONDS - $timer))$color[noColor]s"
}

function enableCmdTime() {
    preexec_functions+=(preexec_cmdTime)
    precmd_functions+=(precmd_cmdTime)
}

function disableCmdTime() {
    preexec_functions=(${preexec_functions#preexec_cmdTime})
    precmd_functions=(${precmd_functions#precmd_cmdTime})
}

# need to do after compinit
zshPlug 'zsh-users/zsh-syntax-highlighting'

#% vim:et:fen:fdm=marker:fmr={{{,}}}:fdl=0:fdc=1
