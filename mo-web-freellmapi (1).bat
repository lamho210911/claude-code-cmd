@echo off
title Mo web FreeLLMAPI
set FREELLM_DIR=C:\Users\thitm\freellmapi
set /a TRIES=0

netstat -ano | findstr ":5173" | findstr "LISTENING" >nul
if not errorlevel 1 goto open

echo Server chua chay, dang bat server FreeLLMAPI...
start "FreeLLMAPI Server" cmd /k "cd /d %FREELLM_DIR% && npm run dev"

:wait
timeout /t 3 /nobreak >nul
set /a TRIES+=1
netstat -ano | findstr ":5173" | findstr "LISTENING" >nul
if not errorlevel 1 goto open
if %TRIES% GEQ 20 goto fail
goto wait

:open
start http://localhost:5173
exit /b

:fail
echo Khong bat duoc server sau 60 giay.
echo Hay xem cua so "FreeLLMAPI Server" de biet loi.
pause
