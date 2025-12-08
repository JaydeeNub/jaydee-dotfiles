#!/usr/bin/env bash
# Centralized Color Configuration for Dotfiles
# Monokai Night Theme Color Palette
# Based on Monokai Night by Fabio Spampinato

##########################################################################
# MONOKAI NIGHT THEME - PRIMARY COLORS
##########################################################################

# Background & Foreground
export MONOKAI_BG="#1f1f1f"
export MONOKAI_BG_ALT="#262626"
export MONOKAI_BG_DARK="#0f0f0f"
export MONOKAI_BG_ELEVATED="#363636"
export MONOKAI_FG="#dddddd"
export MONOKAI_FG_ALT="#888888"

# Accent Colors
export MONOKAI_CYAN="#66d9ef"
export MONOKAI_GREEN="#a6e22e"
export MONOKAI_ORANGE="#fd971f"
export MONOKAI_PINK="#f92672"
export MONOKAI_PURPLE="#ae81ff"
export MONOKAI_RED="#fe413f"
export MONOKAI_YELLOW="#e6db74"

# Special Colors
export MONOKAI_COMMENT="#666666"
export MONOKAI_SELECTION="#363636"
export MONOKAI_TRANSPARENT="#1f1f1fe6"
export MONOKAI_ACCENT="#007acc"

##########################################################################
# SEMANTIC COLOR MAPPINGS
##########################################################################

# UI Elements
export COLOR_PRIMARY="$MONOKAI_CYAN"
export COLOR_SECONDARY="$MONOKAI_PURPLE"
export COLOR_BACKGROUND="$MONOKAI_BG"
export COLOR_FOREGROUND="$MONOKAI_FG"

# Status Indicators
export COLOR_SUCCESS="$MONOKAI_GREEN"
export COLOR_WARNING="$MONOKAI_YELLOW"
export COLOR_ERROR="$MONOKAI_RED"
export COLOR_INFO="$MONOKAI_CYAN"

# System Monitoring
export COLOR_CPU="$MONOKAI_PURPLE"
export COLOR_MEMORY="$MONOKAI_CYAN"
export COLOR_DISK="$MONOKAI_ORANGE"
export COLOR_NETWORK_UP="$MONOKAI_RED"
export COLOR_NETWORK_DOWN="$MONOKAI_GREEN"
export COLOR_TEMPERATURE="$MONOKAI_ORANGE"

# Audio/Media
export COLOR_VOLUME="$MONOKAI_PINK"
export COLOR_MICROPHONE="$MONOKAI_GREEN"
export COLOR_MICROPHONE_MUTED="$MONOKAI_RED"

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
#   echo -e "${MONOKAI_CYAN}This is cyan text${MONOKAI_FG}"
#
# For other configs (i3, polybar, etc.), use the values directly:
#   background = #1f1f1f
#   foreground = #dddddd
#   primary = #66d9ef
#
##########################################################################
