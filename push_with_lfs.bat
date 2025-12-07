@echo off
echo ==========================================
echo VidyaTid - Push with Git LFS
echo ==========================================
echo.

REM Check if Git LFS is installed
git lfs version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Git LFS is not installed!
    echo Please run: setup_git_lfs.bat first
    pause
    exit /b 1
)

echo [OK] Git LFS is ready
echo.

REM Increase buffer size for large pushes
echo Step 1: Configuring Git for large files...
git config http.postBuffer 524288000
git config http.timeout 600
git config lfs.concurrenttransfers 3
echo [OK] Git configured
echo.

REM Add all files
echo Step 2: Adding all files to Git...
git add .
echo [OK] Files added
echo.

REM Show status
echo Step 3: Files to be committed:
git status -s | findstr /V "^??" | head -20
echo ... (showing first 20 files)
echo.

REM Commit
echo Step 4: Creating commit...
set /p commit_msg="Enter commit message (or press Enter for default): "
if "%commit_msg%"=="" set commit_msg=Add all files with Git LFS for large content

git commit -m "%commit_msg%"
echo [OK] Committed
echo.

REM Show LFS files
echo Step 5: Files tracked by Git LFS:
git lfs ls-files
echo.

REM Push to GitHub
echo Step 6: Pushing to GitHub with Git LFS...
echo This may take several minutes for large files...
echo.
echo Progress:
git push -u origin main

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ==========================================
    echo SUCCESS! Repository pushed to GitHub
    echo ==========================================
    echo.
    echo Your repository: https://github.com/ajaykumartn/VidyaTid
    echo.
    echo Git LFS Summary:
    git lfs ls-files
    echo.
    echo Next Steps:
    echo 1. Verify files on GitHub
    echo 2. Deploy to Render
    echo 3. Follow COMPLETE_DEPLOYMENT_STEPS.md
    echo.
) else (
    echo.
    echo ==========================================
    echo PUSH FAILED
    echo ==========================================
    echo.
    echo Possible issues:
    echo 1. Network timeout - try again
    echo 2. GitHub LFS quota exceeded (1GB free per month)
    echo 3. Authentication failed - use Personal Access Token
    echo.
    echo To retry:
    echo git push -u origin main
    echo.
)

pause
