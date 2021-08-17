@echo off
Author Deepak (@HumanBoy23)
echo.&echo.
TITLE Splash Maker (Redmi Note 6 Pro)
:main
IF NOT EXIST "output" MKDIR output
IF NOT EXIST "bmps" MKDIR bmps
cls
echo.&echo.
echo               Splash Maker for Redmi Note 6 Pro (Tulip) & echo. & echo.
echo Press Enter to generate splash
pause >nul
:: Verifying files
set header="not_found"
IF EXIST header.img SET header="header.img"
if %header%=="not_found" (goto missing_warning)
set boot="not_found"
IF EXIST bmps\boot.bmp set boot="boot.bmp"
if %boot%=="not_found" (goto missing_warning)
set fastboot="not_found"
IF EXIST bmps\fastboot.bmp set fastboot="fastboot.bmp"
if %fastboot%=="not_found" (goto missing_warning)
set unlocked="not_found"
IF EXIST bmps\unlocked.bmp set unlocked="unlocked.bmp"
if %unlocked%=="not_found" (goto missing_warning)
set destroyed="not_found"
IF EXIST bmps\destroyed.bmp set destroyed="destroyed.bmp"
if %destroyed%=="not_found" (goto missing_warning)

::Generates Splash after all files are found
echo.&echo.
copy /b header.img+bmps\boot.bmp+bmps\fastboot.bmp+bmps\unlocked.bmp+bmps\destroyed.bmp output\splash_new.img
cls
echo.&echo.
echo Successfully created splash! (check output folder)
echo.
echo              Credits
echo  ---------------------------------
echo  -                               -
echo  #         @HumanBoy23           #
echo  -                               -
echo  ---------------------------------
pause&exit
:missing_warning
cls
echo.&echo.
echo FATAL_ERROR!! Required files to make splash are/is missing. View README.md
echo.&echo.&pause&exit