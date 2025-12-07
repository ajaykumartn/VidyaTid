# Git LFS Complete Setup Guide for VidyaTid

## What is Git LFS?

Git Large File Storage (LFS) replaces large files with text pointers in Git, while storing the actual file contents on a remote server. This allows you to version large files without bloating your repository.

---

## Benefits for VidyaTid

- ✅ Push 1GB+ repository to GitHub
- ✅ Keep all folders (chroma_db, vector_store, ncert_content, etc.)
- ✅ Fast cloning (downloads large files on-demand)
- ✅ Version control for large files
- ✅ No timeout errors

---

## Step-by-Step Setup

### Step 1: Install Git LFS (One-time)

#### Windows:
1. Download from: **https://git-lfs.github.com/**
2. Run the installer
3. Verify installation:
   ```bash
   git lfs version
   ```
   Should show: `git-lfs/3.x.x`

#### Alternative (if Git for Windows installed):
```bash
# Git LFS might already be included
git lfs version
```

---

### Step 2: Setup Git LFS (Automated)

**Double-click this file:**
```
setup_git_lfs.bat
```

**Or run manually:**
```bash
# Initialize Git LFS
git lfs install

# Track large file patterns
git lfs track "*.pdf"
git lfs track "*.mp4"
git lfs track "*.avi"
git lfs track "*.mov"
git lfs track "chroma_db/**"
git lfs track "vector_store/**"
git lfs track "ncert_content/**"
git lfs track "diagrams/**"
git lfs track "previous_papers/**"

# Add .gitattributes
git add .gitattributes
git commit -m "Configure Git LFS"
```

---

### Step 3: Push with Git LFS (Automated)

**Double-click this file:**
```
push_with_lfs.bat
```

**Or run manually:**
```bash
# Configure Git for large files
git config http.postBuffer 524288000
git config http.timeout 600

# Add all files
git add .

# Commit
git commit -m "Add all files with Git LFS"

# Push
git push -u origin main
```

---

## What Gets Tracked by LFS?

### Large Files (via LFS):
- ✅ `*.pdf` - NCERT PDFs
- ✅ `*.mp4, *.avi, *.mov` - Video files
- ✅ `chroma_db/**` - Vector database (~300-400 MB)
- ✅ `vector_store/**` - Vector embeddings (~100-200 MB)
- ✅ `ncert_content/**` - NCERT content (~300-400 MB)
- ✅ `diagrams/**` - Diagram images (~50-100 MB)
- ✅ `previous_papers/**` - Previous papers (~50-100 MB)

### Regular Files (via Git):
- ✅ `*.py` - Python code
- ✅ `*.js, *.css, *.html` - Frontend files
- ✅ `*.md, *.txt, *.yaml` - Documentation
- ✅ `guruai.db, diagrams.db` - SQLite databases (small)

---

## GitHub LFS Limits

### Free Account:
- **Storage**: 1 GB free
- **Bandwidth**: 1 GB/month free
- **After limit**: $5/month for 50 GB storage + 50 GB bandwidth

### Your Repository:
- **Total size**: ~1.08 GB
- **LFS files**: ~900 MB
- **Regular files**: ~180 MB

**You're within the free limit!** ✅

---

## Verification

### Check LFS is working:
```bash
# Show LFS tracked files
git lfs ls-files

# Show LFS tracking patterns
git lfs track

# Show LFS status
git lfs status
```

### After push, verify on GitHub:
1. Go to: https://github.com/ajaykumartn/VidyaTid
2. Click on a large file (e.g., in `chroma_db/`)
3. Should show "Stored with Git LFS" badge

---

## Troubleshooting

### Issue 1: "git lfs: command not found"
**Solution**: Install Git LFS from https://git-lfs.github.com/

### Issue 2: "This repository is over its data quota"
**Solution**: 
- GitHub free tier: 1 GB storage
- Upgrade to GitHub Pro ($4/month) for 2 GB
- Or remove some large files

### Issue 3: Push still times out
**Solution**:
```bash
# Increase timeout further
git config http.timeout 1200

# Push with verbose output
GIT_CURL_VERBOSE=1 git push -u origin main
```

### Issue 4: "Authentication failed"
**Solution**: Use Personal Access Token
1. GitHub → Settings → Developer settings → Personal access tokens
2. Generate new token with `repo` scope
3. Use token as password

---

## Render Deployment with LFS

### Good News:
Render automatically handles Git LFS! When you deploy:

1. Render clones your repository
2. Automatically downloads LFS files
3. All folders available on server
4. Full functionality works!

### No extra configuration needed on Render! ✅

---

## Cost Comparison

### Option 1: Git LFS (Recommended)
- **GitHub**: Free (within 1 GB limit)
- **Render**: Free tier
- **Total**: $0

### Option 2: Exclude Large Folders
- **GitHub**: Free
- **Render**: Free tier
- **Missing**: RAG, diagrams, semantic search
- **Total**: $0

### Option 3: Render Disk
- **GitHub**: Free (small repo)
- **Render**: $1/GB/month
- **Total**: ~$1/month

**Git LFS is the best free solution!** ✅

---

## Quick Commands Reference

### Setup:
```bash
git lfs install
git lfs track "*.pdf"
git lfs track "chroma_db/**"
git add .gitattributes
git commit -m "Configure Git LFS"
```

### Push:
```bash
git add .
git commit -m "Add all files"
git push -u origin main
```

### Check:
```bash
git lfs ls-files
git lfs status
```

---

## Timeline

- **Install Git LFS**: 2 minutes
- **Setup LFS tracking**: 1 minute
- **Commit LFS config**: 1 minute
- **Push to GitHub**: 10-20 minutes (depending on internet speed)
- **Total**: ~15-25 minutes

---

## What Happens During Push?

```
1. Git analyzes files
2. Identifies LFS-tracked files
3. Uploads LFS files to GitHub LFS server
4. Uploads regular files to GitHub
5. Creates pointers in repository

Progress:
- Uploading LFS objects: [=====>    ] 45% (400 MB / 900 MB)
- Pushing commits: [==========] 100%
```

---

## After Successful Push

### Verify on GitHub:
1. Visit: https://github.com/ajaykumartn/VidyaTid
2. Check file count: Should show all files
3. Check LFS badge: Large files show "Stored with Git LFS"
4. Repository size: Shows ~180 MB (pointers only)

### Deploy to Render:
1. Go to render.com
2. Create Web Service
3. Select VidyaTid repository
4. Render automatically downloads LFS files
5. Full app works with all features!

---

## Summary

**Git LFS allows you to:**
- ✅ Push entire 1GB+ repository
- ✅ Keep all folders and features
- ✅ Stay within GitHub free tier
- ✅ Deploy to Render with full functionality
- ✅ No code changes needed

**Next Steps:**
1. Run `setup_git_lfs.bat`
2. Run `push_with_lfs.bat`
3. Deploy to Render
4. Enjoy full-featured app!

---

**Last Updated**: December 7, 2024  
**Status**: Ready for Git LFS Setup ✅
