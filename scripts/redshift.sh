#!/bin/bash
# dotfiles -- scripts/redshift.sh
# author: johannst

# Didn't find a way to query current temperature.
# Use a file to keep track
VALUE_FILE=~/.redshift

function setRedshift() {
    # 6500K default temp
    local val=${1:-6500}
    echo "$val" > $VALUE_FILE
    redshift -P -O $val &> /dev/null
}

[[ ! -f $VALUE_FILE ]] && setRedshiftFile

curr_val=$(<$VALUE_FILE)
case $BLOCK_BUTTON in
  3) setRedshift ;;  # right click, set default
  4) setRedshift $((curr_val + 200)); ;; # scroll up, inc temp (more blue)
  5) setRedshift $((curr_val - 200)); ;; # scroll down, dec temp (more red)
esac


new_val=$(<$VALUE_FILE)
# format protocol (https://github.com/vivien/i3blocks/tree/master/docs#format)
echo ${new_val}K
echo ""
if [ $new_val -lt 5000 ]; then
    echo "#eba02f"
elif  [ $new_val -gt 7500 ]; then
    echo "#42adff"
fi

