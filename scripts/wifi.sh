#!/bin/bash
# dotfiles -- scripts/wifi.sh
# author: johannst

if="${BLOCK_INSTANCE:-wlp3s0}"
[[ ! -d /sys/class/net/${if} ]] && exit 0

show_ap_mac=0
show_ap_quality=0
show_ap_name=0
for arg in "$@"; do
	case $arg in
		-aq | --ap_quality) show_ap_quality=1
			;;
		-am | --ap_mac) show_ap_mac=1
			;;
		-an | --ap_name) show_ap_name=1
			;;
		*) # ignore unknown
			;;
	esac
done

AP_NAME=$(iwgetid -r $if)
AP_MAC=$(iwgetid -a $if | sed 's/.*\(\([0-9A-F]\{2\}:\)\{5\}[0-9A-F]\{2\}\).*/\1/')
AP_QUALITY=$(grep $if /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')%

# first ipv4 addr
IP_ADDR=$(ip address show $if | grep 'inet ' | sed 's/\s\+inet \([0-9.]\+\)\/.*/\1/')

OUT="$IP_ADDR"
if [[ $show_ap_name == 1 && $show_ap_quality == 1 ]]; then
	OUT="$OUT ($AP_NAME $AP_QUALITY)"
elif [[ $show_ap_name == 1 ]]; then
	OUT="$OUT ($AP_NAME)"
elif [[ $show_ap_quality == 1 ]]; then
	OUT="$OUT ($AP_QUALITY)"
fi
[[ $show_ap_mac == 1 ]] && OUT="$OUT $AP_MAC"

echo "$OUT"

