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
if which zoxide &> /dev/null; then
    zshPlug 'ajeetdsouza/zoxide'
fi


# Key definition

# Use `Ctrl-v` + key-combination of interest to find key codes.
typeset -A key
key[Up]="\e[A"
key[Down]="\e[B"
key[CtrlLeft]="\e[1;5D"
key[CtrlRight]="\e[1;5C"
key[AltLeft]="\e[1;3D"
key[AltRight]="\e[1;3C"
key[ShiftTab]="\e[Z"
key[CtrlA]="\Ca"
key[CtrlE]="\Ce"
key[CtrlR]="\Cr"
key[CtrlS]="\Cs"
key[CtrlW]="\Cw"
key[Backspace]="\C?"
key[CtrlBackspace]="\CH"


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
alias grep='\grep --color=auto -Hn'

alias fd="fd --color auto --no-ignore"
alias rg="rg --color auto --no-ignore"


# Basic environment

export PS_FORMAT='pid,pgid,etime,user,comm'


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

# Set vim as default mode
bindkey -v

autoload -Uz up-line-or-beginning-search && zle -N up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search && zle -N down-line-or-beginning-search

bindkey -- "$key[Up]" up-line-or-beginning-search
bindkey -- "$key[Down]" down-line-or-beginning-search

# Emacs mode

# Backward delete word without treating '/' as part of a word. Convenient when deleting paths.
function emacs-backward-kill-word() {
    # WORDCHARS
    #   A list of non-alphanumeric characters considered part of a word by the line editor.

    # Remove '/' from WORDCHARS
    local WORDCHARS=${WORDCHARS/\//}
    zle backward-kill-word
}
zle -N emacs-backward-kill-word

bindkey -M emacs "$key[CtrlLeft]" backward-word
bindkey -M emacs "$key[AltLeft]" backward-word
bindkey -M emacs "$key[CtrlRight]" forward-word
bindkey -M emacs "$key[AltRight]" forward-word
bindkey -M emacs "$key[CtrlBackspace]" emacs-backward-kill-word

# Vi mode

bindkey -M vicmd "$key[Up]" up-line-or-beginning-search
bindkey -M viins "$key[Up]" up-line-or-beginning-search
bindkey -M vicmd "$key[Down]" down-line-or-beginning-search
bindkey -M viins "$key[Down]" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search
bindkey -M viins "jj" vi-cmd-mode

bindkey -M vicmd "$key[CtrlA]" vi-digit-or-beginning-of-line
bindkey -M viins "$key[CtrlA]" vi-digit-or-beginning-of-line
bindkey -M vicmd "$key[CtrlE]" vi-end-of-line
bindkey -M viins "$key[CtrlE]" vi-end-of-line

bindkey -M viins "$key[CtrlR]" history-incremental-search-backward
bindkey -M viins "$key[CtrlS]" history-incremental-search-forward

bindkey -M viins "$key[CtrlW]" backward-kill-word
bindkey -M viins "$key[Backspace]" backward-delete-char
bindkey -M viins "$key[CtrlBackspace]" emacs-backward-kill-word


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

# https://github.com/ohmyzsh/ohmyzsh/issues/5068
function shpwd() {
  echo ${${:-/${(j:/:)${(M)${(s:/:)${(D)PWD:h}}#(|.)[^.]}}/${PWD:t}}//\/~/\~}
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
       c_usr='%F{2}'
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

       PS1="$c_usr%n@%m:$c_dir$(shpwd)$color[noColor] ::<$vimode> $(git_info)$c_ret%(?..%? )$c_del$color[noColor]> "
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


# fzf
function load_fzf() {
    [[ $- == *i* ]] || return

    local fzf_dir=(
        /usr/share/fzf
        $FZF_BASE
        $FZF_BASE/shell
    )

    local found=0
    for dir in $fzf_dir; do
        [[ -f $dir/key-bindings.zsh ]] && {
            source "$dir/key-bindings.zsh"
            source "$dir/completion.zsh"
            found=1
            break
        }
    done
    [[ $found == 0 ]] && echo "[WARN]: Failed to setup fzf, try setting FZF_BASE"
}

if which fzf &> /dev/null; then
    load_fzf
fi

#% vim:et:fen:fdm=marker:fmr={{{,}}}:fdl=0:fdc=1
