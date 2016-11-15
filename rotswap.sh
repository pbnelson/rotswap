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

# see if screen is already rotated (portrait mode)
xrandr -d :0.0 | grep "800 x 1280" >/dev/null
ROTATED=$?

# use `xinput --list` to get names of input devices
TOUCHSCREEN='SYNA7300:00 06CB:0E75'
TOUCHPAD='ITE Tech. Inc. ITE Device(8595) Touchpad'

if [ $ROTATED -eq 0 ]; then
  rm $CHKFILE
  xrandr -o normal &
  xinput --set-prop "$TOUCHSCREEN" 'Evdev Axes Swap' 0 &
  xinput --set-prop "$TOUCHSCREEN" 'Evdev Axis Inversion' 0 0 &
  xinput --set-prop "$TOUCHPAD" 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1 &
  gsettings set com.canonical.Unity.Launcher launcher-position Left &
else
  touch $CHKFILE
  xrandr -o right &
  xinput --set-prop "$TOUCHSCREEN" 'Evdev Axes Swap' 1 &
  xinput --set-prop "$TOUCHSCREEN" 'Evdev Axis Inversion' 0 1 &
  xinput --set-prop "$TOUCHPAD"  'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1 &
  gsettings set com.canonical.Unity.Launcher launcher-position Bottom &
fi
