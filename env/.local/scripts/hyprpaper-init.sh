#!/usr/bin/env bash

WALLPAPER="$HOME/.config/hypr/tokyonight_original.png"

hyprpaper &

for i in $(seq 1 20); do
    if hyprctl hyprpaper preload "$WALLPAPER" >/dev/null 2>&1; then
        break
    fi
    sleep 0.5
done

for monitor in $(hyprctl monitors -j | python3 -c "import sys,json; print('\n'.join(m['name'] for m in json.load(sys.stdin)))"); do
    hyprctl hyprpaper wallpaper "${monitor},${WALLPAPER}" >/dev/null 2>&1
done
