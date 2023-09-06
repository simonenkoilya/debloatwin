@echo off
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

@echo off
echo Hi, %USERNAME%. This bat deletes the following applications:
echo Microsoft Edge
echo Microsoft Edge Update
echo Microsoft Edge WebView2

@echo off
setlocal EnableExtensions DisableDelayedExpansion
echo(
if exist "%SystemRoot%\System32\choice.exe" goto UseChoice

setlocal EnableExtensions EnableDelayedExpansion
:UseSetPrompt
set "UserChoice="
set /P "UserChoice=Are you sure [Y/N]? "
set "UserChoice=!UserChoice: =!"
if /I "!UserChoice!" == "N" endlocal & exit /B
if /I not "!UserChoice!" == "Y" goto UseSetPrompt
endlocal
goto Continue

:UseChoice
%SystemRoot%\System32\choice.exe /C YN /N /M "Are you sure [Y/N]?"
if not errorlevel 1 goto UseChoice
if errorlevel 2 exit /B

:Continue
endlocal

taskkill /F /IM msedge.exe

sc stop MicrosoftEdgeElevationService
sc config MicrosoftEdgeElevationService start=Disabled

sc stop edgeupdate
sc config edgeupdate start=Disabled

sc stop edgeupdatem
sc config edgeupdatem start=Disabled

takeown /f "C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" /r /d y
icacls "C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" /grant %username%:F /t /q

takeown /f "C:\Windows\SystemApps\Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe" /r /d y
icacls "C:\Windows\SystemApps\Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe" /grant %username%:F /t /q

takeown /f "C:\Program Files (x86)\Microsoft\Edge" /r /d y
icacls "C:\Program Files (x86)\Microsoft\Edge" /grant %username%:F /t /q

takeown /f "C:\Program Files (x86)\Microsoft\EdgeCore" /r /d y
icacls "C:\Program Files (x86)\Microsoft\EdgeCore" /grant %username%:F /t /q

takeown /f "C:\Program Files (x86)\Microsoft\EdgeUpdate" /r /d y
icacls "C:\Program Files (x86)\Microsoft\EdgeUpdate" /grant %username%:F /t /q

takeown /f "C:\Program Files (x86)\Microsoft\EdgeWebView" /r /d y
icacls "C:\Program Files (x86)\Microsoft\EdgeWebView" /grant %username%:F /t /q

takeown /f "C:\Program Files (x86)\Microsoft\Temp" /r /d y
icacls "C:\Program Files (x86)\Microsoft\Temp" /grant %username%:F /t /q

rmdir /s /q "C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe"
rmdir /s /q "C:\Windows\SystemApps\Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe"
rmdir /s /q "C:\Program Files (x86)\Microsoft\Edge"
rmdir /s /q "C:\Program Files (x86)\Microsoft\EdgeCore"
rmdir /s /q "C:\Program Files (x86)\Microsoft\EdgeUpdate"
rmdir /s /q "C:\Program Files (x86)\Microsoft\EdgeWebView"
rmdir /s /q "C:\Program Files (x86)\Microsoft\Temp"

pause
