@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
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
:--------------------------------------
taskkill /F /IM msedge.exe

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
