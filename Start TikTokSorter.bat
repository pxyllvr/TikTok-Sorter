@echo off
title TikTok-Sorter
REM ===========================================================================
REM  TikTok-Sorter launcher
REM  Double-click THIS file to start the app.
REM  It will automatically activate the virtual environment if it exists.
REM ===========================================================================

cd /d "%~dp0"

:: Check if virtual environment exists
if exist "tiktoksorter-env\Scripts\activate.bat" (
    echo Activating virtual environment...
    call tiktoksorter-env\Scripts\activate.bat
) else (
    echo.
    echo [WARNING] Virtual environment not found.
    echo Please run setup.bat first to create it.
    echo.
    pause
    exit /b 1
)

:: Open browser after short delay
start "" cmd /c "timeout /t 3 >nul & start http://localhost:8000"

:: Start the server
echo Starting TikTok-Sorter...
echo Keep this window open while using the app.
echo.
python clipfinder.py

echo.
echo Server stopped.
pause
