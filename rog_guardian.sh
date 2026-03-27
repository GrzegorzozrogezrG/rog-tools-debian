#!/bin/bash

# --- KONFIGURACJA ---
TEMP_PATH="/sys/class/thermal/thermal_zone0/temp" # Ścieżka do czujnika
HOT=80000   # 80°C -> Przełącz na Turbo
SAFE=60000   # 60°C -> Wróć do Balanced (zamiast Quiet)
last_state="balanced"

while true; do
    current_temp=$(cat $TEMP_PATH)
    
    # Wejście w Turbo przy obciążeniu
    if [ "$current_temp" -gt "$HOT" ] && [ "$last_state" != "turbo" ]; then
        asusctl profile set Turbo
        last_state="turbo"
        notify-send -u critical "ROG Guardian" "Wysoka temperatura: $((current_temp/1000))°C. Tryb Turbo."
    
    # Powrót do Balanced (bezpieczniejszy dla monitora)
    elif [ "$current_temp" -lt "$SAFE" ] && [ "$last_state" != "balanced" ]; then
        asusctl profile set Balanced
        last_state="balanced"
        notify-send "ROG Guardian" "System schłodzony: $((current_temp/1000))°C. Tryb Balanced."
    fi

    sleep 10
done
