#!/bin/bash
# dotfiles -- scripts/eth.sh
# author: johannst

if="${BLOCK_INSTANCE:-enp0s25}"
[[ ! -d /sys/class/net/${if} ]] && exit 0

# operstate: down, up
[[ "$(cat /sys/class/net/$if/operstate)" = 'down' ]] && exit 0

# first ipv4 addr
IP_ADDR=$(ip address show $if | grep 'inet ' | sed 's/\s\+inet \([0-9.]\+\)\/.*/\1/')

echo "$IP_ADDR"

