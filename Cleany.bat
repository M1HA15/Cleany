@echo off
title Cleany (0.5)
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

for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
for /f "tokens=2 delims=[]" %%G in ('ver') do set WINVER=%%G

:mainMenu
cls
echo =====================================================================
echo                              Cleany (0.5)
echo.
echo           Warning: This version may contain bugs or issues!
echo                 Running with Administrator Privileges
echo                    PowerShell Version: %PSVersion%
echo                    Windows Version: %WINVER%
echo =====================================================================
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
echo =====================================================================
echo                   Potential Risks While Running Cleany
echo =====================================================================
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
echo - Some operations may not work on custom Windows versions.
echo.
pause
goto :mainMenu

:infoPC
cls
echo =====================================================================
echo                      Info About Your PC
echo =====================================================================
echo.
systeminfo | more
pause
goto :mainMenu

:infoScript
cls
set "betaVersion=No"
echo =====================================================================
echo                      Info About Script
echo =====================================================================
echo.
echo Script Name: Cleany
echo Version: 0.5
echo Author: M1HA15
echo Beta Version: %betaVersion%
echo Compatibility: All Windows versions (10/11, Tiny, Atlas, FSOS, etc.)
echo.
set /p "openGitHub=Do you want to open the Cleany GitHub Page? (Y/N): "
if /i "%openGitHub%"=="Y" (
    echo Opening default web browser...
    start "" "https://github.com/M1HA15/Cleany"
) else (
    echo Skipping...
)
echo.
set /p "openCleany=Do you want to check NSR? (Y/N): "
if /i "%openCleany%"=="Y" (
    echo Opening default web browser...
    start "" "https://github.com/M1HA15/Network-Settings-Reset"
) else (
    echo Skipping...
)
echo.
pause
goto :mainMenu

:cleany
cls
echo =====================================================================
echo                         Cleany - System Cleaner
echo =====================================================================
echo.
echo Opening System Restore Point...
echo Please manually create a Restore Point!
if exist "C:\Windows\System32\SystemPropertiesProtection.exe" (
    start "" /wait "C:\Windows\System32\SystemPropertiesProtection.exe"
) else (
    echo WARNING: System Restore utility not found on this Windows version.
    echo Skipping restore point creation...
)
echo.
echo It is assumed that you have created a Restore Point.
echo.

echo --- Stopping Explorer ---
taskkill /F /IM explorer.exe >nul 2>&1
if %errorlevel%==0 (
    echo Explorer has been terminated successfully.
) else (
    echo Explorer was not running or could not be terminated.
)

echo.

echo --- Stopping Services ---
echo Attempting to stop Windows Update services...
sc query UsoSvc >nul 2>&1
if %errorlevel%==0 (
    net stop UsoSvc >nul 2>&1
    if %errorlevel%==0 (echo - UsoSvc stopped successfully.) else (echo - UsoSvc could not be stopped or is not running.)
) else (
    echo - UsoSvc not found on this system.
)

sc query bits >nul 2>&1
if %errorlevel%==0 (
    net stop bits >nul 2>&1
    if %errorlevel%==0 (echo - BITS stopped successfully.) else (echo - BITS could not be stopped or is not running.)
) else (
    echo - BITS not found on this system.
)

sc query dosvc >nul 2>&1
if %errorlevel%==0 (
    net stop dosvc >nul 2>&1
    if %errorlevel%==0 (echo - Delivery Optimization stopped successfully.) else (echo - Delivery Optimization could not be stopped or is not running.)
) else (
    echo - Delivery Optimization not found on this system.
)
echo Services processing completed.

echo.

echo --- Deleting Temporary Files ---
echo Cleaning thumbnail cache...
if exist "%LocalAppData%\Microsoft\Windows\Explorer\" (
    DEL /F /S /Q /A "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
)

echo Cleaning temp directories...
if exist "%temp%" (
    DEL /F /S /Q "%temp%\*" >nul 2>&1
)

echo Cleaning system drive temporary files...
if exist "%systemdrive%\" (
    DEL /F /S /Q "%systemdrive%\*.tmp" >nul 2>&1
    DEL /F /S /Q "%systemdrive%\*._mp" >nul 2>&1
    DEL /F /S /Q "%systemdrive%\*.log" >nul 2>&1
    DEL /F /S /Q "%systemdrive%\*.gid" >nul 2>&1
    DEL /F /S /Q "%systemdrive%\*.chk" >nul 2>&1
    DEL /F /S /Q "%systemdrive%\*.old" >nul 2>&1
)

echo Cleaning Recycle Bin...
if exist "%systemdrive%\recycled\" (
    DEL /F /S /Q "%systemdrive%\recycled\*.*" >nul 2>&1
)
if exist "%systemdrive%\$Recycle.Bin\" (
    DEL /F /S /Q "%systemdrive%\$Recycle.Bin\*.*" >nul 2>&1
)

echo Cleaning Windows backup files...
if exist "%windir%\" (
    DEL /F /S /Q "%windir%\*.bak" >nul 2>&1
)

echo Cleaning prefetch...
if exist "%windir%\prefetch\" (
    DEL /F /S /Q "%windir%\prefetch\*.*" >nul 2>&1
)

echo Cleaning Windows temp directory...
if exist "%windir%\temp\" (
    rd /s /q "%windir%\temp" >nul 2>&1
    md "%windir%\temp" >nul 2>&1
)

echo Cleaning user profile temporary files...
if exist "%userprofile%\cookies\" (
    DEL /F /Q "%userprofile%\cookies\*.*" >nul 2>&1
)
if exist "%userprofile%\recent\" (
    DEL /F /Q "%userprofile%\recent\*.*" >nul 2>&1
)
if exist "%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\" (
    DEL /F /S /Q "%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\*.*" >nul 2>&1
)
if exist "%userprofile%\AppData\Local\Temp\" (
    DEL /F /S /Q "%userprofile%\AppData\Local\Temp\*.*" >nul 2>&1
)
echo Temporary files have been cleaned successfully.

echo.

echo --- Deleting Windows Update Files ---
echo Please wait while unnecessary update files are being removed...
if exist "C:\Windows\SoftwareDistribution\" (
    rd /s /q "C:\Windows\SoftwareDistribution" >nul 2>&1
    if %errorlevel%==0 (
        md "C:\Windows\SoftwareDistribution" >nul 2>&1
        echo Windows Update files have been deleted successfully.
    ) else (
        echo WARNING: Could not delete some Windows Update files (may be in use).
    )
) else (
    echo SoftwareDistribution folder not found (custom Windows version detected).
)

echo.

echo --- Cleaning System Logs ---
echo Removing unnecessary log files...
set "logCount=0"
for /f "tokens=*" %%G in ('wevtutil el 2^>nul') do (
    wevtutil cl "%%G" >nul 2>&1
    if !errorlevel!==0 set /a logCount+=1
)
echo Cleared %logCount% event logs successfully.

echo.

echo --- Running Disk Cleanup ---
echo Initiating disk cleanup utility...
if exist "C:\Windows\System32\cleanmgr.exe" (
    cleanmgr /sagerun:10
    echo Disk Cleanup has been completed.
) else (
    echo Disk Cleanup utility not found on this Windows version.
    echo Skipping this step...
)

echo.

echo --- Restarting Explorer ---
start explorer.exe
timeout /t 2 /nobreak >nul
tasklist /FI "IMAGENAME eq explorer.exe" 2>NUL | find /I /N "explorer.exe">NUL
if %errorlevel%==0 (
    echo Explorer has been restarted successfully.
) else (
    echo WARNING: Explorer may not have restarted properly.
    echo Please restart it manually if needed.
)

echo.
echo =====================================================================
echo Your computer has been cleaned successfully!
echo =====================================================================
echo.
pause
goto :mainMenu

:exitMenu
cls
echo =====================================================================
echo                         Exiting Cleany
echo =====================================================================
echo.
set /p "skipRestartChoice=Do you want to restart the computer now? (Y/N): "
if /i "%skipRestartChoice%"=="Y" (
    echo Thank you for using Cleany! Your computer will restart shortly...
    shutdown /r /t 5 /f
) else if /i "%skipRestartChoice%"=="N" (
    echo Thank you for using Cleany! Please remember to restart your computer when convenient.
    timeout /t 2 /nobreak >nul
    exit
) else (
    echo Invalid option selected! Returning to main menu...
    timeout /t 2 /nobreak >nul
    goto :mainMenu
)
:eof
