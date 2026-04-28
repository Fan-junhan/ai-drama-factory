@echo off
title AI Drama Factory - Start

echo ========================================
echo    AI Drama Factory - Starting...
echo ========================================
echo.

REM Use the existing virtual environment in parent directory
set VENV_PATH=%~dp0..\.venv

if not exist "%VENV_PATH%\Scripts\python.exe" (
    echo [ERROR] Virtual environment not found!
    echo Expected location: %VENV_PATH%
    echo.
    echo Please run the following commands first:
    echo   python -m venv .venv
    echo   .venv\Scripts\activate
    echo   pip install -r ai-drama-factory\backend\requirements.txt
    echo   cd ai-drama-factory\frontend ^&^& npm install
    pause
    exit /b 1
)

echo [1/5] Virtual environment found: %VENV_PATH%

REM Check Node.js
where node >nul 2>&1
if errorlevel 1 (
    if exist "C:\Program Files\nodejs\node.exe" (
        echo [2/5] Node.js found: C:\Program Files\nodejs\node.exe
    ) else (
        echo [ERROR] Node.js not found!
        echo Please install Node.js 18+ from: https://nodejs.org/
        pause
        exit /b 1
    )
) else (
    echo [2/5] Node.js... OK
)

REM Check FFmpeg
where ffmpeg >nul 2>&1
if errorlevel 1 (
    if exist "C:\ffmpeg\ffmpeg-7.1.1-essentials_build\bin\ffmpeg.exe" (
        echo [3/5] FFmpeg... OK (custom path)
    ) else (
        echo [3/5] FFmpeg... Not found (optional for video merge)
    )
) else (
    echo [3/5] FFmpeg... OK
)

REM Start backend (hidden)
echo [4/5] Starting backend...
start /b cmd /c "cd /d "%~dp0backend" && "%VENV_PATH%\Scripts\python.exe" -m uvicorn app.main:app --host 0.0.0.0 --port 8000 >nul 2>&1"

REM Wait for backend
timeout /t 3 /nobreak >nul

REM Go to frontend directory
cd /d "%~dp0frontend"

if not exist "node_modules" (
    echo [4/5] Installing frontend dependencies...
    npm install
)

REM Start frontend (hidden)
echo [5/5] Starting frontend...
start /b cmd /c "cd /d "%~dp0frontend" && npm run dev >nul 2>&1"

REM Wait for frontend
timeout /t 5 /nobreak >nul

echo.
echo ========================================
echo   Started! Opening browser...
echo ========================================
echo.

REM Open browser
start http://localhost:5173

echo Browser opened. You can close this window.
echo To stop services, close this window or end node.exe/python.exe in Task Manager.
echo.
pause
