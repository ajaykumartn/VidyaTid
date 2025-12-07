@echo off
echo ==========================================
echo VidyaTid - Final Push to GitHub
echo ==========================================
echo.
echo This will push your code to:
echo https://github.com/ajaykumartn/VidyaTid
echo.
echo You may be asked for GitHub credentials:
echo - Username: ajaykumartn
echo - Password: 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
echo.
echo If you don't have a token:
echo 1. Go to GitHub -^> Settings -^> Developer settings -^> Personal access tokens
echo 2. Generate new token (classic)
echo 3. Select 'repo' scope
echo 4. Copy the token and use it as password
echo.
pause
echo.
echo Pushing to GitHub...
git push -u origin main
echo.
if %ERRORLEVEL% EQU 0 (
    echo ==========================================
    echo SUCCESS! Code pushed to GitHub
    echo ==========================================
    echo.
    echo View your repository:
    echo https://github.com/ajaykumartn/VidyaTid
    echo.
    echo Next Steps:
    echo 1. Go to https://render.com
    echo 2. Sign up with GitHub
    echo 3. Create Web Service
    echo 4. Select VidyaTid repository
    echo 5. Follow COMPLETE_DEPLOYMENT_STEPS.md
    echo.
) else (
    echo ==========================================
    echo PUSH FAILED
    echo ==========================================
    echo.
    echo Common issues:
    echo 1. Authentication failed - use Personal Access Token
    echo 2. Repository doesn't exist - create it on GitHub first
    echo 3. Network issues - check internet connection
    echo.
)
pause
