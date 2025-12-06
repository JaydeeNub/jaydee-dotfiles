#!/bin/bash

# Function to get microphone status
get_mic_status() {
    MUTE_STATUS=$(pactl get-source-mute @DEFAULT_SOURCE@ 2>/dev/null | awk '{print $2}')
    
    if [ "$MUTE_STATUS" = "yes" ]; then
        echo "%{F#ff5555}%{u#ff5555}%{u-}%{F-}"
    else
        echo "%{F#50fa7b}%{u#50fa7b}%{u-}%{F-}"
    fi
}

# Initial output
get_mic_status

# Listen for PulseAudio events and update
pactl subscribe | grep --line-buffered "source" | while read -r line; do
    get_mic_status
done