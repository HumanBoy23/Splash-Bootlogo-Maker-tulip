@echo off
IF EXIST output/splash_new.img goto :main
goto :nai
echo.
:main
cls
echo.Enter 0 to exit
echo.
set /P menu=Do you want to reboot device to fastboot and flash (Yes/No)?: 
if '%menu%'=='' echo EXITING.. & timeout 3 /nobreak >nul & Exit
if /I %menu%==yes (goto rbt_flash)
if /I %menu%==y (goto rbt_flash)
if /I %menu%==n (goto simply_flash)
if /I %menu%==no (goto simply_flash)
if %menu%==0 EXIT
:nope
echo ERROR: WRONG_COMMAND_ENTERED!!
pause 
goto main
echo.
:rbt_flash
cls
echo.
echo Connect Device with PC
adb wait-for-device
echo.
echo Device Found Rebooting to bootloader!
timeout 3 /nobreak >nul
adb reboot bootloader
timeout 3 /nobreak >nul
echo.
:simply_flash
cls
echo.&echo.&echo.Trying to flash from fastboot
fastboot flash splash output/splash_new.img
echo.&echo.
echo Now rebooting to bootloader (check if you see the fastboot image)
timeout 8 /nobreak >nul
fastboot reboot bootloader
echo.&echo.
timeout 8 /nobreak >nul
echo Now rebooting to system (check for startup image)
fastboot reboot
timeout 5 /nobreak >nul
EXIT
:nai
echo "splash_new.img" does not exist..EXITING &echo.&echo.&pause

