@echo off
setlocal enabledelayedexpansion

:: Duración en milisegundos (2000 ms = 2 s)
set "DUR_MS=250"

:: Normaliza %time% (si la hora tiene un espacio inicial lo convertimos a 0)
set "t=%time: =0%"

:: Extraer componentes de tiempo (formato típico: HH:MM:SS.cc)
set "hh=%t:~0,2%"
set "mm=%t:~3,2%"
set "ss=%t:~6,2%"
set "cc=%t:~9,2%"

:: Calcular tiempo de inicio en milisegundos desde medianoche
:: (se usa 1%var%-100 para evitar problemas con ceros a la izquierda)
set /a start_ms=(1%hh%-100)*3600*1000 + (1%mm%-100)*60*1000 + (1%ss%-100)*1000 + (1%cc%-100)*10

set /a count=0

:loop
:: leer tiempo actual
set "t=%time: =0%"
set "hh=%t:~0,2%"
set "mm=%t:~3,2%"
set "ss=%t:~6,2%"
set "cc=%t:~9,2%"

set /a now_ms=(1%hh%-100)*3600*1000 + (1%mm%-100)*60*1000 + (1%ss%-100)*1000 + (1%cc%-100)*10

:: manejar posible cruce de medianoche (si now_ms < start_ms)
set /a elapsed_ms=now_ms-start_ms
if %elapsed_ms% LSS 0 set /a elapsed_ms+=86400000

:: salir si excede la duración
if %elapsed_ms% GEQ %DUR_MS% goto end

:: --- LA ACCIÓN QUE QUIERES EJECUTAR ---



start "" cmd



:: contar repeticiones (opcional)
set /a count+=1

goto loop

:end
echo.
echo Fin: la línea se ejecutó %count% veces en %DUR_MS% ms.
pause
