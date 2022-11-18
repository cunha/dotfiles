#!/bin/sh
set -eu

BAT=/sys/devices/platform/smapi/BAT0

set_stop_charge_thresh () {
	echo $1 > $BAT/stop_charge_thresh
}

show () {
	echo -n "remaining_percent: "
	cat $BAT/remaining_percent
	echo -n "remaining_running_time: "
	cat $BAT/remaining_running_time
	echo -n "state: "
	cat $BAT/state
	echo -n "temperature: "
	cat $BAT/temperature
	# echo -n "start_charge_thresh: "
	# sudo tpacpi-bat -g ST 1
	echo -n "stop_charge_thresh: "
	cat $BAT/stop_charge_thresh
}

show_line () {
	perc=$(cat $BAT/remaining_percent)
	state=$(cat $BAT/state)
	rem=$(cat $BAT/remaining_running_time)
	if [ "$rem" = "not_discharging" ] ; then
		echo "Battery: $perc% $state"
	else
		echo "Battery: $perc% $state ${rem}min"
	fi
}

charge_until () {
	show
	set_stop_charge_thresh $1
	sleep 10s
	percent=$(cat $BAT/remaining_percent)
	status=$(cat $BAT/state)
	while [ $percent != $1 -a $status != "idle" ] ; do
		sleep 10s
		percent=$(cat $BAT/remaining_percent)
		status=$(cat $BAT/state)
		echo "$status $percent/$1"
	done
	set_stop_charge_thresh 30
}

opt=help
[ $# -ge 1 ] && opt=$1

case $opt in
charge-until)
	charge_until $2
	;;
set-stop-charge-thresh)
	set_stop_charge_thresh $2
	;;
line)
	show_line
	;;
*|show)
	show
	;;
help|-h|--help)
	echo "$0 [OPTION]"
	echo ""
	echo "show"
	echo "set-stop-charge-thresh NUM"
	echo "charge-until NUM"
	;;
esac

	
