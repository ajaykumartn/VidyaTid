@echo off
echo ==========================================
echo VidyaTid - Quick Start with Git LFS
echo ==========================================
echo.
echo This script will:
echo 1. Check Git LFS installation
echo 2. Setup Git LFS tracking
echo 3. Push to GitHub with LFS
echo.
echo Total time: ~15-25 minutes
echo.
pause

REM Step 1: Check Git LFS
echo.
echo [1/3] Checking Git LFS...
git lfs version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Git LFS not installed!
    echo.
    echo Please install Git LFS:
    echo 1. Visit: https://git-lfs.github.com/
    echo 2. Download and install
    echo 3. Run this script again
    echo.
    start https://git-lfs.github.com/
    pause
    exit /b 1
)
echo [OK] Git LFS is installed
echo.

REM Step 2: Setup Git LFS
echo [2/3] Setting up Git LFS...
call setup_git_lfs.bat
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Git LFS setup failed
    pause
    exit /b 1
)
echo.

REM Step 3: Push with LFS
echo [3/3] Pushing to GitHub with Git LFS...
call push_with_lfs.bat
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Push failed
    pause
    exit /b 1
)

echo.
echo ==========================================
echo ALL DONE! Repository pushed successfully
echo ==========================================
echo.
echo Your repository: https://github.com/ajaykumartn/VidyaTid
echo.
echo Next: Deploy to Render
echo Follow: COMPLETE_DEPLOYMENT_STEPS.md
echo.
pause
