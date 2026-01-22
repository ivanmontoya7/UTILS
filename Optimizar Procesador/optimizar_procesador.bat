@echo off
:: Verificar privilegios de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Este script requiere permisos de administrador.
    echo Por favor, ejecutalo haciendo clic derecho y seleccionando "Ejecutar como administrador"
    pause
    exit /b 1
)

:: Cambiar el valor de Attributes a 2 en el registro
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\be337238-0d82-4146-a960-4f3749d470c7" /v Attributes /t REG_DWORD /d 2 /f

:: Obtener el GUID del plan de energia activo (compatible con cualquier idioma)
for /f "tokens=2 delims=:" %%a in ('powercfg /getactivescheme') do (
    for /f "tokens=1" %%b in ("%%a") do set GUID=%%b
)



:: Deshabilitar modo de mejora del rendimiento con bateria (DC = con bateria, valor 0 = deshabilitado)
powercfg -setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 0

:: Deshabilitar modo de mejora del rendimiento con corriente alterna (AC = enchufado, valor 0 = deshabilitado)
powercfg -setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 0

:: Aplicar los cambios al plan activo
powercfg -setactive %GUID%

:: Forzar actualizacion del esquema
powercfg -changename %GUID% >nul 2>&1

echo.
echo ============================================================
echo Configuracion completada exitosamente!
echo ============================================================
echo.
echo El Modo agresivo del procesador ha sido
echo deshabilitado tanto con bateria como con corriente alterna.
echo.
echo Puedes verificar los cambios en:
echo Panel de control ^> Opciones de energia ^> Cambiar la configuracion
echo del plan ^> Cambiar la configuracion avanzada de energia
echo.
pause