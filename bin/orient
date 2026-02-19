#!/bin/bash

hdmi_1_orientation=$1
dp_0_orientation=$2
hdmi_0_orientation=$3

get_width_from_orientation() {
    if [[ $1 == "left" || $1 == "right" ]]; then
        echo 1080
    elif [[ $1 == "normal" ]]; then
        echo 1920
    elif [[ $1 == "off" ]]; then
        echo 0
    else
        echo 0
    fi
}

#echo $(get_width_from_orientation $hdmi_0_orientation)

hdmi_1_x=0

if [[ $(get_width_from_orientation $hdmi_1_orientation) == 1080 ]]; then
    # it's vertical
    hdmi_1_y=0
else
    hdmi_1_y=$((1920 - 1080))
fi

if [[ $hdmi_1_orientation == "off" ]]; then
    hdmi_1_mode="off"
    hdmi_1_orientation="normal"
else
    hdmi_1_mode="auto"
fi

dp_0_x=$(get_width_from_orientation $hdmi_1_orientation)

if [[ $(get_width_from_orientation $dp_0_orientation) == 1080 ]]; then
    dp_0_y=0
else
    dp_0_y=$((1920 - 1080))
fi

if [[ $dp_0_orientation == "off" ]]; then
    dp_0_mode="off"
    dp_0_orientation="normal"
else
    dp_0_mode="auto"
fi


hdmi_0_x=$((dp_0_x + $(get_width_from_orientation $dp_0_orientation)))

if [[ $(get_width_from_orientation $dp_0_orientation) == 1080 ]]; then
    hdmi_0_y=0
else
    hdmi_0_y=$((1920 - 1080))
fi

if [[ $hdmi_0_orientation == "off" ]]; then
    hdmi_0_mode="off"
    hdmi_0_orientation="normal"
else
    hdmi_0_mode="auto"
fi


#dp_0_y=$(get_width_from_orientation hdmi_1_orientation)


echo "\
    xrandr --output HDMI-0 --rotate ${hdmi_0_orientation} --auto --pos ${hdmi_0_x}x${hdmi_0_y} \
    --output DP-0 --rotate ${dp_0_orientation} --pos ${dp_0_x}x${dp_0_y} \
    --output HDMI-1 --rotate ${hdmi_1_orientation} --auto --pos ${hdmi_1_x}x${hdmi_1_y}"

xrandr --output HDMI-0 --${hdmi_0_mode} --rotate ${hdmi_0_orientation} --pos ${hdmi_0_x}x${hdmi_0_y} \
    --output DP-0 --${dp_0_mode} --rotate ${dp_0_orientation} --pos ${dp_0_x}x${dp_0_y} \
    --output HDMI-1 --${hdmi_1_mode} --rotate ${hdmi_1_orientation} --pos ${hdmi_1_x}x${hdmi_1_y}
