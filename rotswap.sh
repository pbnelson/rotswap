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

# 2017-04-19, updated to support Acer Aspire R15 and hopefully
# other devices as well (more generic).

# get input device names using `xinput --list`
TOUCHSCREEN=$(xinput --list --name-only | grep -i touchscreen | head -1)
TOUCHPAD=$(xinput --list --name-only | grep -i touchpad | head -1)

# if touchscreen variable is still null, search for it under the
# name of SYNA7508 or SYN7300, but be careful not to get the pen
if [ -z "$TOUCHSCREEN" ]; then
  TOUCHSCREEN=$(xinput --list | egrep -o "SYNA\w{4}:\w{2} \w{4}:\w{4}" | grep -v Pen | head -n 1)
fi

# get screen dimensions to determine current orientation portrait or landscape
X=$(xrandr --query | egrep -o "current \w{3,} x \w{3,}" | head -n 1 | cut -f2 -d ' ')
Y=$(xrandr --query | egrep -o "current \w{3,} x \w{3,}" | head -n 1 | cut -f4 -d ' ')

# get current brightness
BRIGHTNESS=$(xrandr --verbose | grep Brightness | cut -f2 -d ' ')

# get current screen name
DISPLAY_NAME=$(xrandr --query | grep ' connected' |  head -n 1 | cut -d ' ' -f1)

# handy variable for unity launcher's gnome-settings schema name
ULSSNAME="gsettings set com.canonical.Unity.Launcher"

# landscape/portrait mode settings
if [ $Y -gt $X ]; then # if Y>X then portrait mode, so switch to landscape
  ORIENTATION="normal"
  AXESSWAP="0"
  AXISINVERSION="0 0"
  TRANSMATRIX="1 0 0 0 1 0 0 0 1"
  ULSSPOSITION="Left"
else # in lanscape mode, so switch to portrait
  ORIENTATION="right"
  AXESSWAP="1"
  AXISINVERSION="0 1"
  TRANSMATRIX="0 1 0 -1 0 1 0 0 1"
  ULSSPOSITION="Bottom"
fi

# Finally! make all adjustments
###############################

# orientation and brightness
xrandr --orientation $ORIENTATION
xrandr --output $DISPLAY_NAME --brightness $BRIGHTNESS

# axes swap, axis inversion and coordinate transformation
xinput --set-prop "$TOUCHSCREEN" 'Evdev Axes Swap' $AXESSWAP
xinput --set-prop "$TOUCHSCREEN" 'Evdev Axis Inversion' $AXISINVERSION
xinput --set-prop "$TOUCHPAD" 'Coordinate Transformation Matrix' $TRANSMATRIX

# set ubuntu's unity launcher location
gsettings list-schemas | grep "$ULSSNAME" && gsettings set "$ULSSNAME" launcher-position $ULSSPOSITION
