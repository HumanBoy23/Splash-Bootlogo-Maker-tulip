#!/bin/bash
##
# boot logo flasher (Root)
# Root is required to flash boot logo
# if  you have not rooted your phone you need to flash it through
# recovery or fastboot
##
##
# Author
AUTHOR="@HumanBoy23"
##
# Requestion root permission to flash splash (obviously) what you thought hacking? :)
echo
echo "Trying to flash splash (Boot Logo)"
if [  $(whoami) != root ];
then
    echo "Please Grant Root Access Permission by typing su"
    echo "then retype bash/sh flash.sh and press enter"
    exit
else
    echo
    sleep 4s
    echo "Searching for Boot Logo"
fi
if [ ! -f splash_new/splash_new.img ]
then
    echo
    echo "A suitable Boot Logo is missing"
    echo "ERROR::FILE_NOT_FOUND"
    echo "Create boot logo and try again"
    exit
else
    echo "Flashing your Custom Boot Logo..."
fi
# dd will flash the custom splash if root permission is granted
dd if=splash_new/splash_new.img of=/dev/block/bootdevice/by-name/splash status=none
sleep 3s
clear
echo && echo && echo && echo
echo "Successfully Flashed your Custom Boot Logo (splash)"
echo "Please perform a fastboot reboot then a normal reboot to check"
echo
sleep 5s
exit
