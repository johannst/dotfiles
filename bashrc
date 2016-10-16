# dotfiles -- bashrc
# author: johannst


#{{{ general bash settings

export TERM=xterm-256color

# disable sticky mode
stty -ixon

#}}}
#{{{ alias

alias ls='ls --color=auto -h'
alias ll='ls -alF'
alias la='ls -AF'
alias grep='grep --color=auto'

#}}}
#{{{ color definition

BCol_NoColor='\e[m'
BCol_DarkRed='\e[38;5;88m'
BCol_DarkOrange='\e[38;5;202m'
BCol_LightOrange='\e[38;5;208m'
BCol_LightGray='\e[38;5;7m'
BCol_Yellow='\e[38;5;226m'
BCol_LightBlue='\e[38;5;74m'
BCol_BlueGray='\e[38;5;67m'
BCol_YellowOrange='\e[38;5;214m'

#}}}
#{{{ bash prompt 

export PS1="${BCol_DarkRed}::${BCol_DarkOrange}\u${BCol_DarkRed}::${BCol_LightOrange}\H${BCol_LightGray} - ${BCol_Yellow}\t${BCol_LightGray} - ${BCol_LightBlue}\w\n${BCol_NoColor}[${BCol_YellowOrange}$?${BCol_NoColor}] ${BCol_BlueGray}>>${BCol_NoColor} "

#}}}
#{{{ ls colors

export LS_COLORS='di=34:ln=96:or=4;96;41:so=0:pi=0:ex=01;92:bd=0;42:cd=0;42:su=0:sg=0:tw=30;44:ow=30;44'

#}}}
