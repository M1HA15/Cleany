@echo off
title Cleany (0.3)
cls

where powershell >nul 2>&1
if %errorlevel% neq 0 (
    color 0C
    echo PowerShell is not installed. Please install PowerShell and run the script again!
    echo.
    pause
    exit
)

for /f "delims=" %%V in ('powershell -Command "$PSVersionTable.PSVersion.Major.ToString() + '.' + $PSVersionTable.PSVersion.Minor.ToString()"') do set "PSVersion=%%V"

>nul 2>&1 net session || (
    color 0C
    echo This script requires Administrator Privileges.
    echo Please run the script as an Administrator!
    echo.
    echo PowerShell Version: %PSVersion%
    echo.
    pause
    exit
)

:mainMenu
cls
echo ---------------------------------------------------------------------
echo                              Cleany (0.3)
echo.
echo           Warning: This version may contain bugs or issues!
echo                 Running with Administrator Privileges
echo                    PowerShell Version: %PSVersion%
echo ---------------------------------------------------------------------
echo.
echo [1] Run Cleany (Recommended)
echo [2] View Potential Risks
echo [3] Info About Your PC
echo [4] Info About Script
echo [5] Exit
echo.
set /p "choice=Enter your choice (1-5): "
if "%choice%"=="1" goto :cleany
if "%choice%"=="2" goto :potentialRisks
if "%choice%"=="3" goto :infoPC
if "%choice%"=="4" goto :infoScript
if "%choice%"=="5" goto :exitMenu
goto :mainMenu

:potentialRisks
cls
echo ---------------------------------------------------------------------
echo                   Potential Risks While Running Cleany
echo ---------------------------------------------------------------------
echo.
echo - Deleting system files may cause instability or loss of data.
echo.
echo - Stopping essential services can affect system functionality.
echo.
echo - Restarting Explorer may temporarily interrupt desktop experience.
echo.
echo - Cleaning system logs may impact troubleshooting capabilities.
echo.
echo - Deleting Windows Update files might affect future updates.
echo.
pause
goto :mainMenu

:infoPC
cls
echo ---------------------------------------------------------------------
echo                      Info About Your PC
echo ---------------------------------------------------------------------
echo.
systeminfo | more
pause
goto :mainMenu

:infoScript
cls
set "betaVersion=No"
echo ---------------------------------------------------------------------
echo                      Info About Script
echo ---------------------------------------------------------------------
echo.
echo Script Name: Cleany
echo Version: 0.3
echo Author: M1HA15
echo Beta Version: %betaVersion%
echo.
set /p "openGitHub=Do you want to open the Cleany GitHub Page? (Y/N): "
if /i "%openGitHub%"=="Y" (
    echo Opening default web browser...
    start "" "https://github.com/M1HA15/Cleany"
) else (
    echo Skipping this part...
)
echo.
set /p "openCleany=Do you want to check NSR? (Y/N): "
if /i "%openCleany%"=="Y" (
    echo Opening default web browser...
    start "" "https://github.com/M1HA15/Network-Settings-Reset"
) else (
    echo Skipping this part...
)
echo.
pause
goto :mainMenu

:cleany
cls
echo ---------------------------------------------------------------------
echo                         Cleany - System Cleaner
echo ---------------------------------------------------------------------
echo.
echo Opening System Restore Point...
echo Please manually create a Restore Point!
start "" /wait "C:\Windows\System32\SystemPropertiesProtection.exe"
echo.
echo It is assumed that you have created a Restore Point.
echo.
echo --- Stopping Explorer ---
taskkill /F /IM explorer.exe
echo Explorer has been terminated. Proceeding to the next step...

echo.

echo --- Stopping Services ---
net stop UsoSvc
net stop bits
net stop dosvc
echo Services have been stopped. Proceeding to the next step...

echo.

echo --- Deleting Temporary Files ---
DEL /F /S /Q /A %LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db
DEL /F /S /Q %temp%\*
DEL /F /S /Q %systemdrive%\*.tmp
DEL /F /S /Q %systemdrive%\*._mp
DEL /F /S /Q %systemdrive%\*.log
DEL /F /S /Q %systemdrive%\*.gid
DEL /F /S /Q %systemdrive%\*.chk
DEL /F /S /Q %systemdrive%\*.old
DEL /F /S /Q %systemdrive%\recycled\*.*
DEL /F /S /Q %systemdrive%\$Recycle.Bin\*.*
DEL /F /S /Q %windir%\*.bak
DEL /F /S /Q %windir%\prefetch\*.*
rd /s /q %windir%\temp & md %windir%\temp
DEL /F /Q %userprofile%\cookies\*.*
DEL /F /Q %userprofile%\recent\*.*
DEL /F /S /Q "%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\*.*"
DEL /F /S /Q "%userprofile%\AppData\Local\Temp\*.*"
echo Temporary files have been deleted. Proceeding to the next step...

echo.

echo --- Deleting Windows Update Files ---
echo Please wait while unnecessary update files are being removed...
rd /s /q C:\Windows\SoftwareDistribution
md C:\Windows\SoftwareDistribution
echo Windows Update files have been deleted. Proceeding to the next step...

echo.

echo --- Cleaning System Logs ---
echo Removing unnecessary log files...
for /f "tokens=*" %%G in ('wevtutil el') do wevtutil cl "%%G"
echo All System Logs have been cleared. Proceeding to the next step...

echo.

echo --- Running Disk Cleanup ---
echo Initiating cleanmgr.exe...
cleanmgr /sagerun:10
echo Disk Cleanup has been completed.
echo.

echo --- Restarting Explorer ---
start explorer.exe
echo Explorer has been restarted.

echo.
echo Your computer has been cleaned!
echo.
pause
goto :mainMenu

:exitMenu
cls
echo ---------------------------------------------------------------------
echo                         Exiting Cleany
echo ---------------------------------------------------------------------
echo.
set /p "skipRestartChoice=Do you want to restart the computer now? (Y/N): "
if /i "%skipRestartChoice%"=="Y" (
    echo Thank you for using the script! Your computer will restart shortly...
    shutdown /r /t 5 /f
) else if /i "%skipRestartChoice%"=="N" (
    echo Thank you for using the script! Please remember to restart your computer when convenient.
    exit
) else (
    echo You have chosen an invalid option! Please select a correct option...
    echo.
    goto :mainMenu
)
:eof
