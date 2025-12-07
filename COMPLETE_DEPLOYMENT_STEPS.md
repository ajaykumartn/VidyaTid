# VidyaTid - Complete Deployment Steps

## 🚀 Deploy in 15 Minutes

---

## Part 1: Push to GitHub (5 minutes)

### Option A: Use Automated Script (Easiest)

**Windows:**
```bash
# Double-click this file:
push_to_github.bat
```

**Or run in terminal:**
```bash
.\push_to_github.bat
```

---

### Option B: Manual Commands

**Step 1: Add all files**
```bash
git add .
```

**Step 2: Commit**
```bash
git commit -m "Initial commit: VidyaTid with databases and all features"
```

**Step 3: Set main branch**
```bash
git branch -M main
```

**Step 4: Add remote (if not already added)**
```bash
git remote add origin https://github.com/ajaykumartn/VidyaTid.git
```

If remote already exists:
```bash
git remote remove origin
git remote add origin https://github.com/ajaykumartn/VidyaTid.git
```

**Step 5: Push to GitHub**
```bash
git push -u origin main
```

---

### 🔐 If Authentication Fails:

1. Go to **GitHub** → **Settings** → **Developer settings** → **Personal access tokens**
2. Click **"Generate new token (classic)"**
3. Give it a name: `VidyaTid Deployment`
4. Select scope: **`repo`** (full control of private repositories)
5. Click **"Generate token"**
6. **Copy the token** (you won't see it again!)
7. When git asks for password, **paste the token**

---

### ✅ Verify Push Success:

Visit: **https://github.com/ajaykumartn/VidyaTid**

You should see:
- ✅ All your files
- ✅ `guruai.db` (questions database)
- ✅ `diagrams.db` (diagrams database)
- ✅ `render.yaml` (Render config)
- ✅ All Python files
- ✅ All templates and static files

---

## Part 2: Deploy to Render (10 minutes)

### Step 1: Create Render Account

1. Go to **https://render.com**
2. Click **"Get Started"**
3. Sign up with **GitHub** (easiest)
4. Authorize Render to access your repositories

---

### Step 2: Create Web Service

1. Click **"New +"** (top right)
2. Select **"Web Service"**
3. Click **"Connect a repository"**
4. Find **"VidyaTid"** repository
5. Click **"Connect"**

---

### Step 3: Configure Service

**Basic Settings:**
- **Name**: `vidyatid`
- **Region**: `Singapore`
- **Branch**: `main`
- **Environment**: `Python 3`
- **Build Command**: `pip install -r requirements.txt`
- **Start Command**: `python start_app.py`
- **Plan**: `Free`

---

### Step 4: Add Environment Variables

Click **"Add Environment Variable"** for each:

```bash
# 1. Gemini API Keys (REQUIRED)
GEMINI_API_KEYS=AIzaSyBc7CqQyDnxg8qHeZ2pm4yQMBHsKzHYBRk,AIzaSyAQLfGMy19IDO2iNmz0aQA4B6nEmfo1ESw

# 2. Use Gemini
USE_GEMINI=true

# 3. Cloudflare Account ID
CLOUDFLARE_ACCOUNT_ID=your_cloudflare_account_id

# 4. Cloudflare API Token
CLOUDFLARE_API_TOKEN=your_cloudflare_api_token

# 5. Use Cloudflare AI
USE_CLOUDFLARE_AI=true

# 6. ElevenLabs API Key
ELEVENLABS_API_KEY=your_elevenlabs_api_key

# 7. Secret Key
SECRET_KEY=your-super-secret-key-change-this-12345

# 8. Render Flag
RENDER=true

# 9. Python Version
PYTHON_VERSION=3.11.0
```

**💡 Tip:** Copy values from your `.env` file!

---

### Step 5: Deploy!

1. Click **"Create Web Service"**
2. Wait 5-10 minutes for deployment
3. Watch the logs for progress

---

### Step 6: Get Your URL

Once deployed, you'll see:
```
Your service is live at:
https://vidyatid.onrender.com
```

**🎉 Your app is now live!**

---

## Part 3: Test Your Deployment (2 minutes)

### Test 1: Homepage
Visit: `https://vidyatid.onrender.com`
- ✅ Should load VidyaTid homepage
- ✅ CSS and images should display

### Test 2: Question Paper Generation
1. Go to: `https://vidyatid.onrender.com/question-paper`
2. Click **"Custom Paper"**
3. Select **Physics**, 10 questions
4. Click **"Generate Question Paper"**
5. **Verify**: Shows REAL questions (not "Option A, Option B")

### Test 3: Chat Interface
1. Go to: `https://vidyatid.onrender.com/`
2. Ask: "What is Newton's second law?"
3. **Verify**: Gets AI response

---

## 🎯 Success Checklist

- [ ] Code pushed to GitHub
- [ ] Render service created
- [ ] Environment variables added
- [ ] Deployment successful
- [ ] URL accessible
- [ ] Homepage loads
- [ ] Question papers work with real questions
- [ ] Chat interface responds
- [ ] No critical errors in logs

---

## 📊 What's Included in Deployment

### ✅ Working Features:
- Chat Interface (Gemini AI)
- Question Paper Generation (12 questions from SQLite)
- Snap & Solve (OCR + Gemini)
- Voice Input/Output (ElevenLabs)
- Progress Tracking
- Search (basic)
- User Authentication
- Payment Integration (Razorpay)

### ⚠️ Limited Features (due to excluded folders):
- RAG System (needs chroma_db/)
- Interactive Diagrams (needs diagrams/ folder)
- Semantic Search (needs vector_store/)

**Note:** Core features work perfectly! Advanced features can be added later.

---

## 🔧 Troubleshooting

### Issue: "Database not found"
**Solution:**
```bash
# Verify database is in Git
git ls-files | grep .db

# If not found, add it:
git add guruai.db diagrams.db
git commit -m "Add databases"
git push
```

### Issue: "Paper shows mock data"
**Solution:**
- Check Render logs for database errors
- Verify `guruai.db` has questions: `python check_questions_db.py`
- Ensure database file is not empty

### Issue: "Gemini API errors"
**Solution:**
- Verify `GEMINI_API_KEYS` in Render environment variables
- Check API keys are valid
- Review Render logs for specific errors

---

## 📚 Additional Resources

- **Deployment Guide**: `RENDER_DEPLOYMENT_GUIDE.md`
- **Environment Variables**: `RENDER_ENV_VARS.txt`
- **Deployment Checklist**: `DEPLOYMENT_CHECKLIST.md`
- **GitHub Commands**: `GITHUB_PUSH_COMMANDS.txt`

---

## 🎬 For Demo Video

Your live URL: **https://vidyatid.onrender.com**

Use this in your demo video to show:
- ✅ Live working application
- ✅ Real question paper generation
- ✅ AI-powered chat
- ✅ All features functional
- ✅ Professional deployment

---

## ⏱️ Timeline

- **GitHub Push**: 5 minutes
- **Render Setup**: 5 minutes
- **Deployment**: 5-10 minutes
- **Testing**: 2 minutes
- **Total**: ~15-20 minutes

---

## 💰 Cost

**Everything is FREE!**
- ✅ GitHub: Free
- ✅ Render: Free tier
- ✅ Gemini API: Free tier
- ✅ Cloudflare: Free tier
- ✅ Total: $0

---

## 🚀 Next Steps After Deployment

1. **Share your URL** with team/testers
2. **Record demo video** using live app
3. **Monitor logs** in Render dashboard
4. **Add more questions** to database as needed
5. **Upgrade to PostgreSQL** for permanent storage (optional)
6. **Add Cloudflare Pages** for faster frontend (optional)

---

**Ready to deploy? Start with Part 1! 🚀**

---

**Last Updated**: December 7, 2024  
**Status**: Ready for Deployment ✅
