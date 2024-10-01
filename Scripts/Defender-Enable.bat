@echo off
REM Deleting Windows Defender registry key

reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /f

echo Windows Defender registry key deleted successfully.
pause
