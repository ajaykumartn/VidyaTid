@echo off
REM VidyaTid - Push Essential Files Only (Exclude Large Folders)
echo ==========================================
echo VidyaTid - Push Essential Files Only
echo ==========================================
echo.
echo This will:
echo 1. Remove large folders from Git tracking
echo 2. Keep only essential files (code + databases)
echo 3. Push to GitHub (much faster!)
echo.
echo Large folders excluded:
echo - chroma_db/ (vector database)
echo - vector_store/ (embeddings)
echo - ncert_content/ (NCERT PDFs)
echo - diagrams/ (images)
echo - previous_papers/ (papers)
echo - *.mp4 (video files)
echo.
echo These can be uploaded separately or recreated on server.
echo.
pause
echo.

REM Step 1: Remove large folders from Git cache
echo Step 1: Removing large folders from Git tracking...
git rm -r --cached chroma_db/ 2>nul
git rm -r --cached vector_store/ 2>nul
git rm -r --cached ncert_content/ 2>nul
git rm -r --cached diagrams/ 2>nul
git rm -r --cached previous_papers/ 2>nul
git rm --cached *.mp4 2>nul
echo [OK] Large folders removed from tracking
echo.

REM Step 2: Add essential files
echo Step 2: Adding essential files...
git add .
echo [OK] Essential files added
echo.

REM Step 3: Show what will be committed
echo Step 3: Files to be committed (first 30):
git status -s | findstr /V "^D" | more
echo.

REM Step 4: Commit
echo Step 4: Creating commit...
git commit -m "Deploy: Essential files only (exclude large folders for GitHub limits)"
echo [OK] Committed
echo.

REM Step 5: Increase buffer and timeout
echo Step 5: Configuring Git for large push...
git config http.postBuffer 524288000
git config http.timeout 600
echo [OK] Git configured
echo.

REM Step 6: Push to GitHub
echo Step 6: Pushing to GitHub...
echo This should be much faster now (only ~50-100 MB)
echo.
git push -u origin main

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ==========================================
    echo SUCCESS! Essential files pushed to GitHub
    echo ==========================================
    echo.
    echo Repository: https://github.com/ajaykumartn/VidyaTid
    echo.
    echo What's included:
    echo [OK] guruai.db (questions database)
    echo [OK] diagrams.db (diagrams database)
    echo [OK] All Python code
    echo [OK] Templates and static files
    echo [OK] Configuration files
    echo.
    echo What's excluded:
    echo [X] chroma_db/ (can recreate on server)
    echo [X] vector_store/ (can recreate on server)
    echo [X] ncert_content/ (can upload separately)
    echo [X] diagrams/ (can upload separately)
    echo [X] previous_papers/ (can upload separately)
    echo.
    echo Core features will work:
    echo [OK] Chat Interface
    echo [OK] Question Paper Generation
    echo [OK] Snap and Solve
    echo [OK] Voice Features
    echo [OK] Authentication
    echo [OK] Payments
    echo.
    echo Next Steps:
    echo 1. Go to https://render.com
    echo 2. Create Web Service
    echo 3. Select VidyaTid r