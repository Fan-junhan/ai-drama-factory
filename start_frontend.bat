@echo off
chcp 65001 >nul
echo 启动前端服务...
cd /d "%~dp0frontend"
if not exist node_modules (
    echo 安装依赖...
    npm install
)
echo.
echo 前端地址: http://localhost:5173
echo.
npm run dev
