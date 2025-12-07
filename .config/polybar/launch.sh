#!/usr/bin/env bash

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Get primary monitor
PRIMARY=$(xrandr --query | grep " connected primary" | cut -d" " -f1)

# Auto-detect network interface
NETWORK_INTERFACE=$(~/.config/polybar/get-network-interface.sh)
export POLYBAR_NETWORK_INTERFACE="$NETWORK_INTERFACE"

# Launch only on primary monitor
MONITOR=$PRIMARY polybar example 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched on primary monitor: $PRIMARY with network interface: $NETWORK_INTERFACE"
