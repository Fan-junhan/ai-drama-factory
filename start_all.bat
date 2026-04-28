@echo off
chcp 65001 >nul
echo ========================================
echo   同时启动前后端服务
echo ========================================
echo.

cd /d "%~dp0"

echo 启动后端服务...
start "AI Drama Factory - Backend" cmd /k "cd /d %~dp0 && call start_backend.bat"

timeout /t 3 >nul

echo 启动前端服务...
start "AI Drama Factory - Frontend" cmd /k "cd /d %~dp0 && call start_frontend.bat"

echo.
echo 服务已启动！
echo   后端: http://127.0.0.1:8000
echo   前端: http://localhost:5173
echo.
pause
