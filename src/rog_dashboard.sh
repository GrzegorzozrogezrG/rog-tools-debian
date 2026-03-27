#!/bin/bash

# --- Status Data ---
temp_raw=$(cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null || echo "0")
temp_c=$((temp_raw/1000))
# Get profile and clean extra spaces
profile=$(asusctl profile get | awk '{print $NF}' | tr -d '[:space:]')
# Get GPU mode
gfx=$(supergfxctl -g 2>/dev/null)

# --- Clean Zenity Menu (Wayland Compatible) ---
# We use simple quotes and avoid backslashes to prevent the "Option not available" error
choice=$(zenity --list --title="ROG Dashboard" --width=400 --height=500 --column="Menu Options" "Set Turbo Profile" "Set Balanced Profile" "Set Quiet Profile" "Graphics: HYBRID" "Graphics: DEDICATED" "Graphics: INTEGRATED" "Start Guardian" "Stop Guardian" "Aura: Rainbow" "Aura: LED OFF" "Battery Limit 80%")

# --- Execution ---
case "$choice" in
    "Set Turbo Profile") asusctl profile set Turbo ;;
    "Set Balanced Profile") asusctl profile set Balanced ;;
    "Set Quiet Profile") asusctl profile set Quiet ;;
    "Graphics: HYBRID") 
        zenity --question --text="Switch to Hybrid? (Logout will occur)" && supergfxctl -m Hybrid ;;
    "Graphics: DEDICATED") 
        zenity --question --text="Switch to Dedicated? (Logout will occur)" && supergfxctl -m Dedicated ;;
    "Graphics: INTEGRATED")
        zenity --question --text="Switch to Integrated?" && supergfxctl -m Integrated ;;
    "Start Guardian") 
        nohup /usr/local/bin/rog-guardian > /dev/null 2>&1 &
        notify-send "ROG Dashboard" "Guardian Active" ;;
    "Stop Guardian") 
        pkill -f rog-guardian && notify-send "ROG Dashboard" "Guardian Stopped" ;;
    "Aura: Rainbow") asusctl aura effect rainbow-cycle --speed low ;;
    "Aura: LED OFF") asusctl aura effect static -c 000000 ;;
    "Battery Limit 80%") asusctl battery-policy 80 ;;
esac
