#!/bin/bash
# dotfiles -- scripts/battery.sh
# author: johannst

bat="${BLOCK_INSTANCE:-BAT0}"
[[ ! -f "/sys/class/power_supply/$bat/type" ]] && exit 0

show_bat_use_design_capacity=0
show_bat_status=0
show_bat_color_output=0
for arg in "$@"; do
	case $arg in
		-dc | --design_capacity) show_bat_use_design_capacity=1
			;;
		-s | --status) show_bat_status=1
			;;
		-c | --color) show_bat_color_output=1
			;;
		*) # ignore unknown
			;;
	esac
done

# Unknown, Charging, Discharging, Full
BAT_STATUS=$(cat /sys/class/power_supply/$bat/status)
BAT_NOW=$(cat /sys/class/power_supply/$bat/charge_now)
[[ $show_bat_use_design_capacity == 1 ]] \
	&& BAT_FULL=$(cat /sys/class/power_supply/$bat/charge_full_design) \
	|| BAT_FULL=$(cat /sys/class/power_supply/$bat/charge_full)

BAT_POWER=$(echo $BAT_NOW $BAT_FULL | awk '{ print int($1 * 100 / $2); }')

OUT="$BAT_POWER%"
[[ $show_bat_status == 1 ]] && \
	case $BAT_STATUS in
		Charging) OUT="$OUT (Charging)"
			;;
		*) # only show charging state for now
			;;
	esac

echo "$OUT"

[[ $show_bat_color_output == 1 ]] && \
	# print twice, else colors not working?!
	echo "$OUT"
	if [[ $BAT_POWER -ge 80 ]]; then
		# green
		echo "#00FF00"
	elif [[ $BAT_POWER -ge 60 ]]; then
		# yellow
		echo "#FFF600"
	elif [[ $BAT_POWER -ge 40 ]]; then
		# dark orange
		echo "#FFAE00"
	else
		# red
		echo "#FF0000"
	fi

