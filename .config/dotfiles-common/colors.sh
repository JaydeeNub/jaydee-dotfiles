#!/usr/bin/env bash
# Centralized Color Configuration for Dotfiles
# Dracula Theme Color Palette
# https://draculatheme.com/contribute

##########################################################################
# DRACULA THEME - PRIMARY COLORS
##########################################################################

# Background & Foreground
export DRACULA_BG="#282a36"
export DRACULA_BG_ALT="#44475a"
export DRACULA_FG="#f8f8f2"
export DRACULA_FG_ALT="#6272a4"

# Accent Colors
export DRACULA_CYAN="#8be9fd"
export DRACULA_GREEN="#50fa7b"
export DRACULA_ORANGE="#ffb86c"
export DRACULA_PINK="#ff79c6"
export DRACULA_PURPLE="#bd93f9"
export DRACULA_RED="#ff5555"
export DRACULA_YELLOW="#f1fa8c"

# Special Colors
export DRACULA_COMMENT="#6272a4"
export DRACULA_SELECTION="#44475a"
export DRACULA_TRANSPARENT="#282a36e6"

##########################################################################
# SEMANTIC COLOR MAPPINGS
##########################################################################

# UI Elements
export COLOR_PRIMARY="$DRACULA_PURPLE"
export COLOR_SECONDARY="$DRACULA_PINK"
export COLOR_BACKGROUND="$DRACULA_BG"
export COLOR_FOREGROUND="$DRACULA_FG"

# Status Indicators
export COLOR_SUCCESS="$DRACULA_GREEN"
export COLOR_WARNING="$DRACULA_ORANGE"
export COLOR_ERROR="$DRACULA_RED"
export COLOR_INFO="$DRACULA_CYAN"

# System Monitoring
export COLOR_CPU="$DRACULA_PURPLE"
export COLOR_MEMORY="$DRACULA_CYAN"
export COLOR_DISK="$DRACULA_ORANGE"
export COLOR_NETWORK_UP="$DRACULA_RED"
export COLOR_NETWORK_DOWN="$DRACULA_GREEN"
export COLOR_TEMPERATURE="$DRACULA_ORANGE"

# Audio/Media
export COLOR_VOLUME="$DRACULA_PINK"
export COLOR_MICROPHONE="$DRACULA_GREEN"
export COLOR_MICROPHONE_MUTED="$DRACULA_RED"

##########################################################################
# HELPER FUNCTIONS
##########################################################################

# Get color without # prefix (for some configs)
get_color_hex() {
    echo "${1#\#}"
}

# Convert hex to RGB
hex_to_rgb() {
    local hex="${1#\#}"
    printf "%d %d %d\n" 0x"${hex:0:2}" 0x"${hex:2:2}" 0x"${hex:4:2}"
}

##########################################################################
# USAGE EXAMPLES
##########################################################################
#
# In shell scripts:
#   source ~/.config/dotfiles-common/colors.sh
#   echo -e "${DRACULA_PURPLE}This is purple text${DRACULA_FG}"
#
# For other configs (i3, polybar, etc.), use the values directly:
#   background = #282a36
#   foreground = #f8f8f2
#   primary = #bd93f9
#
##########################################################################
