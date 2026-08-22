#!/usr/bin/env bash

sink_vol=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -1)
sink_mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
source_vol=$(pactl get-source-volume @DEFAULT_SOURCE@ | grep -oP '\d+(?=%)' | head -1)
source_mute=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')

if [[ "$sink_mute" == "yes" ]]; then
    speaker="muted"
else
    speaker="${sink_vol}%"
fi

if [[ "$source_mute" == "yes" ]]; then
    mic="muted"
else
    mic="${source_vol}%"
fi

echo "音 ${speaker} ｜ ${mic}"
