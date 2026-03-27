#!/bin/bash

# 1. Pobieranie i czyszczenie danych (V6.3.5)
temp_raw=$(cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null || echo "0")
temp_c=$((temp_raw/1000))

# Wyciągamy tylko ostatnie słowo (nazwę profilu), np. "Quiet"
current_profile=$(asusctl profile get | awk '{print $NF}' | xargs || echo "N/A")

# Wyciągamy tryb grafiki
current_gfx=$(supergfxctl -g 2>/dev/null | xargs || echo "N/A")

# 2. Przygotowanie treści okna
TITLE="ROG Dashboard"
# Używamy zmiennej, aby uniknąć problemów z parsowaniem spacji przez Zenity
HEADER_TEXT="🌡️ Temp: ${temp_c}°C  |  🚀 Profil: ${current_profile}  |  🎮 GPU: ${current_gfx}"

# 3. Wywołanie okna (zwiększyłem wymiary dla bezpieczeństwa GTK)
choice=$(zenity --list --title="$TITLE" --width=600 --height=700 \
    --text="$HEADER_TEXT" \
    --column="Akcja" --column="Opis" \
    "Ustaw Profil Turbo" "Maksymalna moc chłodzenia" \
    "Ustaw Profil Balanced" "Zalecany balans (brak mrugania)" \
    "Ustaw Profil Quiet" "Cicha praca (może mrugać)" \
    "Uruchom Strażnika" "Auto-chłodzenie w tle (skrypt)" \
    "Zatrzymaj Strażnika" "Wyłącz skrypt rog_guardian.sh" \
    "Aura: Tęcza (Rainbow)" "Efekt ROG Rainbow" \
    "Aura: Statyczny Czerwony" "Stały kolor czerwony" \
    "Aura: Statyczny Niebieski" "Stały kolor niebieski" \
    "Aura: WYŁĄCZ LEDY" "Tryb ciemny" \
    "Tryb GRA (MUX dGPU)" "Tylko Nvidia (Wyloguje Cię)" \
    "Tryb HYBRYDOWY" "AMD + Nvidia (Wyloguje Cię)" \
    "Limit Baterii 80%" "Ochrona żywotności ogniwa" \
    "Pełne dane systemu" "Szczegółowe info z asusctl")

# 4. Logika (każda opcja w cudzysłowie!)
case "$choice" in
    "Ustaw Profil Turbo") asusctl profile set Turbo ;;
    "Ustaw Profil Balanced") asusctl profile set Balanced ;;
    "Ustaw Profil Quiet") asusctl profile set Quiet ;;
    "Uruchom Strażnika") 
        nohup "$HOME/rog_guardian.sh" > /dev/null 2>&1 & 
        notify-send "ROG Dashboard" "Strażnik aktywny." ;;
    "Zatrzymaj Strażnika") 
        pkill -f rog_guardian.sh
        notify-send "ROG Dashboard" "Strażnik wyłączony." ;;
    "Aura: Tęcza (Rainbow)") asusctl aura effect rainbow-cycle --speed low ;;
    "Aura: Statyczny Czerwony") asusctl aura effect static -c ff0000 ;;
    "Aura: Statyczny Niebieski") asusctl aura effect static -c 0000ff ;;
    "Aura: WYŁĄCZ LEDY") asusctl aura effect static -c 000000 ;;
    "Tryb GRA (MUX dGPU)") 
        zenity --question --text="Przełączenie na MUX wyloguje Cię. Kontynuować?" && supergfxctl -m AsusMuxDgpu ;;
    "Tryb HYBRYDOWY") 
        zenity --question --text="Przełączenie na Hybrid wyloguje Cię. Kontynuować?" && supergfxctl -m Hybrid ;;
    "Limit Baterii 80%") asusctl battery-policy 80 ;;
    "Pełne dane systemu") asusctl info | zenity --text-info --width=600 --height=400 ;;
esac
