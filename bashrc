# dotfiles -- bashrc
# author: johannst

#{{{ general

if [ "$TERM" == "screen" ]; then export TERM=screen-256color; fi
if [ "$TERM" == "xterm" ]; then export TERM=xterm-256color; fi

# disable sticky mode
stty -ixon

# disable ctrl-d logoff
set -o ignoreeof on

# remove permissions for others when creating file/folder
umask 0027

function kbus {
	setxkbmap us
}

function kbde {
	setxkbmap de
}

#}}}
#{{{  bash mode

# list current readline mappings
# bind -p

function vimode {
	set -o vi
	bind -m vi-insert '"jj":vi-movement-mode'
	bind -m vi-insert 'Control-l:clear-screen'
	bind -m vi-command '"diw":"bdw"'
	bind -m vi-command 'Control-a:beginning-of-line'
	bind -m vi-command 'Control-e:end-of-line'
	bind -m vi-insert 'Control-a:beginning-of-line'
	bind -m vi-insert 'Control-e:end-of-line'
	bind -m vi-command '"v":""'   # disable opening tmp file
}

function normalmode {
	set -o emacs
}

# default mode
vimode

#}}}
#{{{ alias

alias ls='ls --color=auto -h'
alias ll='ls -lF'
alias la='ls -AF'
alias grep='grep --color=auto'
alias pstree="pstree -achpG ${USER}"
alias ps='ps -fxww --format user,pid,tty,stat,start,bsdtime,command'
alias pps='ps | grep -i $1'
alias penv='env | grep -i $1'
alias rsync='rsync --progress'

#}}}
#{{{ color definition

BCol_NoColor='\e[m'
BCol_DarkRed='\e[38;5;88m'
BCol_DarkOrange='\e[38;5;202m'
BCol_LightOrange='\e[38;5;208m'
#BCol_LightGray='\e[38;5;7m'
BCol_Yellow='\e[38;5;226m'
BCol_LightBlue='\e[38;5;74m'
BCol_BlueGray='\e[38;5;67m'
BCol_YellowOrange='\e[38;5;214m'

BCol_BrightRed='\e[38;5;196m'
BCol_DarkGray='\e[38;5;242m'
BCol_MediumGray='\e[38;5;246m'
BCol_LightGray='\e[38;5;252m'
BCol_DarkBlue='\e[38;5;26m'

BCol_BrightGreen='\e[38;5;40m'

#}}}
#{{{ bash prompt

#export PS1="[\s] \[${BCol_DarkRed}\]::\[${BCol_DarkOrange}\]\u\[${BCol_DarkRed}\]::\[${BCol_LightOrange}\]\H\[${BCol_LightGray}\]:$(tty) - \[${BCol_Yellow}\]\t\[${BCol_LightGray}\] - \[${BCol_LightBlue}\]\w\n\[${BCol_NoColor}\][\[${BCol_YellowOrange}\]\${?}\[${BCol_NoColor}\]] \[${BCol_BlueGray}\]>>\[${BCol_NoColor}\] "
# \s shell type
#export PS1="\[${BCol_BrightRed}\]::\[${BCol_MediumGray}\]\u\[${BCol_BrightRed}\]::\[${BCol_LightGray}\]\H\[${BCol_BrightRed}\]:\[${BCol_DarkGray}\]$(tty) \[${BCol_LightGray}\] - \[${BCol_DarkBlue}\]\w\n\
#\[${BCol_NoColor}\][\[${BCol_BrightGreen}\]\${?}\[${BCol_NoColor}\]] \$>\[${BCol_NoColor}\] "

#✓
#✗
function return_val_formater() {
	local ret=$1
	local ret_str
	if [[ $ret == 0 ]]; then
		ret_str='${BCol_BrightGreen}';
	else
		ret_str='${BCol_BrightRed}';
	fi
	ret_str+="$ret${BCol_NoColor}"
	echo -e "$ret_str";
}

function pwd_formater() {
	local pwd=$1
	local ret_str=$(echo $pwd | sed "s#[^A-Za-z]\+#\\${BCol_BrightRed}/\\${BCol_DarkBlue}#")
	echo -e "$ret_str";
}

export PS1="\[${BCol_BrightRed}\]::\[${BCol_MediumGray}\]\u\[${BCol_BrightRed}\]::\[${BCol_LightGray}\]\H\[${BCol_BrightRed}\]:\[${BCol_DarkGray}\]$(tty) \[${BCol_LightGray}\] - \[${BCol_DarkBlue}\]\w\n\
\[${BCol_NoColor}\][\$(ret=\$?; if [[ \$ret == 0 ]]; then echo \"\[${BCol_BrightGreen}\]\$ret\"; else echo \"\[${BCol_BrightRed}\]\$ret\"; fi)\[${BCol_NoColor}\]] \$> "

#$export PROMPT_COMMAND="echo -e ''"

#}}}
#{{{ ls colors

export LS_COLORS='di=94:ln=96:or=96;41:so=0:pi=0:ex=01;92:bd=0;42:cd=0;42:su=0:sg=0:tw=30;44:ow=30;44'

#}}}
#{{{ colored printers

function pline() {
	local col=$1
	local tag=$2
	local msg=$3
	echo -e "$col[$tag]: $msg${BCol_NoColor}"
}

function pinfo() {
	local msg=$1
	local tag=${2:-INFO}
	pline ${BCol_BrightGreen} $tag ${msg}
}

function pwarn () {
	local msg=$1
	local tag=${2:-WARN}
	pline ${BCol_YellowOrange} $tag ${msg}
}

function perr() {
	local msg=$1
	local exit=${2:-exit}
	local tag=${3:-ERR}
	pline ${BCol_BrightRed} $tag ${msg}
	[[ "$exit" == "exit" ]] && exit 1 || return 0
}

 #}}}
