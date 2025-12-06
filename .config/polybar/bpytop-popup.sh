#!/bin/bash
set -euo pipefail

# Check if bpytop/btop window is already open
if pgrep -f "kitty.*floating_btop" > /dev/null; then
    # If running, kill it to toggle off
    pkill -f "kitty.*floating_btop"
else
    # Window size
    WINDOW_WIDTH=1000
    WINDOW_HEIGHT=700
    
    # Get the monitor where Polybar is running (focused monitor)
    FOCUSED_OUTPUT=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).output')
    
    # Get the position of the focused monitor
    MONITOR_INFO=$(xrandr --query | grep "^${FOCUSED_OUTPUT} connected")
    
    if echo "$MONITOR_INFO" | grep -q "primary"; then
        # Primary monitor - extract position
        MONITOR_POS=$(echo "$MONITOR_INFO" | grep -oP '\d+x\d+\+\d+\+\d+' | head -1)
        MONITOR_X=$(echo "$MONITOR_POS" | cut -d'+' -f2)
        MONITOR_Y=$(echo "$MONITOR_POS" | cut -d'+' -f3)
    else
        # Get position from xrandr output
        MONITOR_POS=$(echo "$MONITOR_INFO" | grep -oP '\d+x\d+\+\d+\+\d+' | head -1)
        MONITOR_X=$(echo "$MONITOR_POS" | cut -d'+' -f2)
        MONITOR_Y=$(echo "$MONITOR_POS" | cut -d'+' -f3)
    fi
    
    # Calculate position (10px margin from monitor edge, 33px below top for bar)
    X_POS=$((MONITOR_X + 10))
    Y_POS=$((MONITOR_Y + 33))
    
    # Check which monitor tool is available
    if command -v btop &> /dev/null; then
        MONITOR="btop"
    elif command -v bpytop &> /dev/null; then
        MONITOR="bpytop"
    else
        notify-send "Error" "Neither btop nor bpytop is installed"
        exit 1
    fi
    
    # Launch floating terminal with bpytop/btop
    kitty --name floating_btop \
          --class floating_btop \
          -e $MONITOR &
    
    # Wait for the window to be created
    sleep 0.4
    
    # Make it floating, resize and position it using i3 with pixel values
    i3-msg "[instance=\"floating_btop\"] floating enable, resize set ${WINDOW_WIDTH} px ${WINDOW_HEIGHT} px, move position ${X_POS} px ${Y_POS} px"
    
    # Monitor for focus loss and close window
    (
        sleep 0.5
        
        i3-msg -t subscribe -m '["window"]' | while read -r event; do
            FOCUSED=$(i3-msg -t get_tree | jq -r '.. | select(.focused? == true) | .window_properties.instance' 2>/dev/null)
            
            if [ "$FOCUSED" != "floating_btop" ]; then
                if pgrep -f "kitty.*floating_btop" > /dev/null; then
                    pkill -f "kitty.*floating_btop"
                    exit 0
                fi
            fi
        done
    ) &
fi