@echo off
echo.&&echo.
TITLE Boot Logo Backup tool
:main
cls
:: Stackoverflow link for formatting time and date https://stackoverflow.com/questions/1192476/format-date-and-time-in-a-windows-batch-script
:: Stackoverflow link for getting two digit hour/time instead of single digit hour/time to avoid syntax error while saving/renaming file
:: https://stackoverflow.com/questions/4984391/cmd-line-rename-file-with-date-and-time/18786818#18786818
SET get_hour=%time:~0,2%
:: After get hour/time convert to two digit always
SET get_hour=%get_hour: =0%
SET get_hour=%get_hour: =%
:: get minuite
SET get_min=%time:~3,2%
:: date
SET get_day=%date:~0,2%
:: Month
SET get_month=%date:~3,2%
:: Year
SET get_year=%date:~6,5%
:: Making directory named backup
IF NOT EXIST backup MKDIR backup
echo.
echo Make sure that you have a custom recovery installed. Because this tool will
echo use custom recovery as a means to pull splash (boot logo)
echo.
SET /P menu=Reboot Device to recovery [Y/N]:
if '%menu%'=='' (goto rbt_recBk)
if /I %menu%==y (goto rbt_recBk)
if /I %menu%==n (goto yes_backup)
:rbt_recBk
cls
echo.
echo Connect your Device to PC
adb.exe wait-for-device
adb reboot recovery
timeout 50
:yes_backup
cls
echo.&echo.
echo Backingup..
adb.exe pull /dev/block/bootdevice/by-name/splash "backup/splash_%get_day%%get_month%%get_year%_%get_hour%%get_min%.img"
echo.&echo.
timeout 4 /nobreak >nul
cls
echo.&echo.
SET /P menu=Do you want to reboot your device [Y/N]: 
if '%menu%'=='' (goto main)
if /I %menu%== y (goto rbt_afterBk)
if /I %menu%== n (goto main)
:nope
echo ERROR: WRONG_COMMAND_ENTERED!
pause
goto main
echo.
:rbt_afterBk
echo Rebooting Device.. &echo.&echo.
echo If backup succeded it will be stored in backup folder
adb reboot
pause