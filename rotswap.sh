#!/bin/bash

# rotswap.sh 2016-11-08 by Peter B. Nelson
# alternate between normal and right-rotation modes
# for the Acer Aspire Switch 10 SW5-012-16GW
# to use on other systems, use: input --list 
# to find name of input device.
# use: xinput --list-props 'ITE Tech. Inc. ITE Device(8595) Touchpad'
# (for example) to see list of properties for a device
# 'ITE Tech. Inc. ITE Device(8595)' is the keyboard
# 'SYNA7300:00 06CB:0E75' is the touch screen
# 'ITE Tech. Inc. ITE Device(8595) Touchpad' is the touchpad

# use `xinput --list` to get names of input devices
TOUCHSCREEN=$(xinput --list|egrep -o "SYNA\w{4}:\w{2} \w{4}:\w{4}")
TOUCHPAD='ITE Tech. Inc. ITE Device(8595) Touchpad'

# get screen dimensions to determine current orientation portrait or landscape
X=$(xrandr --query | egrep -o "current \w{3,} x \w{3,}" | head -n 1 | cut -f2 -d ' ')
Y=$(xrandr --query | egrep -o "current \w{3,} x \w{3,}" | head -n 1 | cut -f4 -d ' ')

# get current brightness
BRIGHTNESS=$(xrandr --verbose | grep Brightness | cut -f2 -d ' ')

# get current screen name
DISPLAY_NAME=$(xrandr --query | grep ' connected' |  head -n 1 | cut -d ' ' -f1)

# finally, make adjustments
if [ $Y -gt $X ]; then
  xrandr --orientation normal
  xinput --set-prop "$TOUCHSCREEN" 'Evdev Axes Swap' 0 
  xinput --set-prop "$TOUCHSCREEN" 'Evdev Axis Inversion' 0 0 
  xinput --set-prop "$TOUCHPAD" 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1
  gsettings set com.canonical.Unity.Launcher launcher-position Left
else
  xrandr --orientation right
  xinput --set-prop "$TOUCHSCREEN" 'Evdev Axes Swap' 1 
  xinput --set-prop "$TOUCHSCREEN" 'Evdev Axis Inversion' 0 1 
  xinput --set-prop "$TOUCHPAD"  'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1 
  gsettings set com.canonical.Unity.Launcher launcher-position Bottom 
fi

# put screen brightness back to what it was
xrandr --output $DISPLAY_NAME --brightness $BRIGHTNESS
