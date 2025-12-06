#!/bin/bash
# Source centralized colors
source ~/.config/dotfiles-common/colors.sh

case "$1" in
    --toggle)
        dunstctl set-paused toggle
        ;;
    *)
        if [ "$(dunstctl is-paused)" = "true" ]; then
            echo "%{F${COLOR_MICROPHONE_MUTED}}%{u${COLOR_MICROPHONE_MUTED}}%{u-}%{F-}"
        else
            echo "%{F${COLOR_MICROPHONE}}%{u${COLOR_MICROPHONE}}%{u-}%{F-}"
        fi
        ;;
esac

