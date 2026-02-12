#!/usr/bin/bash

if xrandr | grep -q "HDMI-0 .* left (";
then
    echo 'resets display'
    xrandr --output HDMI-0 --rotate normal --output DP-0 --pos 0x0
else
    echo 'rotates display'
    xrandr --output HDMI-0 --rotate left --output DP-0 --pos 0x450
fi

