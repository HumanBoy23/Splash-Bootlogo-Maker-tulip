@echo off
Author Deepak (@HumanBoy23)
echo.&echo.
SET tool_version="Splash Maker (Redmi Note 6 Pro) v2 04-08-2022"
TITLE Splash Maker (Redmi Note 6 Pro)
:main
:: Boot Logo (splash) size/resolution
SET logo_resolution="1080*2160"
::
:: Device screen size/resoultion
SET device_resolution="1080*2280"
::
:: Setting and creation of folders
::
:: User will add his desired image(s) files inside pics folder
IF NOT EXIST "pics" MKDIR pics
::
:: Script will store some temporary files in temp folder
IF NOT EXIST "temp" MKDIR temp
:: 
:: Output location of custom boot logo
IF NOT EXIST "splash_new" MKDIR splash_new
:: Header for empty file at start of splash.img
IF NOT EXIST bin\header.img fsutil file createnew bin\header.img 16384
:: Small.img - Will be appended after dd removes curse given by ffmpeg to bmp files
IF NOT EXIST bin\small.img fsutil file createnew bin\small.img 259
:: Required softwares - dd for windows and ffmpeg for windows
IF NOT EXIST bin\dd.exe (goto missing_warning)
IF NOT EXIST bin\ffmpeg.exe (goto missing_warning)
cls
echo.&echo.
echo               Splash Maker for Redmi Note 6 Pro (Tulip) & echo. Device Resoultion: %device_resolution% Boot Logo Resolution: %logo_resolution% & echo.
echo Press Enter to generate splash
pause >nul
cls
:: Verifying files
::
:: boot file set as empty
SET boot="not_found"
:: will change boot variable to boot.png if found
IF EXIST pics\boot.png SET boot="boot.png"
:: if boot.png is not found it will check for boot.jpg
IF %boot%=="not_found" (goto check_bootis_jpg)
:: after failure to find boot.png, script checks for boot.jpg
:check_bootis_jpg
IF EXIST pics\boot.jpg SET boot="boot.jpg"
:: if both boot.png and boot.jpg are not found script will throw an exception
IF %boot%=="not_found" (goto boot_not_found)
::
:: default value of fastboot file
SET fastboot="not_found"
:: will change fastboot variable to fastboot.png if found
IF EXIST pics\fastboot.png SET fastboot="fastboot.png"
:: if fastboot.png is not found it will check for fastboot.jpg
IF %fastboot%=="not_found" (goto check_fastbootis_jpg)
:: after failure to find fastboot.png, script checks for fastboot.jpg
:check_fastbootis_jpg
IF EXIST pics\fastboot.jpg SET fastboot="fastboot.jpg"
:: if both fastboot.png and fastboot.jpg are not found script will throw an exception
IF %fastboot%=="not_found" (goto fastboot_not_found)
:: Default value of destroyed variable
SET destroyed="not_found"
:: will change destroyed variable to destroyed.png if found
IF EXIST pics\destroyed.png SET destroyed="destroyed.png"
:: if destroyed.png is not found it will check for destroyed.jpg
IF %destroyed%=="not_found" (goto check_destroyedis_jpg)
:: after failure to find destroyed.png, script checks for destroyed.jpg
:check_destroyedis_jpg
IF EXIST pics\destroyed.jpg SET destroyed="destroyed.jpg"
:: if both destroyed.png and destroyed.jpg are not found script will throw an exception
IF %destroyed%=="not_found" (goto destroyed_not_found)
::
:: Converting files to RGB 24 bit windows bitmap (*.BMP) image format using ffmpeg open source imaging (it can do more than just images) library
::
:: Converting boot image too bmp
echo. & echo. Converting user provided files: &echo.
echo Converting %boot%
bin\ffmpeg.exe -hide_banner -loglevel panic -i pics/%boot% -pix_fmt rgb24 -s %logo_resolution% -y temp/boot_cursed.bmp
:: Removing curse given by ffmpeg at end of file
timeout 2 /nobreak >nul
bin\dd.exe if=temp/boot_cursed.bmp count=6998197 bs=1 of=temp/boot.bmp
timeout 1 /nobreak >nul
:: Replace removed curse empty area with god's healing power and regrow removed part
copy /b temp\boot.bmp+bin\small.img temp\boot_healed.bmp
timeout 2 /nobreak >nul
cls
:: Making a copy of boot.bmp and renamed to unlocked.bmp
echo Making a copy of boot.bmp for unlocked (unlocked.bmp)
copy temp\boot_healed.bmp temp\unlocked.bmp
timeout 1 /nobreak >nul
del temp\boot.bmp >nul
timeout 2 /nobreak >nul
:: Deleting cursed file
del temp\boot_cursed.bmp
timeout 2 /nobreak >nul
cls
:: Converting fastboot image to bmp
echo Converting %fastboot%
bin\ffmpeg.exe -hide_banner -loglevel panic -i pics/%fastboot% -pix_fmt rgb24 -s %logo_resolution% -y temp/fastboot_cursed.bmp
:: Removing curse given by ffmpeg at end of file
timeout 2 /nobreak >nul
bin\dd.exe if=temp/fastboot_cursed.bmp count=6998197 bs=1 of=temp/fastboot.bmp
timeout 1 /nobreak >nul
:: Replace removed area with god's healing power and regrow removed part
copy /b temp\fastboot.bmp+bin\small.img temp\fastboot_healed.bmp
timeout 1 /nobreak >nul
del temp\fastboot.bmp
:: Deleting cursed file
del temp\fastboot_cursed.bmp
timeout 2 /nobreak >nul
cls
:: Converting destroyed
echo Converting %destroyed%
bin\ffmpeg.exe -hide_banner -loglevel panic -i pics/%destroyed% -pix_fmt rgb24 -s %logo_resolution% -y temp/destroyed_cursed.bmp
timeout 2 /nobreak >nul
:: Removing curse given by ffmpeg at end of file
bin\dd.exe if=temp/destroyed_cursed.bmp count=6998197 bs=1 of=temp/destroyed.bmp
timeout 1 /nobreak >nul
:: Replace removed curse empty area with god's healing power and regrow removed part
copy /b temp\destroyed.bmp+bin\small.img temp\destroyed_healed.bmp
timeout 1 /nobreak >nul
del temp\destroyed.bmp
timeout 2 /nobreak >nul
:: Deleting cursed file
del temp\destroyed_cursed.bmp
timeout 2 /nobreak >nul
cls
::
::Generates Splash after all files are converted
::
echo.&echo Finished with conversion. Now merging and creating Boot Logo
timeout 4 /nobreak >nul
copy /b bin\header.img+temp\boot_healed.bmp+temp\fastboot_healed.bmp+temp\unlocked.bmp+temp\destroyed_healed.bmp splash_new\splash_new.img
:: Delete temporary files
IF EXIST temp DEL /Q temp
::
cls
echo.&echo.
echo Successfully created Boot Logo! (check splash_new folder)
echo.
echo   %tool_version% &echo.
echo              Credits
echo  ---------------------------------
echo  -                               -
echo  #         @HumanBoy23           #
echo  -                               -
echo  ---------------------------------
echo.&echo Run Flash_Logo.cmd to flash your custom Boot Logo &echo.
echo Press any key to Exit..
pause >nul &exit
:missing_warning
cls
echo.&echo.
echo FATAL_ERROR!! Required files to make splash are/is missing. Please redownload and/or extract the tool again
echo.&echo.&pause&exit
:boot_not_found
echo. & echo File for boot not found read instructions &pause&exit
:fastboot_not_found
echo. & echo File for fastboot not found read instructions &pause&exit
:destroyed_not_found
echo. & echo File for destroyed not found read instructions &pause&exit