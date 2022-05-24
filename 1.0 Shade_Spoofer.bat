@shift /0
   echo off & color 3 & cls 
:: auto elevates to admin for ease of use 
title SHADE SPOOFER OLD VERSION...

title Shade_Spoofer
chcp 65001
cls 
:init
 setlocal DisableDelayedExpansion
 set cmdInvoke=1
 set winSysFolder=System32
 set "batchPath=%~0"
 for %%k in (%0) do set batchName=%%~nk
 set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
 setlocal EnableDelayedExpansion

:checkPrivileges
  NET FILE 1>NUL 2>NUL
  if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
  if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)

  ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
  ECHO args = "ELEV " >> "%vbsGetPrivileges%"
  ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
  ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
  ECHO Next >> "%vbsGetPrivileges%"

  if '%cmdInvoke%'=='1' goto InvokeCmd 

  ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
  

:InvokeCmd
  ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
  ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"


:gotPrivileges
 setlocal & cd /d %~dp0
 if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
 goto :start
 :: end of auto elevate

:start
chcp 65001 
mode 95,20                                                    
cls
echo.
echo			       ____                  ___           
echo			      / __/ ___  ___  ___   / _/ 
echo			     _\ \  / _ \/ _ \/ _ \ / _/ 
echo			    /___/ / .__/\___/\___//_/    
echo			         /_/                                                                                          
echo.
echo   (1) - FivemHWID Cleaner
echo   (2) - Fivem Cleaner 
echo   (3) - Xbox Cleaner
echo.
echo           *open as admin (not open as admin not unbanned)
echo.
echo.
choice /c:123 /n
if %errorlevel% equ 1 goto :curHWID
if %errorlevel% equ 2 goto :folderclean
if %errorlevel% equ 3 goto :xboxclean
					

:curHWID
setlocal EnableDelayedExpansion
cls
set /a "lo=1"

for /f "skip=1 tokens=1" %%a in ('wmic diskdrive get serialnumber') do (
   set "disk=%%a"
   goto :n2
)
:n2
cls
:: bios serial 
for /f "skip=1 tokens=1" %%b in ('wmic bios get serialnumber') do (
   set "bios=%%b"
   goto :n3
)
:n3
for /f "skip=1 tokens=1" %%c in ('wmic cpu get serialnumber') do (
    set "cpu=%%c"
    goto :n4
)
:n4
for /f "delims= skip=1" %%d in ('wmic baseboard get serialnumber') do (
    set "baseb=%%d"
    goto :n5
)
:n5
for /f "skip=1 tokens=1" %%e in ('wmic MEMORYCHIP get serialnumber') do (
   if "!lo!" equ "1" (
      set "ram1=%%e"
   ) else (
      if "!lo!" equ "2" (
         set "ram2=%%e"  
      ) else (
         goto :n6
      )
   )
   set /a "lo=!lo!+1"
)
:n6
for /f "skip=1" %%f in ('wmic csproduct get UUID') do (
   set "uuid=%%f"
   goto :n7
)
:n7
if "%cpu%" equ "To" set "cpu=To be filled"
goto :resultsHWID

:resultsHWID
mode 60,30
cls
echo.
echo                        Shade_Spoofer 1.0v 
echo                   	   by shadowuś.Dżezus#7777
echo.
echo.
echo.
pause>nul
goto :start

:folderclean
call :getDiscordVersion
cls
del /s /f /q "%appdata%\CitizenFX" >nul 2>nul 
del /s /f /q "%appdata%\DigitalEntitlements" >nul 2>nul
del /s /f /q "%appdata%\Discord\%discordVersion%\modules\discord_rpc" >nul 2>nul
call :errorcheck
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\cfx_curl_x86_64.dll
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\cache\Browser"
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\cache\db"
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\cache\dunno"
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\cache\priv"
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\cache\servers"
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\cache\subprocess"
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\cache\unconfirmed"
del /s /q /f %LocalAppData%\FiveM\FiveM.app\steam_api64.dll
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\cache\authbrowser"
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\cache\crashometry"
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\cache\launcher_skip"
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\cache\launcher_skip_mtl2"
taskkill /f /im Steam.exe /t
del /s /q /f "%LocalAppData%\DigitalEntitlements"
del /s /q /f %LocalAppData%\FiveM\FiveM.app\profiles.dll
del /s /q /f %LocalAppData%\FiveM\FiveM.app\CitizenFX_SubProcess_chrome.bin
del /s /q /f %LocalAppData%\FiveM\FiveM.app\CitizenFX_SubProcess_game.bin
del /s /q /f %LocalAppData%\FiveM\FiveM.app\CitizenFX_SubProcess_game_372.bin
del /s /q /f %LocalAppData%\FiveM\FiveM.app\CitizenFX_SubProcess_game_1604.bin
del /s /q /f %LocalAppData%\FiveM\FiveM.app\CitizenFX_SubProcess_game_1868.bin
del /s /q /f %LocalAppData%\FiveM\FiveM.app\CitizenFX_SubProcess_game_2060.bin
del /s /q /f %LocalAppData%\FiveM\FiveM.app\CitizenFX_SubProcess_game_2189.bin
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\mods\*.*"
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\logs\*.*"
del /s /q /f %LocalAppData%\FiveM\FiveM.app\CitizenGame.dll
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\cfx_curl_x86_64.dll
del /s /q /f %LocalAppData%\FiveM\FiveM.app\steam.dll
rmdir /s /q %userprofile%\AppData\Roaming\CitizenFX
del /s /q /f %LocalAppData%\FiveM\FiveM.app\asi-five.dll
del /s /q /f %LocalAppData%\FiveM\FiveM.app\CitizenFX.ini
del /s /q /f %LocalAppData%\FiveM\FiveM.app\caches.XML
del /s /q /f %LocalAppData%\FiveM\FiveM.app\adhesive.dll
del /s /q /f %LocalAppData%\FiveM\FiveM.app\discord.dll
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\crashes\*.*"
mode 60,15
cls
echo. 
echo             done clean Fivem
echo.
echo.          
echo.
echo.
echo.
echo.
echo.  
pause >nul
goto :start  
:getDiscordVersion
for /d %%a in ("%appdata%\Discord\*") do (
   set "varLoc=%%a"
   goto :d1
)
:d1
for /f "delims=\ tokens=7" %%z in ('echo %varLoc%') do (
   set "discordVersion=%%z"
)
goto :EOF

:xboxclean
cls
powershell -Command "& {Get-AppxPackage -AllUsers xbox | Remove-AppxPackage}" >NUL 2>NUL
sc stop XblAuthManager >NUL 2>NUL
sc stop XblGameSave >NUL 2>NUL
sc stop XboxNetApiSvc >NUL 2>NUL
sc stop XboxGipSvc >NUL 2>NUL
sc delete XblAuthManager >NUL 2>NUL
sc delete XblGameSave >NUL 2>NUL
sc delete XboxNetApiSvc >NUL 2>NUL
sc delete XboxGipSvc >NUL 2>NUL
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\xbgm" /f >NUL 2>NUL
schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTask" /disable >NUL 2>NUL
schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTaskLogon" /disable >NUL 2>NUL
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >NUL 2>NUL
call :errorcheck
shutdown -r -t 5 -c "restart kompa wlatuje fresh od shadowka... (CLEAR ALL XBOX)"
pause >nul
goto :start  

:errorcheck 
if %errorlevel% EQU 1 (
echo                       *press any key
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
pause
:1
dir/s
    timeout /t 3 >nul 2>nul
    exit /b
) else (
    rem do nothing :)
    goto :eof
)