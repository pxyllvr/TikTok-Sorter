@echo off
title TikTok-Sorter Setup
echo.
echo ========================================
echo   TikTok-Sorter - First Time Setup
echo ========================================
echo.

:: Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python is not installed or not in PATH.
    echo Please install Python 3.10+ from https://www.python.org/downloads/
    echo Make sure to check "Add Python to PATH" during installation.
    pause
    exit /b 1
)

echo [1/4] Creating virtual environment...
python -m venv tiktoksorter-env
if errorlevel 1 (
    echo [ERROR] Failed to create virtual environment.
    pause
    exit /b 1
)

echo [2/4] Activating virtual environment...
call tiktoksorter-env\Scripts\activate.bat

echo [3/4] Upgrading pip...
python -m pip install --upgrade pip

echo [4/4] Installing dependencies...
echo.
echo Installing base packages...
pip install numpy pillow fastapi "uvicorn[standard]" open_clip_torch

echo.
echo ----------------------------------------
echo Now installing PyTorch...
echo.
echo Choose your option:
echo   1. NVIDIA GPU (CUDA 12.6) - Recommended for most people
echo   2. NVIDIA GPU (CUDA 12.8)
echo   3. NVIDIA GPU (CUDA 13.0)
echo   4. CPU only (much slower)
echo.
set /p choice="Enter number (1-4): "

if "%choice%"=="1" (
    pip install torch --index-url https://download.pytorch.org/whl/cu126
) else if "%choice%"=="2" (
    pip install torch --index-url https://download.pytorch.org/whl/cu128
) else if "%choice%"=="3" (
    pip install torch --index-url https://download.pytorch.org/whl/cu130
) else (
    pip install torch
)

echo.
echo ----------------------------------------
echo Verifying installation...
python -c "import torch; print('Torch version:', torch.__version__); print('CUDA available:', torch.cuda.is_available())"

echo.
echo ========================================
echo   Setup complete!
echo ========================================
echo.
echo You can now close this window and double-click
echo "Start TikTokSorter.bat" to launch the app.
echo.
pause
