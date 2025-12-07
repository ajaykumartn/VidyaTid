#!/bin/bash

# VidyaTid - Quick Deploy to Render Script
# This script prepares your project for Render deployment

echo "=========================================="
echo "VidyaTid - Render Deployment Preparation"
echo "=========================================="
echo ""

# Step 1: Check if databases exist
echo "Step 1: Checking database files..."
if [ -f "guruai.db" ]; then
    echo "✅ guruai.db found ($(du -h guruai.db | cut -f1))"
else
    echo "❌ guruai.db not found!"
    echo "   Run: python init_db.py"
    exit 1
fi

if [ -f "diagrams.db" ]; then
    echo "✅ diagrams.db found ($(du -h diagrams.db | cut -f1))"
else
    echo "⚠️  diagrams.db not found (optional)"
fi

echo ""

# Step 2: Check if .gitignore is updated
echo "Step 2: Checking .gitignore..."
if grep -q "^# \*.db" .gitignore; then
    echo "✅ .gitignore updated to include databases"
else
    echo "⚠️  .gitignore may need updating"
fi

echo ""

# Step 3: Check if render.yaml exists
echo "Step 3: Checking render.yaml..."
if [ -f "render.yaml" ]; then
    echo "✅ render.yaml configuration found"
else
    echo "❌ render.yaml not found!"
    exit 1
fi

echo ""

# Step 4: Check requirements.txt
echo "Step 4: Checking requirements.txt..."
if [ -f "requirements.txt" ]; then
    echo "✅ requirements.txt found"
    echo "   Packages: $(wc -l < requirements.txt) lines"
else
    echo "❌ requirements.txt not found!"
    echo "   Run: pip freeze > requirements.txt"
    exit 1
fi

echo ""

# Step 5: Check git status
echo "Step 5: Checking git status..."
if git rev-parse --git-dir > /dev/null 2>&1; then
    echo "✅ Git repository initialized"
    
    # Check if there are uncommitted changes
    if [[ -n $(git status -s) ]]; then
        echo "⚠️  You have uncommitted changes:"
        git status -s
    else
        echo "✅ No uncommitted changes"
    fi
else
    echo "❌ Not a git repository!"
    echo "   Run: git init"
    exit 1
fi

echo ""

# Step 6: Add files to git
echo "Step 6: Adding files to git..."
echo "Running: git add guruai.db diagrams.db .gitignore render.yaml"
git add guruai.db diagrams.db .gitignore render.yaml RENDER_DEPLOYMENT_GUIDE.md

echo "✅ Files staged for commit"
echo ""

# Step 7: Show what will be committed
echo "Step 7: Files ready to commit:"
git status -s
echo ""

# Step 8: Commit
echo "Step 8: Creating commit..."
read -p "Enter commit message (or press Enter for default): " commit_msg
if [ -z "$commit_msg" ]; then
    commit_msg="Add databases and Render configuration for deployment"
fi

git commit -m "$commit_msg"
echo "✅ Changes committed"
echo ""

# Step 9: Check remote
echo "Step 9: Checking git remote..."
if git remote -v | grep -q "origin"; then
    echo "✅ Git remote 'origin' configured:"
    git remote -v | grep origin
    echo ""
    
    # Ask to push
    read -p "Push to GitHub now? (y/n): " push_confirm
    if [ "$push_confirm" = "y" ] || [ "$push_confirm" = "Y" ]; then
        echo "Pushing to GitHub..."
        git push origin main || git push origin master
        echo "✅ Pushed to GitHub"
    else
        echo "⚠️  Remember to push manually: git push origin main"
    fi
else
    echo "⚠️  No git remote configured"
    echo "   Add remote: git remote add origin <your-repo-url>"
fi

echo ""
echo "=========================================="
echo "✅ Preparation Complete!"
echo "=========================================="
echo ""
echo "Next Steps:"
echo "1. Go to https://render.com"
echo "2. Sign up/Login with GitHub"
echo "3. Click 'New +' → 'Web Service'"
echo "4. Select your repository"
echo "5. Follow RENDER_DEPLOYMENT_GUIDE.md"
echo ""
echo "Your app will be live at:"
echo "https://vidyatid.onrender.com"
echo ""
echo "=========================================="
