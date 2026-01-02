@echo off
setlocal enabledelayedexpansion
title --- SYSTEM ASCII TERMINAL ---
mode con: cols=60 lines=20

:: --- ANIMATIONS ---
set "a1=asciiquarium.live" & set "a2=ascii.live/donut" & set "a3=ascii.live/batman"
set "a4=ascii.live/can-you-hear-me" & set "a5=ascii.live/hes" & set "a6=ascii.live/knot"
set "a7=ascii.live/bnr" & set "a8=ascii.live/coin" & set "a9=ascii.live/parrot"
set "a10=ascii.live/dvd" & set "a11=ascii.live/playstation" & set "a12=ascii.live/nyan"
set "a13=ascii.live/torus-knot"
set total=13

:menu
cls
color 0A
echo.
echo  ======================================================
echo     S Y S T E M   A S C I I   R O U L E T T E
echo  ======================================================
echo.
echo    [1] Drop random attack
echo    [2] Mode "Flood"
echo    [3] Exit Sistem
echo.
set /p opt="Select a sequence: "

if %opt%==1 goto single
if %opt%==2 goto flood
if %opt%==3 exit
goto menu

:single
cls
echo [!] INICIANDO PROTOCOLO DE CONEXION...
:: charging
for /l %%g in (1,1,20) do (
    set /p ".=." <nul
    powershell "[console]::beep(500, 50)" >nul
)
echo.
set /a "idx=!random! %% total + 1"
for %%f in (!idx!) do set "url=!a%%f!"
echo [OK] OBJETIVO LOCALIZADO: !url!
timeout /t 2 >nul
start cmd /k "color a && curl !url!"
goto menu

:flood
cls
echo [!!!] ALERT: MEMORY FLOOD STARTED...
for /l %%i in (1,1,5) do (
    set /a "idx=!random! %% total + 1"
    for %%f in (!idx!) do set "target=!a%%f!"
    echo  ^> Opening breach in: !target!
    powershell "[console]::beep(1000, 100)" >nul
    start cmd /k "color a && curl !target!"
    timeout /t 1 >nul
)
echo.
echo [¨PROCESS COMPLETED]
pause
goto menu