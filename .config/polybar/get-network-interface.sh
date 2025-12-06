#!/usr/bin/env bash
set -euo pipefail

# Detect the primary network interface
# Priority: active ethernet > active wifi > first ethernet > first wifi

# Try to find active interface with default route
ACTIVE_INTERFACE=$(ip route | grep '^default' | awk '{print $5}' | head -1)

if [ -n "$ACTIVE_INTERFACE" ]; then
    echo "$ACTIVE_INTERFACE"
    exit 0
fi

# Fallback: Find first active ethernet interface
ETHERNET=$(ip link show | grep -E '^[0-9]+: (en|eth)' | grep 'state UP' | awk -F: '{print $2}' | tr -d ' ' | head -1)

if [ -n "$ETHERNET" ]; then
    echo "$ETHERNET"
    exit 0
fi

# Fallback: Find first active wifi interface
WIFI=$(ip link show | grep -E '^[0-9]+: (wl|wlan)' | grep 'state UP' | awk -F: '{print $2}' | tr -d ' ' | head -1)

if [ -n "$WIFI" ]; then
    echo "$WIFI"
    exit 0
fi

# Last resort: Return first ethernet interface even if down
FIRST_ETH=$(ip link show | grep -E '^[0-9]+: (en|eth)' | awk -F: '{print $2}' | tr -d ' ' | head -1)

if [ -n "$FIRST_ETH" ]; then
    echo "$FIRST_ETH"
    exit 0
fi

# Default fallback
echo "eth0"
