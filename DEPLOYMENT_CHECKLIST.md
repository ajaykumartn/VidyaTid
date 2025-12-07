# VidyaTid - Render Deployment Checklist

## Pre-Deployment Checklist

### Local Preparation
- [ ] Database files exist (`guruai.db` and `diagrams.db`)
- [ ] `.gitignore` updated to include databases
- [ ] `render.yaml` configuration file created
- [ ] `requirements.txt` is up to date
- [ ] `.env` file has all required API keys
- [ ] All changes committed to Git
- [ ] Code pushed to GitHub

### Files to Commit
- [ ] `guruai.db` (questions database)
- [ ] `diagrams.db` (diagrams database)
- [ ] `.gitignore` (updated)
- [ ] `render.yaml` (Render configuration)
- [ ] `RENDER_DEPLOYMENT_GUIDE.md` (deployment guide)
- [ ] `requirements.txt` (Python dependencies)

---

## Render Setup Checklist

### Account Setup
- [ ] Render account created at render.com
- [ ] GitHub account connected to Render
- [ ] Repository access granted

### Service Configuration
- [ ] New Web Service created
- [ ] Repository connected
- [ ] Service name: `vidyatid`
- [ ] Region: `Singapore`
- [ ] Environment: `Python 3`
- [ ] Build command: `pip install -r requirements.txt`
- [ ] Start command: `python start_app.py`
- [ ] Plan: `Free` selected

### Environment Variables
- [ ] `GEMINI_API_KEYS` (comma-separated keys)
- [ ] `USE_GEMINI=true`
- [ ] `CLOUDFLARE_ACCOUNT_ID`
- [ ] `CLOUDFLARE_API_TOKEN`
- [ ] `USE_CLOUDFLARE_AI=true`
- [ ] `ELEVENLABS_API_KEY`
- [ ] `SECRET_KEY` (random string)
- [ ] `RENDER=true`
- [ ] `PYTHON_VERSION=3.11.0`

### Optional Variables
- [ ] `RAZORPAY_KEY_ID` (if using payments)
- [ ] `RAZORPAY_KEY_SECRET` (if using payments)

---

## Post-Deployment Testing

### Basic Tests
- [ ] Homepage loads: `https://vidyatid.onrender.com`
- [ ] CSS and JavaScript load correctly
- [ ] Images and assets display
- [ ] No console errors (F12 → Console)

### Feature Tests
- [ ] **Chat Interface**: Ask a question, get AI response
- [ ] **Question Paper**: Generate custom paper with real questions
- [ ] **Snap & Solve**: Upload image, get solution
- [ ] **Voice Input**: Speak question, get audio response
- [ ] **Search**: Search for topics, get results
- [ ] **Progress Tracking**: View progress dashboard

### Database Tests
- [ ] Question paper shows REAL questions (not "Option A, Option B")
- [ ] Can select Physics, Chemistry, Math, Biology
- [ ] Generated papers have proper formatting
- [ ] Answer keys display correctly

### API Tests
- [ ] Gemini AI responds correctly
- [ ] Cloudflare embeddings work
- [ ] ElevenLabs voice synthesis works
- [ ] No rate limit errors

---

## Troubleshooting Checklist

### If Deployment Fails
- [ ] Check Render logs for errors
- [ ] Verify all environment variables are set
- [ ] Check `requirements.txt` is complete
- [ ] Verify Python version is 3.11
- [ ] Check build command is correct

### If Database Not Found
- [ ] Verify `guruai.db` is in Git: `git ls-files | grep .db`
- [ ] Check database file size: `ls -lh guruai.db`
- [ ] Verify `.gitignore` allows `.db` files
- [ ] Re-commit and push if needed

### If Paper Generation Shows Mock Data
- [ ] Check database has questions: `python check_questions_db.py`
- [ ] Verify database file is not empty
- [ ] Check Render logs for database errors
- [ ] Verify SQLite is working on Render

### If API Errors Occur
- [ ] Check environment variables in Render dashboard
- [ ] Verify API keys are valid and not expired
- [ ] Check API rate limits
- [ ] Review Render logs for specific errors

---

## Success Criteria

### Deployment Successful When:
- ✅ Service shows "Live" status in Render
- ✅ URL is accessible: `https://vidyatid.onrender.com`
- ✅ Homepage loads without errors
- ✅ Question paper generation works with real questions
- ✅ Chat interface responds with AI answers
- ✅ All features functional
- ✅ No critical errors in logs

---

## Quick Commands

### Check Database
```bash
# Verify database exists and has content
python check_questions_db.py
```

### Update Requirements
```bash
# Regenerate requirements.txt
pip freeze > requirements.txt
```

### Quick Deploy
```bash
# Windows
deploy_to_render.bat

# Mac/Linux
bash deploy_to_render.sh
```

### Manual Git Commands
```bash
# Add databases
git add guruai.db diagrams.db

# Commit
git commit -m "Add databases for deployment"

# Push
git push origin main
```

---

## Timeline

- **Preparation**: 5 minutes
- **Render Setup**: 3 minutes
- **Deployment**: 5-10 minutes
- **Testing**: 2 minutes
- **Total**: ~15-20 minutes

---

## Support Resources

- **Deployment Guide**: `RENDER_DEPLOYMENT_GUIDE.md`
- **Environment Variables**: `RENDER_ENV_VARS.txt`
- **Render Docs**: https://render.com/docs
- **Render Status**: https://status.render.com

---

**Last Updated**: December 7, 2024  
**Status**: Ready for Deployment ✅
