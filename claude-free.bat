@echo off
title Claude Code - FreeLLMAPI

rem === Thu muc FreeLLMAPI va thu muc du an (sua neu can) ===
set FREELLM_DIR=C:\Users\thitm\freellmapi
set PROJECT_DIR=C:\Users\thitm\my-project

rem === Bat server neu cong 3001 chua chay ===
netstat -ano | findstr ":3001" | findstr "LISTENING" >nul
if errorlevel 1 (
    echo Dang bat server FreeLLMAPI...
    start "FreeLLMAPI Server" cmd /k "cd /d %FREELLM_DIR% && npm run dev"
    echo Cho server khoi dong...
    timeout /t 12 /nobreak >nul
) else (
    echo Server FreeLLMAPI dang chay san.
)

rem === Cau hinh Claude Code tro vao FreeLLMAPI ===
set ANTHROPIC_BASE_URL=http://localhost:3001
set ANTHROPIC_AUTH_TOKEN=freellmapi-2da8e9b675db227b5e5b99283d9d7d95a3e1d5a456b1715f

if not exist "%PROJECT_DIR%" mkdir "%PROJECT_DIR%"
cd /d "%PROJECT_DIR%"
claude
