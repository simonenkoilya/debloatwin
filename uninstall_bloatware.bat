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
echo Cortana
echo Weather
echo Xbox
echo Get Help 
echo Tips
echo Paint 3D
echo 3D Viewer
echo Microsoft 365 (Office)
echo Solitaire and Casual Games
echo Sticky Notes
echo Mixed Reality Portal
echo OneNote for Windows 10
echo People
echo Snip and Sketch
echo Skype
echo Microsoft Pay
echo Photos and Video Editor
echo Alarms
echo Calculator
echo Camera
echo Feedback Hub
echo Maps
echo Voice Recorder
echo Xbox.TCUI
echo Xbox Console Companion
echo XboxGameOverlay
echo Xbox Game Bar
echo XboxIdentityProvider
echo XboxSpeechToTextOverlay
echo Phone Link
echo Media Player
echo Films and TV
echo Mail and Calendar

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

winget uninstall Microsoft.549981C3F5F10_8wekyb3d8bbwe :: Cortana
winget uninstall Microsoft.BingWeather_8wekyb3d8bbwe :: Weather | Погода
winget uninstall Microsoft.GamingApp :: Xbox
winget uninstall Microsoft.GetHelp_8wekyb3d8bbwe :: Get Help | Техническая поддержка
winget uninstall Microsoft.Getstarted_8wekyb3d8bbwe :: Tips | Советы
winget uninstall Microsoft.MSPaint_8wekyb3d8bbwe :: Paint 3D
winget uninstall Microsoft.Microsoft3DViewer_8wekyb3d8bbwe :: 3D Viewer | Средство 3D-просмотра
winget uninstall Microsoft.MicrosoftOfficeHub_8wekyb3d8bbwe :: Microsoft 365 (Office)
winget uninstall Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe :: Solitaire & Casual Games
winget uninstall Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe :: Sticky Notes | Записки
winget uninstall Microsoft.MixedReality.Portal_8wekyb3d8bbwe :: Mixed Reality Portal | Портал смешанной реальности
winget uninstall Microsoft.Office.OneNote_8wekyb3d8bbwe :: OneNote for Windows 10
winget uninstall Microsoft.People_8wekyb3d8bbwe :: People | Люди
winget uninstall Microsoft.ScreenSketch_8wekyb3d8bbwe :: Snip & Sketch | Набросок на фрагменте экрана
winget uninstall Microsoft.SkypeApp_kzf8qxf38zg5c :: Skype
winget uninstall Microsoft.Wallet_8wekyb3d8bbwe :: Microsoft Pay
winget uninstall Microsoft.Windows.Photos_8wekyb3d8bbwe :: Photos, Video Editor | Фотографии, Видеоредактор
winget uninstall Microsoft.WindowsAlarms_8wekyb3d8bbwe :: Alarms | Часы
winget uninstall Microsoft.WindowsCalculator_8wekyb3d8bbwe :: Calculator | Калькулятор
winget uninstall Microsoft.WindowsCamera_8wekyb3d8bbwe :: Camera | Камера
winget uninstall Microsoft.WindowsFeedbackHub_8wekyb3d8bbwe :: Feedback Hub | Центр отзывов
winget uninstall Microsoft.WindowsMaps_8wekyb3d8bbwe :: Maps | Карты
winget uninstall Microsoft.WindowsSoundRecorder_8wekyb3d8bbwe :: Voice Recorder | Запись голоса
winget uninstall Microsoft.Xbox.TCUI_8wekyb3d8bbwe
winget uninstall Microsoft.XboxApp_8wekyb3d8bbwe :: Xbox Console Companion | Компаньон консоли Xbox
winget uninstall Microsoft.XboxGameOverlay_8wekyb3d8bbwe
winget uninstall Microsoft.XboxGamingOverlay_8wekyb3d8bbwe :: Xbox Game Bar
winget uninstall Microsoft.XboxIdentityProvider_8wekyb3d8bbwe
winget uninstall Microsoft.XboxSpeechToTextOverlay_8wekyb3d8bbwe
winget uninstall Microsoft.YourPhone_8wekyb3d8bbwe :: Phone Link | Связь с телефоном
winget uninstall Microsoft.ZuneMusic_8wekyb3d8bbwe :: Media Player | Медиаплеер
winget uninstall Microsoft.ZuneVideo_8wekyb3d8bbwe :: Films & TV | Кино и ТВ
winget uninstall microsoft.windowscommunicationsapps_8wekyb3d8bbwe :: Mail and Calendar | Почта и Календарь

pause
