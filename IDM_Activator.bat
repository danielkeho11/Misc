@echo off
net file 1>nul 2>nul
if "%ERRORLEVEL%"=="0" goto:ADMIN
:RUNAS
set VBS=%TEMP%\%RANDOM%.vbs
if exist %VBS% goto:RUNAS
echo.Set UAC=CreateObject^("Shell.Application"^) > %VBS%
echo.UAC.ShellExecute "%~0", "", "", "runas", 1 >> %VBS%
%VBS%
exit
:ADMIN
if exist %TEMP%\*.vbs del %TEMP%\*.vbs
set "HKCU=HKEY_CURRENT_USER\Software\DownloadManager"
for /f "tokens=2*" %%a in ('reg query "%HKCU%" /v ExePath') do set "IDM=%%b"
if not exist "%IDM%" goto:ERROR
tasklist /fi "imagename eq IDMan.exe" | find /i /n "IDMan.exe" >nul
if "%ERRORLEVEL%"=="0" taskkill /f /t /im IDMan.exe >nul
if exist "%SystemRoot%\SysWOW64\" (
set "HKCR=HKEY_CLASSES_ROOT\Wow6432Node\CLSID"
set "HKLM=HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Internet Download Manager"
) else (
set "HKCR=HKEY_CLASSES_ROOT\CLSID"
set "HKLM=HKEY_LOCAL_MACHINE\SOFTWARE\Internet Download Manager"
)
echo %HKCR%\{07999AC3-058B-40BF-984F-69EB1E554CA7} [7] >Permissions
echo %HKCR%\{5ED60779-4DE2-4E07-B862-974CA4FF2E9C} [7] >>Permissions
echo %HKCR%\{6DDF00DB-1234-46EC-8356-27E7B2051192} [7] >>Permissions
echo %HKCR%\{7B8E9164-324D-4A2E-A46D-0165FB2000EC} [7] >>Permissions
echo %HKCR%\{D5B91409-A8CA-4973-9A0B-59F713D25671} [7] >>Permissions
regini Permissions >nul
del Permissions
reg delete "%HKCR%\{07999AC3-058B-40BF-984F-69EB1E554CA7}" /f >nul
reg delete "%HKCR%\{5ED60779-4DE2-4E07-B862-974CA4FF2E9C}" /f >nul
reg delete "%HKCR%\{6DDF00DB-1234-46EC-8356-27E7B2051192}" /f >nul
reg delete "%HKCR%\{7B8E9164-324D-4A2E-A46D-0165FB2000EC}" /f >nul
reg delete "%HKCR%\{D5B91409-A8CA-4973-9A0B-59F713D25671}" /f >nul
reg delete "%HKLM%" /v Email /f & cls
reg delete "%HKLM%" /v FName /f & cls
reg delete "%HKLM%" /v LName /f & cls
reg delete "%HKLM%" /v Serial /f & cls
reg delete "%HKLM%" /v InstallStatus /f & cls
set "VPK32=HKEY_CURRENT_USER\Software\Classes\CLSID"
set "VPK64=HKEY_CURRENT_USER\Software\Classes\Wow6432Node\CLSID"
set "STRING=YcVi8JRaz75hxWLwlF"
if exist %TEMP%\VPK.txt del %TEMP%\VPK.txt
for /f "eol=E tokens=1" %%a in ('reg query %VPK32% /s /t REG_SZ /f %STRING%') do echo.%%a>>%TEMP%\VPK.txt
cls
if exist %TEMP%\VPK.txt goto:REMOVE
for /f "eol=E tokens=1" %%a in ('reg query %VPK64% /s /t REG_SZ /f %STRING%') do echo.%%a>>%TEMP%\VPK.txt
cls
if exist %TEMP%\VPK.txt goto:REMOVE
goto:ACTIVATION
:REMOVE
set/pZ=<%TEMP%\VPK.txt
set "VPK=%Z%"
echo.%VPK% [7] >Permission
regini Permission >nul
del Permission
reg delete %VPK% /f >nul
del %TEMP%\VPK.txt
:ACTIVATION
set "DATA=2b8f78295a0cceec48d468e59f6a963eabdec5812638954485b112f990dd23a1d515c3fe5fce0641add84455d0421fc3f4aa902a446ade0118e6f26dcd4728e1debd65a188c292d8b8660b00bf453d017acf30683ecceb8fd475d65c7b49d662b8660b00bf453d0148f50ad67e9440e682102708aeba849b73ec63f9cddb06be72e220851ffd2ca6eee31686d2f17dbe38a692a53387d84cdb73c69ea08782f45ed0ff10d61af035a4c0bc9971300ba68d1e736d368a77ca6e3cb9d945e4d10660fe6ed9ceaf1cb85d64c5004927872f154453e08d7baf342d24c2a8f3c19b689fd5f18487e71e3ba171677a33438a7e15a76b7fed8223242b43153c245bb900"
reg add %HKCR%\{6DDF00DB-1234-46EC-8356-27E7B2051192} /v MData /t REG_BINARY /d %DATA% /f
set "RULENAME=IDM"
set "REMOTEIP=50.22.78.28,50.22.78.29,50.22.78.31,50.97.41.98,50.97.82.44,69.41.163.49,69.41.163.149,75.125.34.148,75.125.34.157,169.55.0.224,169.55.40.5,173.255.134.84,173.255.137.80,174.127.73.80,174.127.73.85,174.133.70.98,174.133.70.101,184.173.149.184,184.173.188.104,184.173.188.106,184.173.188.107,202.134.64.74,207.44.199.16,207.44.199.159,207.44.199.165"
netsh advfirewall firewall delete rule name="%RULENAME%" dir=out >nul
netsh advfirewall firewall add rule name="%RULENAME%" dir=out action=block program="%IDM%" remoteip=%REMOTEIP% >nul
cls
echo.
echo Internet Download Manager - Registration
reg add %HKCU% /v FName /t REG_SZ /d Someone /f >nul
reg add %HKCU% /v LName /t REG_SZ /d " " /f >nul
reg add %HKCU% /v Email /t REG_SZ /d anymail@something.com /f >nul
reg add %HKCU% /v Serial /t REG_SZ /d 9QNBL-L2641-Y7WVE-QEN3I /f >nul
:RETRY
echo.
set NAME=
set /p NAME=Type your full name then press [Enter]: 
if "%NAME%"=="" echo "%NAME%" is not valid, please try again & goto:RETRY
set FC=%NAME:~0,1%
if "%FC%"==" " echo "%NAME%" is not valid, please try again & goto:RETRY
reg add %HKCU% /v FName /t REG_SZ /d "%NAME%" /f
echo.Press any key to exit . . .(yadavsunil4796@gmail.com)
pause>nul
exit

:ERROR
cls
echo.Please install Internet Download Manager before running this activator.
echo.Press any key to exit . . .
pause>nul
exit
