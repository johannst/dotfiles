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

alias ls='ls --color=auto --human-readable'
alias ll='ls -l --classify'
alias la='ls --almost-all --classify'
alias lt='ll -t --reverse'
alias grep='grep --color=auto'
alias pstree='stree -achpA'
alias watchpstree='watch -n 2 pstree -achpA'
alias ps='\ps --forest --format pid,ppid,stat,start,command'
alias ups='\ps xww --forest --format pid,ppid,tty,stat,start,command'
alias pps='ps | grep -i $1'
alias penv='env | grep -i $1'
alias rsync='rsync --progress'
alias ts='date +%Y%m%d_%H\h%Mm'

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
	local ret_str="${ret}${BCol_NoColor}"
	[[ $ret == 0 ]] \
		&& ret_str="${BCol_BrightGreen}${ret_str}" \
		|| ret_str="${BCol_BrightRed}${ret_str}"
	echo -e "$ret_str";
}

function pwd_formater() {
	local pwd=$1
	local ret_str=$(echo $pwd | sed "s#[^A-Za-z]\+#\\${BCol_BrightRed}/\\${BCol_DarkBlue}#")
	echo -e "$ret_str";
}

function job_count() {
	local num_jobs=$(jobs -p | wc -l)
	echo -e "$num_jobs"
}

function save_exit_code() {
	# Used in PS1 computation to store the actual return value of the command run in the shell.
	# Need to be called as first function in PS1. As we use more commands in the PS1 computations this
	# would lead to reporting a wrong return value later.
	echo "$1" > $2
}

export PS1="\[${BCol_BrightRed}\]::\[${BCol_MediumGray}\]\u\[${BCol_BrightRed}\]::\[${BCol_LightGray}\]\H\[${BCol_BrightRed}\]:\[${BCol_DarkGray}\]$(tty) \[${BCol_LightGray}\] - \[${BCol_DarkBlue}\]\w\n\
\[${BCol_NoColor}\][\$(ret=\$?; if [[ \$ret == 0 ]]; then echo \"\[${BCol_BrightGreen}\]\$ret\"; else echo \"\[${BCol_BrightRed}\]\$ret\"; fi)\[${BCol_NoColor}\]] \$> "
#export PS1="\$(save_exit_code \$? ~/.bash_exit)\
#\[${BCol_BrightRed}\]::\[${BCol_MediumGray}\]\u\[${BCol_BrightRed}\]\
#::\[${BCol_LightGray}\]\H\[${BCol_BrightRed}\]\
#:\[${BCol_DarkGray}\]$(tty)\[${BCol_LightGray}\] - \[${BCol_DarkBlue}\]\w\n\
#\[${BCol_NoColor}\][\$(return_val_formater \$(cat ~/.bash_exit))\[${BCol_NoColor}\]] \$> "
#\[${BCol_NoColor}\][\$(ret=\$(cat ~/.bash_exit); if [[ \$ret == 0 ]]; then echo \"\[${BCol_BrightGreen}\]\$ret\"; else echo \"\[${BCol_BrightRed}\]\$ret\"; fi)\[${BCol_NoColor}\]] \$> "

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
	pline ${BCol_BrightGreen} $tag "${msg}"
}

function pwarn () {
	local msg=$1
	local tag=${2:-WARN}
	pline ${BCol_YellowOrange} $tag "${msg}"
}

function perr() {
	local msg=$1
	local exit=${2:-exit}
	local tag=${3:-ERR}
	pline ${BCol_BrightRed} $tag "${msg}"
	[[ "$exit" == "exit" ]] && exit 1 || return 0
}

 #}}}
#{{{ save/restore settings

function save_bash_options() {
	local backup_file=$1
	set +o >> $backup_file
}

function save_bash_exports() {
	local backup_file=$1
	export -p >> $backup_file
}

function save_bash() {
	local backup=${1:-~/.saved_bash_env}
	:> $backup
	save_bash_options $backup
	save_bash_exports $backup
}

function restore_bash() {
	local backup=${1:-~/.saved_bash_env}
	source $backup
}

#}}}
