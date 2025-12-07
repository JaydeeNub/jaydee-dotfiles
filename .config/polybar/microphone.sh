#!/bin/bash

# Source centralized colors
source ~/.config/dotfiles-common/colors.sh

# Function to get microphone status
get_mic_status() {
    MUTE_STATUS=$(pactl get-source-mute @DEFAULT_SOURCE@ 2>/dev/null | awk '{print $2}')

    if [ "$MUTE_STATUS" = "yes" ]; then
        # Use centralized color for muted state
        echo "%{F${COLOR_MICROPHONE_MUTED}}%{u${COLOR_MICROPHONE_MUTED}}%{u-}%{F-}"
    else
        # Use centralized color for active state
        echo "%{F${COLOR_MICROPHONE}}%{u${COLOR_MICROPHONE}}%{u-}%{F-}"
    fi
}

# Initial output
get_mic_status

# Listen for PulseAudio events and update
pactl subscribe | grep --line-buffered "source" | while read -r line; do
    get_mic_status
done
