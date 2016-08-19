@ECHO off


:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

CLS

mode con cols=80 lines=50 >nul
@TITLE HideALLIP delete reg entries
@COLOR 0E

@ECHO.
@ECHO KILL HIDE ALL IP exe IF RUNNING
@ECHO.
@ECHO.
TASKKILL /F /IM HideAllIP.exe
TASKKILL /F /IM networktunnelx64helper.exe
TASKKILL /F /IM HideALLIP_RunAsAdmin.exe
TASKKILL /F /IM _HideAllIP.exe
TASKKILL /F /IM HideALLIP_original.exe
TASKKILL /F /IM LauncherService.exe

@ECHO.
TIMEOUT /T 5
CLS
@ECHO.

@ECHO.
@ECHO TRY DELETE reg ENTRIES hkey CURRENT USER HIDEALLIP
@ECHO.

@ECHO.
@ECHO hkey current user x86

:x86
REG DELETE "HKEY_CURRENT_USER\Software\hideallip" /f
@ECHO.

@ECHO.
@ECHO hkey current user x64

:x64
REG DELETE "HKEY_CURRENT_USER\Software\Wow6432Node\hideallip" /f
@ECHO.


@ECHO.
TIMEOUT /T 5
CLS
@ECHO.


@ECHO TRY DELETE reg ENTRIES hkey LOCAL MACHINE HIDEALLIP
@ECHO.


@ECHO.
@ECHO hkey local machine x86

:x86
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\hideallip" /f
@ECHO.

@ECHO.
@ECHO hkey local machine x64

:x64
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\hideallip" /f
@ECHO.





@ECHO.
TIMEOUT /T 5
CLS
@ECHO.


exit

