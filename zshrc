# dotfiles -- zshrc
# author: johannst


ZDOTDIR=$HOME/.cache/zsh
[[ ! -d $ZDOTDIR ]] && mkdir -p $ZDOTDIR


# {{{ func: zshPlug -- simple GitHub plugin installer.

function zshPlug() {
   local install=$HOME/.zshplug

   if [[ $1 == "update" ]]; then
       for dir in $install/**/.git; do
           local repo=$(dirname $dir)
           echo "=> Updating $repo"
           git -C $repo pull
       done
       return
   fi

   # Positinal:
   #   $1:            Github repository.
   # Arguments:
   #   -i <fname>     Init file name (optional).
   zparseopts -D -E -- i:=init
   local git_repo=$1
   local init_file=${init[2]:-*plugin.zsh}

   # Download plugin.
   if [[ ! -d $install/$git_repo ]]; then
      echo "[zshPlug]: Installing $git_repo ..."
      git clone https://github.com/$git_repo $install/$git_repo
   fi

   # Load plugin.
   local init=($install/$git_repo/$~init_file)
   if [[ -f $init ]]; then
      source $init
   else
      echo "No plugin file found for $git_repo, skipping ..."
   fi
}

# }}}
# {{{ func: executable -- check if executable is available.

function executable() {
    which $1 &> /dev/null
    return $?
}

# }}}
# {{{ func: man -- colored man pages.

function man() {
    # md/me   start/stop bold
    # so/se   start/stop standout
    # us/ue   start/stop underline
    LESS_TERMCAP_md=$'\e[01;35m'    \
    LESS_TERMCAP_me=$'\e[0m'        \
    LESS_TERMCAP_so=$'\e[01;31;33m' \
    LESS_TERMCAP_se=$'\e[0m'        \
    LESS_TERMCAP_us=$'\e[01;32m'    \
    LESS_TERMCAP_ue=$'\e[0m'        \
    command man "$@"
}

# }}}

# {{{ Plugins.

zshPlug 'zsh-users/zsh-autosuggestions'
zshPlug 'chriskempson/base16-shell'
# MesloLGS font: https://github.com/romkatv/powerlevel10k#manual-font-installation
#   eg: wget -P ~/.fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
zshPlug 'romkatv/powerlevel10k.git' -i powerlevel10k.zsh-theme

# }}}
# {{{ Key definitions.

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

# }}}
# {{{ Color definitions.

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

# }}}
# {{{ Basic settings.

#setopt correctall
setopt hist_ignore_all_dups
setopt interactivecomments

HISTFILE=$ZDOTDIR/zshist
HISTSIZE=1000
SAVEHIST=1000

# Dirstack
DIRSTACKSIZE=8
setopt autopushd pushdminus pushdsilent pushdtohome

# }}}
# {{{ Alias.

if executable exa; then
   alias ls='exa --color=auto --git'
   alias ll='exa --color=auto --git -l'
   alias la='exa --color=auto --git -a'
   alias lt='exa --color=auto --git -l --sort newest'
else
   alias ls='ls --color=auto'
   alias ll='ls --color=auto -l'
   alias la='ls --color=auto -a'
   alias lt='ls --color=auto -l -t --reverse'
fi

alias grep='\grep --color=auto -Hn'

alias fd="fd --color auto --no-ignore"
alias rg="rg --color auto --no-ignore"

if executable nvim; then
    alias vim='nvim'
fi

# }}}
# {{{ Environment.

export PS_FORMAT='pid,pgid,etime,user,comm'

# }}}
# {{{ Completion.

autoload -Uz compinit && compinit
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
# keep matches of same type in separate lists
zstyle ':completion:*' group-name ''
# description for each match list (%d expdanded to short desc)
zstyle ':completion:*:descriptions' format "$color[lightOrange] -- %d --$color[noColor]"

zmodload zsh/complist
bindkey -M menuselect "$key[ShiftTab]" reverse-menu-complete

# Needs to be initialized after `compinit`.
zshPlug 'zsh-users/zsh-syntax-highlighting'

# }}}
# {{{ Key mappings.

# Set vim as default mode
bindkey -v

# Up/Down only complete history items matching current prefix.
autoload -Uz up-line-or-beginning-search && zle -N up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search && zle -N down-line-or-beginning-search
bindkey -- "$key[Up]" up-line-or-beginning-search
bindkey -- "$key[Down]" down-line-or-beginning-search

# {{{ func: emacs-backward-kill-word -- backward kill word with custom excluded `WORDCHARS`.

# Backward delete word without treating '/' as part of a word. Convenient when deleting paths.
function emacs-backward-kill-word() {
    # WORDCHARS
    #   A list of non-alphanumeric characters considered part of a word by the line editor.

    # Remove '/' from WORDCHARS
    local WORDCHARS=${WORDCHARS/\//}
    zle backward-kill-word
}
zle -N emacs-backward-kill-word

#}}}
# {{{ Emacs mode.

bindkey -M emacs "$key[CtrlLeft]" backward-word
bindkey -M emacs "$key[AltLeft]" backward-word
bindkey -M emacs "$key[CtrlRight]" forward-word
bindkey -M emacs "$key[AltRight]" forward-word
bindkey -M emacs "$key[CtrlBackspace]" emacs-backward-kill-word

# }}}
# {{{ Vi mode.

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

# }}}

# }}}
# {{{ fzf.

if executable fzf; then
    # Only in interactive shells.
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
fi

# }}}

# vim:et:fen:fdm=marker:fmr={{{,}}}:fdl=0:fdc=1
