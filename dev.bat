@echo off
chcp 65001 >nul
echo ========================================
echo   AI Drama Factory - 开发调试启动器
echo ========================================
echo.

cd /d "%~dp0"

echo [1] 启动后端服务 (端口 8000)
echo [2] 启动前端服务 (端口 5173)
echo [3] 同时启动前后端
echo [4] 仅安装依赖
echo [5] 退出
echo.

set /p choice=请选择 (1-5): 

if "%choice%"=="1" goto backend
if "%choice%"=="2" goto frontend
if "%choice%"=="3" goto both
if "%choice%"=="4" goto install
if "%choice%"=="5" exit

:backend
echo.
echo 正在启动后端...
cd backend
if not exist venv (
    echo 创建虚拟环境...
    python -m venv venv
    call venv\Scripts\activate
    pip install -r requirements.txt
) else (
    call venv\Scripts\activate
)
uvicorn app.main:app --reload --port 8000
goto end

:frontend
echo.
echo 正在启动前端...
cd frontend
if not exist node_modules (
    echo 安装前端依赖...
    npm install
)
npm run dev
goto end

:both
echo.
echo 正在同时启动前后端...
start cmd /k "cd /d %~dp0 && call dev.bat" 
timeout /t 2 >nul
start cmd /k "cd /d %~dp0\frontend && npm run dev"
cd backend
if not exist venv (
    python -m venv venv
    call venv\Scripts\activate
    pip install -r requirements.txt
) else (
    call venv\Scripts\activate
)
uvicorn app.main:app --reload --port 8000
goto end

:install
echo.
echo 安装后端依赖...
cd backend
if not exist venv (
    python -m venv venv
)
call venv\Scripts\activate
pip install -r requirements.txt
echo.
echo 安装前端依赖...
cd ..\frontend
npm install
echo.
echo 依赖安装完成！
pause
goto end

:end
