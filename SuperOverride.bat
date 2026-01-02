@echo off
setlocal enabledelayedexpansion
title SUPER OVERRIDE - ULTIMATE MAINFRAME
mode con: cols=95 lines=35

:boot
cls
color 0a
echo.
echo  [ SISTEMA SUPER OVERRIDE V.5.1 INICIADO ]
echo.
echo  ESTADO DEL SISTEMA: CARGANDO MODULOS CRITICOS...
echo.
set "bar="
for /l %%i in (1,1,20) do (
    set "bar=!bar!#"
    cls
    echo.
    echo  [ SISTEMA SUPER OVERRIDE V.5.1 INICIADO ]
    echo.
    echo  -- CARGANDO NUCLEO: [!bar!]
    ping -n 1 127.0.0.1 >nul
)
echo.
echo  [ ACCESO CONCEDIDO ]
ping -n 2 127.0.0.1 >nul

:menu
cls
color 0a
echo.
echo   =========================================================================
echo      S  U  P  E  R      O  V  E  R  R  I  D  E      M  A  I  N  F  R  A  M  E
echo   =========================================================================
echo.
echo    1. INYECCION ALEATORIA
echo    2. ATAQUE MULTI-VECTOR
echo    3. MATRIX DECODER
echo    4. MINIJUEGO: TRES EN RAYA
echo    5. ESCANER DE PUERTOS
echo    6. AUTO-DESTRUCCION
echo.
set /p opt="SHELL_OPERATOR >> "

if "%opt%"=="1" goto solo
if "%opt%"=="2" goto multi
if "%opt%"=="3" goto matrix
if "%opt%"=="4" goto tictactoe
if "%opt%"=="5" goto scanner
if "%opt%"=="6" goto self_destruct
goto menu

:tictactoe
set "p1=1" & set "p2=2" & set "p3=3" & set "p4=4" & set "p5=5" & set "p6=6" & set "p7=7" & set "p8=8" & set "p9=9"
set "turno=X"
set "ganador=NADA"

:tt_loop
cls
color 0e
echo.
echo       TRES EN RAYA - SUPER OVERRIDE
echo    ===================================
echo.
echo        [ !p1! ] ^| [ !p2! ] ^| [ !p3! ]
echo       -----------------------
echo        [ !p4! ] ^| [ !p5! ] ^| [ !p6! ]
echo       -----------------------
echo        [ !p7! ] ^| [ !p8! ] ^| [ !p9! ]
echo.

if not "!ganador!"=="NADA" (
    echo    ¡EL JUGADOR !ganador! HA GANADO!
    pause
    goto menu
)

echo    Turno de: !turno! (M para salir)
set /p move="Posicion: "
if /i "!move!"=="M" goto menu

set "valido=0"
if "!move!"=="1" if "!p1!"=="1" (set "p1=!turno!" & set "valido=1")
if "!move!"=="2" if "!p2!"=="2" (set "p2=!turno!" & set "valido=1")
if "!move!"=="3" if "!p3!"=="3" (set "p3=!turno!" & set "valido=1")
if "!move!"=="4" if "!p4!"=="4" (set "p4=!turno!" & set "valido=1")
if "!move!"=="5" if "!p5!"=="5" (set "p5=!turno!" & set "valido=1")
if "!move!"=="6" if "!p6!"=="6" (set "p6=!turno!" & set "valido=1")
if "!move!"=="7" if "!p7!"=="7" (set "p7=!turno!" & set "valido=1")
if "!move!"=="8" if "!p8!"=="8" (set "p8=!turno!" & set "valido=1")
if "!move!"=="9" if "!p9!"=="9" (set "p9=!turno!" & set "valido=1")

if "!valido!"=="0" goto tt_loop

:: Verificacion simplificada
if "!p1!"=="!p2!" if "!p2!"=="!p3!" set "ganador=!p1!"
if "!p4!"=="!p5!" if "!p5!"=="!p6!" set "ganador=!p4!"
if "!p7!"=="!p8!" if "!p8!"=="!p9!" set "ganador=!p7!"
if "!p1!"=="!p4!" if "!p4!"=="!p7!" set "ganador=!p1!"
if "!p2!"=="!p5!" if "!p5!"=="!p8!" set "ganador=!p2!"
if "!p3!"=="!p6!" if "!p6!"=="!p9!" set "ganador=!p3!"
if "!p1!"=="!p5!" if "!p5!"=="!p9!" set "ganador=!p1!"
if "!p3!"=="!p5!" if "!p5!"=="!p7!" set "ganador=!p3!"

if not "!ganador!"=="NADA" goto tt_loop
if "!turno!"=="X" (set "turno=O") else (set "turno=X")
goto tt_loop

:solo
cls
set /a "num=(!random! %% 5) + 1"
if %num%==1 start cmd /k "color a && curl asciiquarium.live"
if %num%==2 start cmd /k "color a && curl ascii.live/donut"
if %num%==3 start cmd /k "color a && curl ascii.live/batman"
if %num%==4 start cmd /k "color a && curl ascii.live/nyan"
if %num%==5 start cmd /k "color a && curl ascii.live/parrot"
goto menu

:multi
cls
for /l %%x in (1,1,5) do (
   start cmd /k "color a && curl asciiquarium.live"
   ping -n 1 127.0.0.1 >nul
)
goto menu

:matrix
cls
color 02
echo [ MATRIX DECODER - CTRL+C PARA SALIR ]
:m_loop
echo !random!!random!!random!!random!
ping -n 1 127.0.0.1 >nul
goto m_loop

:scanner
cls
color 0b
echo [!] ESCANEANDO NODOS...
for /l %%i in (1,1,10) do (
    echo  BUSCANDO IP 10.0.0.%%i ... [ OK ]
    ping -n 1 127.0.0.1 >nul
)
pause
goto menu

:self_destruct
color 0c
for /l %%i in (5,-1,1) do (
    cls
    echo  ADVERTENCIA: CERRANDO EN %%i
    ping -n 2 127.0.0.1 >nul
)
exit