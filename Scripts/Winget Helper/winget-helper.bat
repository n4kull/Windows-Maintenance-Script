@echo off
setlocal enabledelayedexpansion
set "exclude_file=excluded_packages.txt"

:: Create the exclusion list file if it doesn't exist
if not exist "%exclude_file%" echo. > "%exclude_file%"

:MENU
cls
echo ==============================
echo Winget Helper Menu
echo ==============================
echo 1. Search for a Package
echo 2. Install a Package
echo 3. Upgrade All Packages
echo 4. Uninstall a Package
echo 5. Show Installed Packages
echo 6. Upgrade Specific Package
echo 7. Upgrade All Except Excluded Packages
echo 8. Manage Excluded Packages
echo 9. Exit
echo ==============================
set /p choice=Enter your choice (1-9):

if %choice%==1 goto SEARCH
if %choice%==2 goto INSTALL
if %choice%==3 goto UPGRADE_ALL
if %choice%==4 goto UNINSTALL
if %choice%==5 goto SHOW_INSTALLED
if %choice%==6 goto UPGRADE_SPECIFIC
if %choice%==7 goto UPGRADE_EXCEPT
if %choice%==8 goto MANAGE_EXCLUDE
if %choice%==9 goto EXIT
goto MENU

:SEARCH
set /p package_name=Enter package name to search:
winget search "%package_name%"
pause
goto MENU

:INSTALL
set /p package_name=Enter package name to install:
winget install "%package_name%" --silent --accept-package-agreements
pause
goto MENU

:UPGRADE_ALL
winget upgrade --all --silent --accept-package-agreements
pause
goto MENU

:UNINSTALL
set /p package_name=Enter package name to uninstall:
winget uninstall "%package_name%" --silent
pause
goto MENU

:SHOW_INSTALLED
winget list
pause
goto MENU

:UPGRADE_SPECIFIC
set /p package_name=Enter package name to upgrade:
winget upgrade "%package_name%" --silent --accept-package-agreements
pause
goto MENU

:UPGRADE_EXCEPT
echo Fetching list of upgradable packages...
for /f "tokens=1" %%i in ('winget upgrade --id') do (
    set "package_id=%%i"
    call :CHECK_EXCLUDE
)
pause
goto MENU

:CHECK_EXCLUDE
findstr /i /c:"%package_id%" "%exclude_file%" >nul
if errorlevel 1 (
    echo Upgrading package: %package_id%
    winget upgrade "%package_id%" --silent --accept-package-agreements
) else (
    echo Skipping excluded package: %package_id%
)
goto :EOF

:MANAGE_EXCLUDE
cls
echo ==============================
echo Installed Packages
echo ==============================
:: Display the list of installed packages so the user can copy the ones they want to exclude
winget list
echo.
echo ==============================
echo How to Manage Excluded Packages:
echo - Copy/Paste package names from the above list into the exclusion list
echo - Use option 3 to open the exclusion list location for editing
echo ==============================
echo 1. View Excluded Packages
echo 2. Clear Excluded Packages List
echo 3. Open Excluded Packages List Location
echo 4. Return to Main Menu
echo ==============================
set /p exclude_choice=Enter your choice (1-4):

if %exclude_choice%==1 goto VIEW_EXCLUDE
if %exclude_choice%==2 goto CLEAR_EXCLUDE
if %exclude_choice%==3 goto OPEN_EXCLUDE
if %exclude_choice%==4 goto MENU
goto MANAGE_EXCLUDE


:VIEW_EXCLUDE
cls
echo Excluded Packages List:
echo ==============================
type "%exclude_file%"
echo ==============================
pause
goto MANAGE_EXCLUDE

:CLEAR_EXCLUDE
cls
echo Are you sure you want to clear the exclusion list? (y/n)
set /p clear_confirm=
if /i "%clear_confirm%"=="y" (
    echo. > "%exclude_file%"
    echo Excluded packages list cleared!
)
pause
goto MANAGE_EXCLUDE

:OPEN_EXCLUDE
explorer "%exclude_file%"
goto MANAGE_EXCLUDE

:EXIT
exit