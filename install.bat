@echo off
winget install GIT.GIT
set "MODS_PATH=%USERPROFILE%\AppData\Roaming\Balatro\Mods"
set "BALATRO_MAIN_PATH=D:\Steam\steamapps\common\Balatro"

echo Copiando version.dll a %BALATRO_MAIN_PATH%...
if exist "version.dll" (
    copy /Y "version.dll" "%BALATRO_MAIN_PATH%\"
) else (
    echo ERROR: No se encontró version.dll en la carpeta actual.
    pause
    exit /b 1
)

echo Creando carpeta: %MODS_PATH%
mkdir "%MODS_PATH%" 2>nul

echo Cambiando directorio...
cd /d "%MODS_PATH%"
if errorlevel 1 (
    echo No se pudo cambiar al directorio %MODS_PATH%
    pause
    exit /b 1
)

echo Procesando repositorios...

rem smods
if not exist "smods" (
    echo Clonando smods...
    git clone https://github.com/Steamodded/smods.git
) else (
    echo Actualizando smods...
    cd smods
    git pull
    cd ..
)

rem Talisman
if not exist "Talisman" (
    echo Clonando Talisman...
    git clone https://github.com/SpectralPack/Talisman.git
) else (
    echo Actualizando Talisman...
    cd Talisman
    git pull
    cd ..
)

rem PokerLeven
if not exist "PokerLeven" (
    echo Clonando PokerLeven...
    git clone https://github.com/DecoXFE/PokerLeven.git
) else (
    echo Actualizando PokerLeven...
    cd PokerLeven
    git pull
    cd ..
)

pause
