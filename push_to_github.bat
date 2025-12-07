@echo off
REM VidyaTid - Push to GitHub Script
echo ==========================================
echo VidyaTid - GitHub Push Script
echo ==========================================
echo.

REM Check if git is initialized
if not exist ".git" (
    echo Initializing Git repository...
    git init
    echo [OK] Git initialized
) else (
    echo [OK] Git already initialized
)

echo.

REM Add all files (excluding .gitignore patterns)
echo Adding all files to Git...
git add .

echo [OK] Files added
echo.

REM Show what will be committed
echo Files to be committed:
git status -s
echo.

REM Commit
echo Creating commit...
git commit -m "Initial commit: VidyaTid with databases and all features"

echo [OK] Committed
echo.

REM Set main branch
echo Setting main branch...
git branch -M main
echo [OK] Branch set to main
echo.

REM Add remote (if not already added)
echo Checking remote...
git remote remove origin 2>nul
git remote add origin https://github.com/ajaykumartn/VidyaTid.git
echo [OK] Remote added
echo.

REM Push to GitHub
echo Pushing to GitHub...
echo This may take a few minutes if you have large files...
git push -u origin main

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ==========================================
    echo [SUCCESS] Pushed to GitHub!
    echo ==========================================
    echo.
    echo Your repository: https://github.com/ajaykumartn/VidyaTid
    echo.
    echo Next Steps:
    echo 1. Go to https://render.com
    echo 2. Sign up/Login with GitHub
    echo 3. Click 'New +' -^> 'Web Service'
    echo 4. Select 'VidyaTid' repository
    echo 5. Follow RENDER_DEPLOYMENT_GUIDE.md
    echo.
) else (
    echo.
    echo [ERROR] Push failed!
    echo.
    echo Common issues:
    echo 1. Authentication required - use GitHub Personal Access Token
    echo 2. Repository doesn't exist - create it on GitHub first
    echo 3. Files too large - check .gitignore
    echo.
    echo To fix authentication:
    echo 1. Go to GitHub -^> Settings -^> Developer settings -^> Personal access tokens
    echo 2. Generate new token with 'repo' permissions
    echo 3. Use token as password when prompted
    echo.
)

pause
