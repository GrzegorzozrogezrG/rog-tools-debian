!/bin/bash

# --- CONFIGURATION ---
TEMP_LIMIT=80
CHECK_INTERVAL=10
TEMP_FILE="/sys/class/thermal/thermal_zone0/temp"

echo "ROG Guardian started. Monitoring CPU temperature..."

# --- MAIN LOOP ---
while true; do
    if [ -f "$TEMP_FILE" ]; then
        TEMP_RAW=$(cat "$TEMP_FILE")
        TEMP_C=$((TEMP_RAW / 1000))

        if [ "$TEMP_C" -gt "$TEMP_LIMIT" ]; then
            # Get current profile to avoid redundant commands
            CURRENT_PROFILE=$(asusctl profile get | awk '{print $NF}' | tr -d '[:space:]')
            
            if [ "$CURRENT_PROFILE" != "Turbo" ]; then
                asusctl profile set Turbo
                # Wayland-friendly notification
                notify-send -u critical "ROG Guardian" "Temperature hit ${TEMP_C}°C. Switching to TURBO mode!"
            fi
        fi
    else
        echo "Error: Thermal zone not found at $TEMP_FILE"
    fi

    sleep "$CHECK_INTERVAL"
done
