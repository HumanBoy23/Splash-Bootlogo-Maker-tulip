#!/bin/bash
#
# splash/boot logo backup script
#
# Date and Time in Today Variable
# Like current: Hour-Minuite-Second-Day-Month-Year
TODAY="$(date +"%H%M%S-%d%m%Y")"
# Creating folder to store backup
if [ ! -e backup ]
then
    mkdir backup
fi    
# Checking user is root
echo "Checking root permission"
sleep 4s
if [ $(whoami) != root ];
then
    echo && echo "Type su to grant root access"
    echo && echo "Root permission denied or"
    echo "your device is not rooted to backup"
    echo
    echo "Failed to backup"
    sleep 2s
    exit
else
    echo && echo "Root access granted!"
    echo && echo "Backing up Boot Logo (splash)"
    sleep 4s
    dd if=/dev/block/bootdevice/by-name/splash of=$(pwd)/backup/splash_$TODAY.img status=none
    echo && echo "Backup successful!" 
    echo "Location: $(pwd)/backup"
    echo && echo "You can flash the backup from recovery"
    echo "or by typing: dd if=backup/nameofbackup.img of=/dev/block/bootdevice/by-name/splash"
    echo "(ROOT REQUIRED)"
    echo && sleep 3s && exit
fi    