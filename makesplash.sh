#!/bin/bash
#
# Updated On: 27-August-2022 11:47 PM (IST)
# By @HumanBoy23
#
# Do not modify if you don't know what you're doing!!
# Only for Redmi Note 6 Pro. Do not use on other Device!
#
# Setting Variables #
# Script name and version
TOOL_VERSION="Splash Maker Tool v2.2"
# Below is why this version exists
: '
Corrected syntax error on line 229

Updated Instruction/Readme file
' 
# Screen Resoultion (Portrait) of Xiaomi Redmi Note 6 Pro
BOOTLOGO_RESOLUTION="1080*2160 (Portrait)"
RESOLUTION="1080*2160"
DEVICE_RESOLUTION="1080*2280 (Portrait)"
# Calling this to print location of file 
OUTPUT_LOCATION="Check $(pwd)/splash_new folder for your custom splash/boot logo.."
# Device Model/Series name, Manufacturer and Device Codename
MANUFACTURER="Xiaomi"
MODEL="Redmi Note 6 Pro"
DEVICE="(Tulip)"
# Author Detail(s)
AUTHOR="@HumanBoy23"
#
# Creating Folders
if [ ! -e pics ] 
then 
    mkdir pics
else
    sleep 1s
fi
if [ ! -e bmps ] 
then 
    mkdir bmps
else
    sleep 1s
fi
if [ ! -e splash_new ]
then
    mkdir splash_new
else
    sleep 1s
fi    
echo
echo "$MANUFACTURER $MODEL $DEVICE $TOOL_VERSION"
echo "Device Resolution: $DEVICE_RESOLUTION"
echo "Boot Logo Resolution: $BOOTLOGO_RESOLUTION"
echo
# Perform jpg/png file check in pics folder (given by user)
echo "verifying required image files in pics folder.."
sleep 3s
if [[ ! -f pics/boot.jpg ]] && [[ ! -f pics/boot.PNG ]]
then
    echo "image for boot not found in pics folder" 
    echo "read INSTRUCTIONS.txt"
    exit
else
    sleep 1s
fi
if [[ ! -f pics/fastboot.jpg ]] && [[ ! -f pics/fastboot.PNG ]]
then
    echo "image for fastboot not found in pics folder" 
    echo "read INSTRUCTIONS.txt"
    exit
else
    sleep 1s
fi
if [[ ! -f pics/destroyed.jpg ]] && [[ ! -f pics/destroyed.PNG ]]
then
    echo
    echo "image for destroyed not found in pics folder" 
    echo "read INSTRUCTIONS.txt"
    exit
else
    sleep 1s
fi
echo "files verified"
sleep 3s
# Continue with convertion process-
# Creating header.img
echo
dd if=/dev/zero of=header.img bs=16384 count=1 status=none
sleep 2s
#
# Check if header.img is created or not
if [ ! -f header.img ]
then
    echo
    echo "CRITICAL_ERROR: header.img is missing. Is dd installed?"
    echo "If not, install dd and run scrip again.."
    exit
else
    sleep 1s
fi
#
# Creating small.img
dd if=/dev/zero bs=1 count=259 of=small.img status=none
echo "Continuing script.."
sleep 3s
#
# Checking if small.img is created or not
if [ ! -f small.img ]
then
    echo
    echo "CRITICAL ERROR: small.img is missing. Is dd installed?"
    echo "If not, install dd and run scrip again.."
    exit
fi
echo && echo "Converting User provided files:"
echo "(This will take some time)"
echo
sleep 3s
# Creating boot.bmp
echo "--creating boot logo.."
if [ ! -f pics/boot.jpg ]
then
    ffmpeg -hide_banner -loglevel panic -i "pics/boot.png" -pix_fmt rgb24 -s $RESOLUTION -y "bmps/boot_tmp.bmp"
    sleep 1s
    dd if=bmps/boot_tmp.bmp count=6998197 bs=1 of=bmps/boot_tmp1.bmp status=none
    sleep 1s
    cat bmps/boot_tmp1.bmp small.img >bmps/boot.bmp
    sleep 1s
    rm -rf bmps/boot_tmp.bmp && rm -rf bmps/boot_tmp1.bmp
else
    ffmpeg -hide_banner -loglevel panic -i "pics/boot.jpg" -pix_fmt rgb24 -s $RESOLUTION -y "bmps/boot_tmp.bmp"
    sleep 1s
    dd if=bmps/boot_tmp.bmp count=6998197 bs=1 of=bmps/boot_tmp1.bmp status=none
    sleep 1s
    cat bmps/boot_tmp1.bmp small.img >bmps/boot.bmp
    sleep 1s
    rm -rf bmps/boot_tmp.bmp && rm -rf bmps/boot_tmp1.bmp
fi
sleep 2s
# Creating fastboot.bmp
echo "--creating fastboot logo.."
if [ ! -f pics/fastboot.jpg ]
then
    ffmpeg -hide_banner -loglevel panic -i "pics/fastboot.png" -pix_fmt rgb24 -s $RESOLUTION -y "bmps/fst_tmp.bmp"
    sleep 1s
    dd if=bmps/fst_tmp.bmp count=6998197 bs=1 of=bmps/fst_tmp1.bmp status=none
    sleep 1s
    cat bmps/fst_tmp1.bmp small.img >bmps/fastboot.bmp
    sleep 1s
    rm -rf bmps/fst_tmp.bmp && rm -rf bmps/fst_tmp1.bmp
else
    ffmpeg -hide_banner -loglevel panic -i "pics/fastboot.jpg" -pix_fmt rgb24 -s $RESOLUTION -y "bmps/fst_tmp.bmp"
    sleep 1s
    dd if=bmps/fst_tmp.bmp count=6998197 bs=1 of=bmps/fst_tmp1.bmp status=none
    sleep 1s
    cat bmps/fst_tmp1.bmp small.img >bmps/fastboot.bmp
    sleep 1s
    rm -rf bmps/fst_tmp.bmp && rm -rf bmps/fst_tmp1.bmp
fi
sleep 2s
# Creating unlocked.bmp by making a copy of boot.bmp
echo "--creating unlocked logo"
dd if=bmps/boot.bmp of=bmps/unlocked.bmp status=none
sleep 2s
# Creating destroyed.bmp
echo "--creating system destroyed logo.."
if [ ! -f pics/destroyed.jpg ]
then
    ffmpeg -hide_banner -loglevel panic -i "pics/destroyed.png" -pix_fmt rgb24 -s $RESOLUTION -y "bmps/destroyed_tmp.bmp"
    sleep 1s
    dd if=bmps/destroyed_tmp.bmp count=6998197 bs=1 of=bmps/destroyed_tmp1.bmp status=none
    sleep 1s
    cat bmps/destroyed_tmp1.bmp small.img >bmps/destroyed.bmp
    sleep 1s
    rm -rf bmps/destroyed_tmp.bmp && rm -rf bmps/destroyed_tmp1.bmp
else
    ffmpeg -hide_banner -loglevel panic -i "pics/destroyed.jpg" -pix_fmt rgb24 -s $RESOLUTION -y "bmps/destroyed_tmp.bmp"
    sleep 1s
    dd if=bmps/destroyed_tmp.bmp count=6998197 bs=1 of=bmps/destroyed_tmp1.bmp status=none
    sleep 1s
    cat bmps/destroyed_tmp1.bmp small.img >bmps/destroyed.bmp
    sleep 1s
    rm -rf bmps/destroyed_tmp.bmp && rm -rf bmps/destroyed_tmp1.bmp
fi
echo "Finised with Conversion Process"
#
# Checking bmp files
echo
echo "Final verification:"
sleep 2s
if [ ! -f bmps/boot.bmp ]
then
    echo "ERROR::FILE_NOT_FOUND (Read Instructions Carefully)"
    rm -rf header.img && rm -rf small.img && rm -rf bmps
    exit
fi
if [ ! -f bmps/fastboot.bmp ]
then
    echo "ERROR::FILE_NOT_FOUND (Read Instructions Carefully)"
    rm -rf header.img && rm -rf small.img && rm -rf bmps
    exit
fi
if [ ! -f bmps/unlocked.bmp ]
then
    echo "ERROR::FILE_NOT_FOUND (Read Instructions Carefully)"
    rm -rf header.img && rm -rf small.img && rm -rf bmps
    exit
fi
if [ ! -f bmps/destroyed.bmp ]
then
    echo "ERROR::FILE_NOT_FOUND (Read Instructions Carefully)"
    rm -rf header.img && rm -rf small.img && rm -rf bmps
    exit
fi
    # Merging header.img and bmp files into one splash (img) file
    echo merging files..
    cat header.img bmps/boot.bmp bmps/fastboot.bmp bmps/unlocked.bmp bmps/destroyed.bmp >splash_new/splash_new.img
    echo "success.."
    sleep 2s
# Remove temporary files created by script (housekeeping)
rm -rf header.img && rm -rf small.img && rm -rf bmps
    sleep 3s
    clear
    echo && echo && echo && echo
    echo "Successfully Created your Custom Boot Logo (splash)"
    echo "$OUTPUT_LOCATION"
    echo
    echo "If you want to flash it now then type: su and press enter"
    echo "then type bash/sh flash.sh and press enter (root is required)"
    sleep 4s
    echo
    echo "$TOOL_VERSION for Redmi Note 6 Pro (Tulip)"
    echo "By $AUTHOR"
    exit
