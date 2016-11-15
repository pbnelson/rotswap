# rotswap.sh

An Ubuntu screen rotation script for the Acer Aspire Switch 10 SW5-012-16GW two-in-one netbook/tablet hybrid. Running the script causes screen rotation to toggle between portrait (rotated right) and landscape (rotated normal) modes.

In addition to the screen alternating between portrait/landscape, the unity launcher is moved, and the axes are all correctly inverted for: touchscreen, touchpad and mouse.

## installation

Download these two files, then copy them to the appropriate place:

    sudo cp rotswap.sh /usr/local/bin/
    sudo cp rotswap.desktop /usr/share/applications/

Next, use the Ubuntu application menu to search for *Swap Screen Rotation* and drag its icon onto the Unity Launcher (or the desktop if you prefer). Here's a screenshot:

![Launcher Screenshot](./img/screenshot%231.png)

That's it! There is no other installation required. The xrandr, xinput and gsettings commands used by rotswap.sh are in the standard Ubuntu distribution.

## usage

To use, simply click or press the arrow button. The screen will swap to portrait or landscape, and the touch-screen, touch-pad and mouse will all invert their axes as appropriate.

### other systems

It should be easy to adapt this script for other hardware. Simply use the `xinput --list` command to get the appropriate device names, and modify the shell script accordingly. You may have to alter the 800x1200 resolution grep to match your monitor dimensions.

### bugs

There is a Unity Launcher bug that ignores the StartupNotify=false setting. The consequence is that the icon will flash for seven seconds after clicking/pressing, and during that time it cannot be pressed again. As a practical matter, it is no big deal not being able to switch orientation more than once every seven seconds. If anyone knows how to fix, drop me a line, please, or even submit a pull request.
