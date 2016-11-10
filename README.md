# rotswap

An Ubuntu screen rotation script for the Acer Aspire Switch 10 SW5-012-16GW two-in-one netbook/tablet hybrid. Running the script causes screen rotation to toggle between portrait (rotated right) and landscape (rotated normal) modes.


## installation

    cp rotswap.sh ~/
    sudo cp rotswap.desktop /usr/share/applications

At that point, use the Ubuntu application menu to search for *rotswap*, and when found drag its icon onto the Unity Launcher (or onto desktop, if you prefer).

That's it! There is no other installation required. The xrandr, xinput and gsettings commands used by the rotswap.sh script are all part of the standard Ubuntu installation.

## other systems

It should be possible to adapt this script for other hardware. Simply use the `xinput --list` command to get the appropriate device names, and modify the shell script accordingly.
