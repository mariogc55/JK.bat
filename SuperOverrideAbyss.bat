@echo off
setlocal enabledelayedexpansion
title SUPER OVERRIDE - ABYSS EXPLORER
mode con: cols=95 lines=38

:boot
cls
color 0b
echo.
echo  [ SISTEMA SUPER OVERRIDE V.5.6 INICIADO ]
echo.
echo  ESTADO DEL SISTEMA: MAPEANDO LECHO MARINO...
echo.
set "bar="
for /l %%i in (1,1,20) do (
    set "bar=!bar!#"
    cls
    echo.
    echo  [ SISTEMA SUPER OVERRIDE V.5.6 INICIADO ]
    echo.
    echo  -- ENVIANDO PULSOS SONAR: [!bar!]
    ping -n 1 127.0.0.1 >nul
)

:menu
cls
color 0b
echo.
echo   =========================================================================
echo      S  U  P  E  R      O  V  E  R  R  I  D  E      A  B  Y  S  S
echo   =========================================================================
echo.
echo    1. INYECCION ALEATORIA
echo    2. ATAQUE MULTI-VECTOR
echo    3. MATRIX DECODER
echo    4. MINIJUEGO: TRES EN RAYA
echo    5. MINIJUEGO: CODIGO DE ACCESO
echo    6. MINIJUEGO: ABYSS EXPLORER (MAPA IRREGULAR)
echo    7. ESCANER DE PUERTOS
echo    8. AUTO-DESTRUCCION
echo.
set /p opt="NAV_OPERATOR >> "

if "%opt%"=="1" goto solo
if "%opt%"=="2" goto multi
if "%opt%"=="3" goto matrix
if "%opt%"=="4" goto tictactoe
if "%opt%"=="5" goto guessnum
if "%opt%"=="6" goto sonar
if "%opt%"=="7" goto scanner
if "%opt%"=="8" goto self_destruct
goto menu

:sonar
cls
color 0b
:: sx,sy = posicion submarino | tx,ty = tesoro | ox,oy = obstaculo
set /a sx=15, sy=6, score=0
set /a tx=%random% %% 25 + 3, ty=%random% %% 9 + 2
set /a ox1=%random% %% 25 + 3, oy1=%random% %% 9 + 2
set /a ox2=%random% %% 25 + 3, oy2=%random% %% 9 + 2

:sonar_loop
cls
echo  ABYSS EXPLORER - MAPA TACTICO DE PROFUNDIDAD
echo  ------------------------------------------------------------
echo  TESOROS: %score% ^| PROFUNDIDAD: %sy%00m ^| [X] = OBSTACULO
echo.

:: Renderizado de Mapa Irregular
echo    _________________________________
for /l %%y in (1,1,12) do (
    set "line= "
    :: Crear efecto de cueva irregular en los bordes
    set /a "l_edge=%random% %% 2", "r_edge=%random% %% 2"
    if !l_edge!==1 (set "line= (") else (set "line=  I")
    
    for /l %%x in (1,1,30) do (
        set "char= "
        if %%x==%sx% if %%y==%sy% set "char=S"
        if %%x==%tx% if %%y==%ty% set "char=$"
        if %%x==%ox1% if %%y==%oy1% set "char=X"
        if %%x==%ox2% if %%y==%oy2% set "char=X"
        set "line=!line!!char!"
    )
    if !r_edge!==1 (set "line=!line!)") else (set "line=!line!I")
    echo !line!
)
echo    ---------------------------------
echo.
echo  [ W,A,S,D + ENTER ] [ M = SALIR ]
echo.

:: Deteccion de Colision con Obstaculos o Tesoro
if %sx%==%tx% if %sy%==%ty% (
    set /a score+=1
    set /a tx=%random% %% 25 + 3, ty=%random% %% 9 + 2
    set /a ox1=%random% %% 25 + 3, oy1=%random% %% 9 + 2
    set /a ox2=%random% %% 25 + 3, oy2=%random% %% 9 + 2
    goto sonar_loop
)

if %sx%==%ox1% if %sy%==%oy1% goto sonar_dead
if %sx%==%ox2% if %sy%==%oy2% goto sonar_dead

:: Control
set "move="
set /p "move=RUMBO >> "
if /i "%move%"=="M" goto menu
if /i "%move%"=="W" set /a sy-=1
if /i "%move%"=="S" set /a sy+=1
if /i "%move%"=="A" set /a sx-=1
if /i "%move%"=="D" set /a sx+=1

:: Muros externos (si te sales del rango 1-30 o 1-12)
if %sx% LSS 1 goto sonar_dead
if %sx% GTR 30 goto sonar_dead
if %sy% LSS 1 goto sonar_dead
if %sy% GTR 12 goto sonar_dead
goto sonar_loop

:sonar_dead
color 0c
cls
echo.
echo   [!] ALERTA: IMPACTO DETECTADO
echo   =============================
echo    El casco ha colapsado contra las rocas o un obstaculo.
echo    Mision fallida. Tesoros: %score%
echo.
pause
goto menu

:guessnum
cls
color 0e
set /a "target=(%random% %% 100) + 1", "intentos=10"
echo.
echo   [ ADIVINA EL CODIGO DE ACCESO (1-100) ]
echo   ======================================================
:gn_loop
echo.
echo   Intentos restantes: %intentos%
set /p "user_num=Introduce codigo: "
set /a "intentos-=1"
if %user_num% EQU %target% (echo. & echo [!] ACCESO CONCEDIDO. & pause & goto menu)
if %intentos% LEQ 0 (goto self_destruct)
if %user_num% LSS %target% (echo -- MAS ALTO...) else (echo -- MAS BAJO...)
goto gn_loop

:tictactoe
set "p1=1" & set "p2=2" & set "p3=3" & set "p4=4" & set "p5=5" & set "p6=6" & set "p7=7" & set "p8=8" & set "p9=9"
set "turno=X" & set "ganador=NADA"
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
if not "!ganador!"=="NADA" (echo JUGADOR !ganador! GANA & pause & goto menu)
set /p move="Posicion (M para salir): "
if /i "%move%"=="M" goto menu
set "valido=0"
for /l %%i in (1,1,9) do (if "%move%"=="%%i" if "!p%%i!"=="%%i" (set "p%%i=!turno!" & set "valido=1"))
if "!valido!"=="0" goto tt_loop
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
start cmd /k "color a && curl asciiquarium.live"
goto menu

:multi
cls
for /l %%x in (1,1,5) do (start cmd /k "color a && curl ascii.live/nyan" & ping -n 1 127.0.0.1 >nul)
goto menu

:matrix
cls
color 02
:m_loop
echo %random%%random%%random%%random%
ping -n 1 127.0.0.1 >nul
goto m_loop

:scanner
cls
color 0b
for /l %%i in (1,1,10) do (echo BUSCANDO IP 10.0.0.%%i... OK & ping -n 1 127.0.0.1 >nul)
pause
goto menu

:self_destruct
color 0c
for /l %%i in (5,-1,1) do (cls & echo ALERTA: AUTO-DESTRUCCION EN %%i & ping -n 2 127.0.0.1 >nul)
exit