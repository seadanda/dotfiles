#!/bin/env bash

# Terminate existing polybar instances
killall -q polybar

# Wait til they die
while pgrep -x polybar >/dev/null; do sleep 1; done

# Get network interface name
export NETWORK_INTERFACE=$(ip link show | grep "state UP" | head -1 | cut -d" " -f2 | cut -d":" -f1)

# Get CPU thermal zone
export THERMAL_ZONE=$(ls /sys/class/thermal | grep thermal_zone | grep -oE "[0-9]" | sort -nr | head -n 1)

monitors=$(polybar --list-monitors | cut -d":" -f1)

for m in $monitors; do
    if [[ $(wc -l <<< $monitors) -gt 1 ]]; then
        # systray on external
        if [[ $m == "DP-1-1" ]]; then
            MONITOR=$m TRAY_POSITION=right NETWORK_INTERFACE=$NETWORK_INTERFACE THERMAL_ZONE=$THERMAL_ZONE polybar --reload main &
        else
            MONITOR=$m TRAY_POSITION=none NETWORK_INTERFACE=$NETWORK_INTERFACE THERMAL_ZONE=$THERMAL_ZONE polybar --reload main &
        fi
    else
        # systray on laptop
        if [[ $m == "eDP-1-1" ]]; then
            MONITOR=$m TRAY_POSITION=right NETWORK_INTERFACE=$NETWORK_INTERFACE THERMAL_ZONE=$THERMAL_ZONE polybar --reload main &
        else
            MONITOR=$m TRAY_POSITION=none NETWORK_INTERFACE=$NETWORK_INTERFACE THERMAL_ZONE=$THERMAL_ZONE polybar --reload main &
        fi
    fi
done
