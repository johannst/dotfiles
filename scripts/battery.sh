#!/bin/bash
# dotfiles -- scripts/battery.sh
# author: johannst

bat="${BLOCK_INSTANCE:-BAT0}"
[[ ! -f "/sys/class/power_supply/$bat/type" ]] && exit 1

# Auto-detect file prefix for battery files
for prefix in energy charge; do
	[[ -f "/sys/class/power_supply/$bat/${prefix}_now" ]] && {
		file_prefix=$prefix
		break
	}
done && test -n $file_prefix || exit 1

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

BAT_NOW=$(cat /sys/class/power_supply/$bat/${file_prefix}_now)
[[ $show_bat_use_design_capacity == 1 ]] \
	&& BAT_FULL=$(cat /sys/class/power_supply/$bat/${file_prefix}_full_design) \
	|| BAT_FULL=$(cat /sys/class/power_supply/$bat/${file_prefix}_full)
BAT_POWER=$(echo $BAT_NOW $BAT_FULL | awk '{ print int($1 * 100 / $2); }')

OUT="$BAT_POWER%"
[[ $show_bat_status == 1 ]] && \
	case $BAT_STATUS in
		Charging) OUT="$OUT (charging)"
		          # Disable status colors when charging.
		          show_bat_color_output=0
			;;
		Discharging) OUT="$OUT (on battery)"
			;;
		*) # only show charging state for now
			;;
	esac

# i3bar protocol:
#   - line 1: full_text
#   - line 2: short_text
#   - line 3: fg-color
#   - line 4: bg-color

echo "$OUT" # full txt

[[ $show_bat_color_output == 1 ]] && {
	echo "" # short txt
	if [[ $BAT_POWER -lt 10 ]]; then
		# red
		echo "#000000" # fg
		echo "#FF0000" # bg
	elif [[ $BAT_POWER -lt 15 ]]; then
		# dark orange
		echo "#000000" # fg
		echo "#FFAE00" # bg
	elif [[ $BAT_POWER -lt 20 ]]; then
		# yellow
		echo "#000000" # fg
		echo "#FFF600" # bg
	fi
}

