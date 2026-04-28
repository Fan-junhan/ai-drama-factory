@echo off
chcp 65001 >nul
echo 启动后端服务...
cd /d "%~dp0backend"
if not exist manhua (
    echo 创建虚拟环境...
    python -m venv manhua
    call manhua\Scripts\activate
    pip install -r requirements.txt
) else (
    call manhua\Scripts\activate
)
echo.
echo 后端地址: http://127.0.0.1:8000
echo API 文档: http://127.0.0.1:8000/docs
echo.
python -m uvicorn app.main:app --reload --port 8000