@echo off
setlocal enabledelayedexpansion

:: --- CONFIGURATION :D ---
set reps=5

set "anim1=asciiquarium.live"
set "anim2=ascii.live/donut"
set "anim3=ascii.live/batman"
set "anim4=ascii.live/can-you-hear-me"
set "anim5=ascii.live/hes"
set "anim6=ascii.live/knot"
set "anim7=ascii.live/bnr"
set "anim8=ascii.live/coin"
set "anim9=ascii.live/parrot"
set "anim10=ascii.live/dvd"
set "anim11=ascii.live/playstation"
set "anim12=ascii.live/nyan"
set "anim13=ascii.live/torus-knot"

set total_anims=13
:: ---------------------

for /l %%i in (1, 1, %reps%) do (

    set /a "indice=!random! %% total_anims + 1"
    
    for %%f in (!indice!) do set "url=!anim%%f!"
    
    start cmd /k "color a && curl !url!"
)

exit