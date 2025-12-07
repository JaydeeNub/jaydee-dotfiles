#!/bin/bash

# Source centralized colors
source ~/.config/dotfiles-common/colors.sh

# Toggle microphone mute
pactl set-source-mute @DEFAULT_SOURCE@ toggle

# Get current status and show notification
MUTE_STATUS=$(pactl get-source-mute @DEFAULT_SOURCE@ 2>/dev/null | awk '{print $2}')

if [ "$MUTE_STATUS" = "yes" ]; then
    notify-send -u low -t 1000 -h string:x-canonical-private-synchronous:microphone " Microphone Muted" "Microphone is now muted"
else
    notify-send -u low -t 1000 -h string:x-canonical-private-synchronous:microphone " Microphone Active" "Microphone is now active"
fi
