# VidyaTid - GitHub Repository Setup Guide

## Create New GitHub Repository (5 Minutes)

---

## Step 1: Create Repository on GitHub (2 minutes)

### 1.1 Go to GitHub
1. Open browser and go to: **https://github.com**
2. Click **"Sign in"** (or Sign up if you don't have an account)
3. Log in with your credentials

### 1.2 Create New Repository
1. Click the **"+"** icon (top right corner)
2. Select **"New repository"**

### 1.3 Repository Settings
Fill in the following:

**Repository Name:**
```
vidyatid
```
(or `VidyaTid` or `vidyatid-app` - your choice)

**Description:**
```
AI-Powered Learning Platform for JEE/NEET - Chat, Question Papers, AI Predictions, Video Generation
```

**Visibility:**
- ✅ Select **"Public"** (recommended for demo)
- OR **"Private"** (if you want to keep it private)

**Initialize Repository:**
- ❌ **DO NOT** check "Add a README file"
- ❌ **DO NOT** check "Add .gitignore"
- ❌ **DO NOT** check "Choose a license"

(We already have these files locally)

### 1.4 Create Repository
1. Click **"Create repository"** button
2. You'll see a page with setup instructions
3. **Copy the repository URL** - it will look like:
   ```
   https://github.com/YOUR_USERNAME/vidyatid.git
   ```

**✅ Checkpoint:** Repository created on GitHub!

---

## Step 2: Initialize Local Git Repository (3 minutes)

### 2.1 Check Current Git Status
```bash
# Check if git is already initialized
git status
```

**If you see:** "fatal: not a git repository"
- ✅ Good! Continue to Step 2.2

**If you see:** Git status output
- ⚠️ Git is already initialized
- Skip to Step 3

### 2.2 Initialize Git
```bash
# Initialize new git repository
git init

# Output: Initialized empty Git repository in ...
```

### 2.3 Configure Git (First Time Only)
```bash
# Set your name
git config --global user.name "Your Name"

# Set your email (use GitHub email)
git config --global user.email "your.email@example.com"

# Verify configuration
git config --list
```

**✅ Checkpoint:** Git initialized locally!

---

## Step 3: Add Files to Git (2 minutes)

### 3.1 Check What Will Be Added
```bash
# See all files that will be added
git status
```

### 3.2 Add All Files
```bash
# Add all files (including databases)
git add .

# Verify files are staged
git status
```

You should see files in green, including:
- ✅ `guruai.db`
- ✅ `diagrams.db`
- ✅ `render.yaml`
- ✅ All Python files
- ✅ All templates
- ✅ All static files

### 3.3 Create First Commit
```bash
# Commit all files
git commit -m "Initial commit: VidyaTid AI Learning Platform with databases"
```

**✅ Checkpoint:** All files committed locally!

---

## Step 4: Connect to GitHub (1 minute)

### 4.1 Add Remote Repository
```bash
# Replace YOUR_USERNAME with your actual GitHub username
git remote add origin https://github.com/YOUR_USERNAME/vidyatid.git

# Verify remote is added
git remote -v
```

**Output should show:**
```
origin  https://github.com/YOUR_USERNAME/vidyatid.git (fetch)
origin  https://github.com/YOUR_USERNAME/vidyatid.git (push)
```

### 4.2 Set Default Branch
```bash
# Rename branch to 'main' (GitHub default)
git branch -M main
```

**✅ Checkpoint:** Connected to GitHub!

---

## Step 5: Push to GitHub (1 minute)

### 5.1 Push Code
```bash
# Push all files to GitHub
git push -u origin main
```

**You may be asked to authenticate:**
- Enter your GitHub username
- Enter your GitHub password (or Personal Access Token)

**Note:** If using 2FA, you need a Personal Access Token:
1. Go to: https://github.com/settings/tokens
2. Click "Generate new token (classic)"
3. Select scopes: `repo` (full control)
4. Copy the token
5. Use token as password when pushing

### 5.2 Verify Upload
1. Go to your GitHub repository page
2. Refresh the page
3. You should see all your files!

**✅ Checkpoint:** Code pushed to GitHub!

---

## Step 6: Verify Everything (1 minute)

### 6.1 Check Repository on GitHub
Visit: `https://github.com/YOUR_USERNAME/vidyatid`

**Verify these files exist:**
- ✅ `guruai.db` (questions database)
- ✅ `diagrams.db` (diagrams database)
- ✅ `render.yaml` (Render config)
- ✅ `requirements.txt` (dependencies)
- ✅ `app.py` (main application)
- ✅ `README.md` (documentation)
- ✅ All folders: `static/`, `templates/`, `services/`, etc.

### 6.2 Check Database Files
1. Click on `guruai.db` in GitHub
2. Should show file size (e.g., 40 KB)
3. Click "View raw" to download and verify

**✅ Checkpoint:** Everything uploaded successfully!

---

## Troubleshooting

### Issue 1: "fatal: not a git repository"
**Solution:**
```bash
git init
```

### Issue 2: "remote origin already exists"
**Solution:**
```bash
# Remove existing remote
git remote remove ori