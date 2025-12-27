@echo off
title Reparación de Navegadores y Sistema

REM Comprobación de BitLocker
echo =========================================
echo Comprobando estado de BitLocker en C:...
manage-bde -status C: | findstr /C:"Conversion Status" | findstr /C:"Fully Encrypted" >nul
if %errorlevel%==0 (
    echo BitLocker está activado. Procediendo a desactivarlo...
    manage-bde -off C:
) else (
    echo BitLocker no está activado. Continuando con la reparación...
)
echo =========================================
echo.

REM Paso 1: Limpieza directorio usuario TEMP
echo [1/8] Limpiando archivos temporales del usuario...
del /s /q "%TEMP%\*.*"
echo.

REM Paso 2: Limpieza archivos temporales del sistema C:\Windows\Temp
echo [2/8] Limpiando archivos temporales del sistema...
del /s /q "C:\Windows\Temp\*.*"
echo.


REM Paso 3: DISM CheckHealth
echo [3/8] Comprobando imagen de Windows (CheckHealth)...
DISM /Online /Cleanup-Image /CheckHealth
echo.

REM Paso 4: DISM ScanHealth
echo [4/8] Escaneando imagen de Windows (ScanHealth)...
DISM /Online /Cleanup-Image /ScanHealth
echo.

REM Paso 5: DISM RestoreHealth
echo [5/8] Reparando imagen de Windows (RestoreHealth)...
DISM /Online /Cleanup-Image /RestoreHealth
echo.

REM Paso 6: Comprobación y reparación de archivos del sistema
echo [6/8] Ejecutando comprobación de archivos del sistema (SFC)...
sfc /scannow
echo.

REM Paso 7: Reinicio de Winsock, IP y DNS
echo [7/8] Reiniciando configuración de red...
netsh winsock reset
netsh int ip reset
ipconfig /flushdns
echo.

REM Paso 8: Final
echo [8/8] Reparación finalizada.
echo Es recomendable reiniciar el PC ahora.
pause
