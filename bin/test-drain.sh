#!/bin/bash
set -eu

BAT=/sys/class/power_supply/BAT0/

time0=$(date +%s)
now0=$(cat $BAT/energy_now)
full0=$(cat $BAT/energy_full)
frac0=$(echo "scale=5; $now0/$full0" | bc)

echo "before $time0 $now0 $full0 $frac0"

systemctl suspend
read

time1=$(date +%s)
now1=$(cat $BAT/energy_now)
full1=$(cat $BAT/energy_full)
frac1=$(echo "scale=5; $now1/$full1" | bc)

echo "after $time1 $now1 $full1 $frac1"

dtime=$(echo "$time1 - $time0" | bc)
dnow=$(echo "$now0 - $now1" | bc)
drain=$(echo "scale=5; $dnow/($dtime/3600)" | bc)
drainp=$(echo "scale=5; ($dnow/$full1)/($dtime/3600)" | bc)

echo "drain dtime=$dtime dnow=$dnow W/h=$drain Bat%/h=$drainp"



