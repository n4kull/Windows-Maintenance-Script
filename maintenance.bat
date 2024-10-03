@echo off
:menu
cls
echo ======================================
echo         Maintenance Menu
echo ======================================
echo.
echo -  1. System Updates Menu
echo -  2. Defender Menu
echo -  3. Perform app updates
echo.
echo -  4. Clean Up Temporary files
echo -  5. Disk Cleanup
echo -  6. Scripts
echo -  7. Exit
echo ======================================
echo.

set /p choice=Select an option (1-8): 

if %choice%==1 goto update_menu
if %choice%==2 goto defender_menu
if %choice%==3 goto app_updates
if %choice%==4 goto temp_clean
if %choice%==5 goto disk_cleanup
if %choice%==6 goto scripts
if %choice%==7 goto exit

goto menu

:app_updates
cls
echo Getting App Updates...
start "" "%~dp0Scripts\Winget Helper\winget-helper.bat" 
goto menu

:temp_clean
cls
echo Cleaning temporary files...
rd /s /q "%temp%"
mkdir "%temp%"
echo Temporary files cleaned.
pause
goto menu

:disk_cleanup
cls
echo Launching Disk Cleanup...
cleanmgr
goto menu

:update_menu
cls
echo ======================================
echo         System Updates Menu
echo ======================================
echo.
echo -  1. Enable Update Services
echo -  2. Enable Updates
echo -  3. Disable Update
echo -  4. Go Back
echo ======================================
echo.

set /p choice=Select an option (1-4): 

if %choice%==1 goto update_services
if %choice%==2 goto enable_updates
if %choice%==3 goto disable_updates
if %choice%==4 goto menu

:enable_updates
cls
echo Enabling system updates and checking for updates manually...
start "" "%~dp0Scripts\tsgrgo\Update-Enable.bat"
goto menu

:disable_updates
cls
echo Disabling system updates...
start "" "%~dp0Scripts\tsgrgo\Update-Disable.bat"
goto menu

:defender_menu
cls
color 07
echo ======================================
echo         Defender Menu
echo ======================================
echo.
echo -  1. Disable Tamper Protection (manual step)
echo -  2. Disable Defender's Services (keep UI)
echo -  3. Restore Defender's Services to default
echo -  4. Completely Remove Defender (may trigger AV)
echo -  5. Back to Maintenance Menu
echo ======================================
echo.

set /p choice1=Select an option (1-5): 

if %choice1%==1 goto tamper_protection
if %choice1%==2 goto disable_def_serv
if %choice1%==3 goto enable_def_serv
if %choice1%==4 goto remove_def_permanent
if %choice1%==5 goto menu

goto defender_menu

:tamper_protection
cls
echo To disable Tamper Protection, follow these steps:
echo 1. Open Windows Security.
echo 2. Go to "Virus & threat protection."
echo 3. Click on "Manage settings."
echo 4. Toggle "Tamper Protection" off.
pause
goto defender_menu

:disable_def_serv
cls
echo Disabling Defender's services...
start "" "%~dp0Scripts\Defender-Disable.bat"
goto defender_menu

:enable_def_serv
cls
echo Restoring Defender's services to default...
start "" "%~dp0Scripts\Defender-Enable.bat"
goto defender_menu

:remove_def_permanent
cls
color 04
echo ======================================
echo        ! Defender WARNING !
echo ======================================
echo You are about to remove Windows Defender.
echo This action is PERMANENT and cannot be undone.
echo Windows update may bring back Defender.
echo ======================================
echo.
echo 1. Proceed to Completely Remove Defender
echo 2. Go Back
echo.

set /p choice2=Select an option (1-2): 

if %choice2%==1 goto nuke_def
if %choice2%==2 goto defender_menu
goto remove_def_permanent

:nuke_def
cls
echo Removing Defender permanently...
start "" "%~dp0Scripts\ionuttbara\DefenderRemover.exe"
goto defender_menu

:scripts
cls
echo 1. Open scripts section
echo 2. Go Back
echo.
set /p choice3=Select an option (1-2): 
if %choice3%==1 goto scripts_section
if %choice3%==2 goto menu

:scripts_section
cls
cd "%~dp0Scripts\"
echo Available scripts:
tree /f
echo.
echo Press Ctrl + C only one time.
set /p script_choice=Copy/paste the exact name to execute:
start "" "%~dp0Scripts\%script_choice%"
goto scripts
 
:exit
echo Exiting...
exit