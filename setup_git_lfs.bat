@echo off
echo ==========================================
echo VidyaTid - Git LFS Setup
echo ==========================================
echo.

REM Check if Git LFS is installed
echo Step 1: Checking Git LFS installation...
git lfs version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [OK] Git LFS is installed
    git lfs version
) else (
    echo [ERROR] Git LFS is not installed!
    echo.
    echo Please install Git LFS:
    echo 1. Download from: https://git-lfs.github.com/
    echo 2. Run the installer
    echo 3. Run this script again
    echo.
    pause
    exit /b 1
)

echo.

REM Initialize Git LFS
echo Step 2: Initializing Git LFS...
git lfs install
echo [OK] Git LFS initialized
echo.

REM Track large file patterns
echo Step 3: Configuring Git LFS to track large files...
echo.

echo Tracking PDF files...
git lfs track "*.pdf"

echo Tracking video files...
git lfs track "*.mp4"
git lfs track "*.avi"
git lfs track "*.mov"

echo Tracking database files in chroma_db...
git lfs track "chroma_db/**"

echo Tracking vector store files...
git lfs track "vector_store/**"

echo Tracking NCERT content...
git lfs track "ncert_content/**"

echo Tracking diagrams...
git lfs track "diagrams/**"

echo Tracking previous papers...
git lfs track "previous_papers/**"

echo.
echo [OK] Git LFS tracking configured
echo.

REM Add .gitattributes
echo Step 4: Adding .gitattributes file...
git add .gitattributes
echo [OK] .gitattributes added
echo.

REM Show what will be tracked by LFS
echo Step 5: Files that will be tracked by Git LFS:
git lfs track
echo.

REM Commit LFS configuration
echo Step 6: Committing Git LFS configuration...
git commit -m "Configure Git LFS for large files"
echo [OK] LFS configuration committed
echo.

echo ==========================================
echo Git LFS Setup Complete!
echo ==========================================
echo.
echo Large files will now be stored in Git LFS:
echo - PDF files (*.pdf)
echo - Video files (*.mp4, *.avi, *.mov)
echo - chroma_db/ folder
echo - vector_store/ folder
echo - ncert_content/ folder
echo - diagrams/ folder
echo - previous_papers/ folder
echo.
echo Next Steps:
echo 1. Run: push_with_lfs.bat
echo 2. Or manually: git push -u origin main
echo.
pause
