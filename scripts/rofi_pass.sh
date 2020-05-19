#!/usr/bin/env bash
# dotfiles -- scripts/rofi_pass.sh
# author: johannst
#
# run as: rofi -show pass -modi pass:./rofi_pass.sh
# 
# rofi will invoke this script without args to populate the selection dialogue.
# After selecting one element, rofi will invoke this script with the selection
# as argument.

prefix=${PASSWORD_STORE_DIR:-~/.password-store}

echo "1: $1" >> ~/ROFI

password=$1
if [ -z $password ]; then
    shopt -s nullglob globstar
    passwords=($prefix/**/*.gpg)
    passwords=(${passwords[@]#$prefix/})
    passwords=(${passwords[@]%.gpg} )
    printf '%s\n' ${passwords[@]}
else
    # Run async with coproc (rofi intrinsic)
    # else rofi UI blocks pinentry.
    coproc (pass show -c $password &> /dev/null)
fi
