@echo off
REM VidyaTid - Quick Deploy to Render Script (Windows)
REM This script prepares your project for Render deployment

echo ==========================================
echo VidyaTid - Render Deployment Preparation
echo ==========================================
echo.

REM Step 1: Check if databases exist
echo Step 1: Checking database files...
if exist "guruai.db" (
    echo [OK] guruai.db found
) else (
    echo [ERROR] guruai.db not found!
    echo    Run: python init_db.py
    exit /b 1
)

if exist "diagrams.db" (
    echo [OK] diagrams.db found
) else (
    echo [WARNING] diagrams.db not found (optional)
)

echo.

REM Step 2: Check if render.yaml exists
echo Step 2: Checking render.yaml...
if exist "render.yaml" (
    echo [OK] render.yaml configuration found
) else (
    echo [ERROR] render.yaml not found!
    exit /b 1
)

echo.

REM Step 3: Check requirements.txt
echo Step 3: Checking requirements.txt...
if exist "requirements.txt" (
    echo [OK] requirements.txt found
) else (
    echo [ERROR] requirements.txt not found!
    echo    Run: pip freeze ^> requirements.txt
    exit /b 1
)

echo.

REM Step 4: Add files to git
echo Step 4: Adding files to git...
echo Running: git add guruai.db diagrams.db .gitignore render.yaml
git add guruai.db diagrams.db .gitignore render.yaml RENDER_DEPLOYMENT_GUIDE.md

echo [OK] Files staged for commit
echo.

REM Step 5: Show what will be committed
echo Step 5: Files ready to commit:
git status -s
echo.

REM Step 6: Commit
echo Step 6: Creating commit...
set /p commit_msg="Enter commit message (or press Enter for default): "
if "%commit_msg%"=="" set commit_msg=Add databases and Render configuration for deployment

git commit -m "%commit_msg%"
echo [OK] Changes committed
echo.

REM Step 7: Push to GitHub
echo Step 7: Pushing to GitHub...
set /p push_confirm="Push to GitHub now? (y/n): "
if /i "%push_confirm%"=="y" (
    echo Pushing to GitHub...
    git push origin main || git push origin master
    echo [OK] Pushed to GitHub
) else (
    echo [WARNING] Remember to push manually: git push origin main
)

echo.
echo ==========================================
echo [OK] Preparation Complete!
echo ==========================================
echo.
echo Next Steps:
echo 1. Go to https://render.com
echo 2. Sign up/Login with GitHub
echo 3. Click 'New +' -^> 'Web Service'
echo 4. Select your repository
echo 5. Follow RENDER_DEPLOYMENT_GUIDE.md
echo.
echo Your app will be live at:
echo https://vidyatid.onrender.com
echo.
echo ==========================================
pause
