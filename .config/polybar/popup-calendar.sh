#!/bin/bash

# YAD calendar with DRACULA THEME - Fixed positioning at TOP RIGHT
# Requires: yad

# Dracula colors
BG_COLOR="#282a36"
FG_COLOR="#f8f9fa"
SELECTED_BG="#bd93f9"
SELECTED_FG="#282a36"

case "$1" in
    --popup)
        # Check if yad is available
        if ! command -v yad &>/dev/null; then
            notify-send "Error" "yad not installed. Run: sudo apt install yad"
            exit 1
        fi
        
        # Kill existing calendar
        pkill -f "yad.*yad-calendar" 2>/dev/null
        sleep 0.1
        
        # Calendar dimensions
        WIDTH=222
        HEIGHT=188
        
        # Get PRIMARY monitor information
        PRIMARY_INFO=$(xrandr | grep "primary" | head -1)
        
        if [ -n "$PRIMARY_INFO" ]; then
            # Extract geometry (format: WIDTHxHEIGHT+XOFFSET+YOFFSET)
            GEOMETRY=$(echo "$PRIMARY_INFO" | grep -oP '\d+x\d+\+\d+\+\d+' | head -1)
            
            if [ -n "$GEOMETRY" ]; then
                # Parse the geometry string
                MONITOR_WIDTH=$(echo "$GEOMETRY" | cut -d'x' -f1)
                MONITOR_XOFFSET=$(echo "$GEOMETRY" | cut -d'+' -f2)
                MONITOR_YOFFSET=$(echo "$GEOMETRY" | cut -d'+' -f3)
                
                # Calculate top-right position
                # X = monitor's left edge + monitor width - calendar width - 10px padding
                XPOS=$((MONITOR_XOFFSET + MONITOR_WIDTH - WIDTH - 20))
                # Y = monitor's top edge + 35px (below polybar)
                YPOS=$((MONITOR_YOFFSET + 35))
                
            else
                # Fallback if geometry parsing fails
                XPOS=1688  # For 1920px monitor: 1920 - 222 - 10
                YPOS=35
            fi
        else
            # No primary monitor, assume single monitor at 0,0
            # Get screen width
            if command -v xdpyinfo &>/dev/null; then
                SCREEN_WIDTH=$(xdpyinfo | grep dimensions | awk '{print $2}' | cut -d'x' -f1)
            else
                SCREEN_WIDTH=1920
            fi
            
            XPOS=$((SCREEN_WIDTH - WIDTH - 10))
            YPOS=35
        fi
        
        # Debug output (comment out after testing)
        # echo "Positioning calendar at X=$XPOS, Y=$YPOS" >> /tmp/yad-calendar.log
        
        # Create custom CSS for yad calendar
        YAD_CSS="/tmp/yad-calendar-dracula.css"
        cat > "$YAD_CSS" << 'EOF'
calendar {
    background-color: #282a36;
    color: #f8f9fa;
    font-family: "FiraCode", monospace;
}

calendar:selected {
    background-color: #bd93f9;
    color: #282a36;
    font-weight: bold;
}

calendar.header {
    background-color: #282a36;
    color: #bd93f9;
    font-weight: bold;
}

calendar.button {
    background-color: #44475a;
    color: #f8f9fa;
    border: none;
}

calendar.button:hover {
    background-color: #6272a4;
}

calendar:indeterminate {
    color: #6272a4;
}

calendar.highlight {
    background-color: #bd93f9;
    color: #282a36;
}
EOF
        
        # Launch calendar with explicit position
        yad --calendar \
            --undecorated \
            --fixed \
            --close-on-unfocus \
            --no-buttons \
            --width=$WIDTH \
            --height=$HEIGHT \
            --posx=$XPOS \
            --posy=$YPOS \
            --title="yad-calendar" \
            --borders=0 \
            --gtk-css="$YAD_CSS" \
            2>/dev/null &
        ;;
    *)
        date "+%a %d %H:%M"
        ;;
esac