# VidyaTid - Render Deployment Guide

## Complete Step-by-Step Deployment (10 Minutes)

---

## Prerequisites

- ✅ GitHub account
- ✅ Render account (free - sign up at render.com)
- ✅ Your environment variables ready (.env file)

---

## Step 1: Prepare Your Repository (2 minutes)

### 1.1 Check Database Files Exist
```bash
# Verify databases are present
ls -lh guruai.db diagrams.db

# Should show:
# guruai.db (your questions database)
# diagrams.db (your diagrams database)
```

### 1.2 Add Databases to Git
```bash
# Add database files
git add guruai.db diagrams.db

# Add updated .gitignore
git add .gitignore

# Add render.yaml configuration
git add render.yaml

# Commit changes
git commit -m "Add databases and Render configuration for deployment"

# Push to GitHub
git push origin main
```

**✅ Checkpoint:** Your databases are now in Git and will be included in deployment!

---

## Step 2: Create Render Account (1 minute)

1. Go to **https://render.com**
2. Click **"Get Started"**
3. Sign up with **GitHub** (easiest option)
4. Authorize Render to access your repositories

---

## Step 3: Create Web Service (3 minutes)

### 3.1 Create New Web Service
1. Click **"New +"** button (top right)
2. Select **"Web Service"**
3. Click **"Connect a repository"**
4. Find and select your **VidyaTid repository**
5. Click **"Connect"**

### 3.2 Configure Service
Fill in the following settings:

**Basic Settings:**
- **Name**: `vidyatid` (or your preferred name)
- **Region**: `Singapore` (closest to India)
- **Branch**: `main` (or your default branch)
- **Root Directory**: Leave blank
- **Environment**: `Python 3`
- **Build Command**: `pip install -r requirements.txt`
- **Start Command**: `python start_app.py`

**Plan:**
- Select **"Free"** plan
- 512 MB RAM
- Shared CPU
- Automatic deploys enabled

**✅ Checkpoint:** Service configured, but DON'T click "Create Web Service" yet!

---

## Step 4: Add Environment Variables (3 minutes)

### 4.1 Scroll Down to "Environment Variables"

Click **"Add Environment Variable"** and add each of these:

#### Required Variables:

```bash
# 1. Gemini API Keys (REQUIRED)
Key: GEMINI_API_KEYS
Value: AIzaSyBc7CqQyDnxg8qHeZ2pm4yQMBHsKzHYBRk,AIzaSyAQLfGMy19IDO2iNmz0aQA4B6nEmfo1ESw

# 2. Use Gemini Flag
Key: USE_GEMINI
Value: true

# 3. Cloudflare Account ID
Key: CLOUDFLARE_ACCOUNT_ID
Value: your_cloudflare_account_id

# 4. Cloudflare API Token
Key: CLOUDFLARE_API_TOKEN
Value: your_cloudflare_api_token

# 5. Use Cloudflare AI Flag
Key: USE_CLOUDFLARE_AI
Value: true

# 6. ElevenLabs API Key
Key: ELEVENLABS_API_KEY
Value: your_elevenlabs_api_key

# 7. Secret Key (generate random string)
Key: SECRET_KEY
Value: your-super-secret-key-change-this-in-production-12345

# 8. Render Flag (for config detection)
Key: RENDER
Value: true

# 9. Python Version
Key: PYTHON_VERSION
Value: 3.11.0
```

#### Optional Variables (for Razorpay payments):

```bash
# Razorpay Key ID
Key: RAZORPAY_KEY_ID
Value: your_razorpay_key_id

# Razorpay Key Secret
Key: RAZORPAY_KEY_SECRET
Value: your_razorpay_key_secret
```

### 4.2 Copy from Your .env File

**Quick Method:**
1. Open your `.env` file
2. Copy each value
3. Paste into Render's environment variables
4. Make sure to use the exact same key names

**✅ Checkpoint:** All environment variables added!

---

## Step 5: Deploy! (1 minute)

1. Scroll to the bottom
2. Click **"Create Web Service"**
3. Wait for deployment (5-10 minutes)

### What Happens During Deployment:

```
[1/6] Cloning repository... ✅
[2/6] Installing Python 3.11... ✅
[3/6] Installing dependencies... ✅
[4/6] Including guruai.db and diagrams.db... ✅
[5/6] Starting application... ✅
[6/6] Service live! ✅
```

**✅ Checkpoint:** Deployment in progress!

---

## Step 6: Get Your URL (Immediate)

Once deployment completes, you'll see:

```
Your service is live at:
https://vidyatid.onrender.com
```

**Copy this URL!** This is your live application.

---

## Step 7: Test Your Deployment (2 minutes)

### 7.1 Test Homepage
1. Visit: `https://vidyatid.onrender.com`
2. Should see VidyaTid homepage
3. Check if all assets load (CSS, JS, images)

### 7.2 Test Question Paper Generation
1. Go to: `https://vidyatid.onrender.com/question-paper`
2. Click **"Custom Paper"**
3. Select **Physics** subject
4. Select chapters
5. Set question count to **10**
6. Click **"Generate Question Paper"**
7. **Verify:** Should show REAL questions, NOT "Option A, Option B"

### 7.3 Test Chat Interface
1. Go to: `https://vidyatid.onrender.com/`
2. Type: "What is Newton's second law?"
3. Click send
4. Should get AI response with explanation

### 7.4 Test Other Features
- ✅ Snap & Solve (upload image)
- ✅ Voice input/output
- ✅ Search functionality
- ✅ Progress tracking

**✅ Checkpoint:** Everything works!

---

## Troubleshooting

### Issue 1: "Application failed to start"

**Check Logs:**
1. In Render dashboard, click **"Logs"** tab
2. Look for error messages
3. Common issues:
   - Missing environment variable
   - Wrong Python version
   - Dependency installation failed

**Solution:**
```bash
# Check requirements.txt is complete
pip freeze > requirements.txt
git add requirements.txt
git commit -m "Update requirements"
git push
# Render will auto-redeploy
```

---

### Issue 2: "Database not found"

**Check:**
1. Verify `guruai.db` is in Git:
   ```bash
   git ls-files | grep .db
   # Should show: guruai.db and diagrams.db
   ```

2. If not found:
   ```bash
   git add guruai.db diagrams.db
   git commit -m "Add databases"
   git push
   ```

---

### Issue 3: "Paper generation shows mock data"

**Check:**
1. Database file size:
   ```bash
   ls -lh guruai.db
   # Should be > 0 bytes
   ```

2. Check database has questions:
   ```bash
   python check_questions_db.py
   # Should show 12 questions
   ```

3. If database is empty:
   ```bash
   python init_db.py
   # Re-add to git
   git add guruai.db
   git commit -m "Update database with questions"
   git push
   ```

---

### Issue 4: "Gemini API errors"

**Check:**
1. Environment variables are set correctly
2. API keys are valid
3. Check logs for specific error

**Solution:**
1. Go to Render dashboard
2. Click **"Environment"** tab
3. Verify `GEMINI_API_KEYS` is set
4. Click **"Manual Deploy"** → **"Clear build cache & deploy"**

---

### Issue 5: "Service is slow or times out"

**Reason:** Free tier sleeps after 15 minutes of inactivity

**Solutions:**
1. **Accept it** - First request after sleep takes 30-60 seconds
2. **Keep alive** - Use cron job to ping every 10 minutes:
   ```bash
   # Use cron-job.org or similar
   # Ping: https://vidyatid.onrender.com/api/health
   ```
3. **Upgrade** - Paid plan ($7/month) never sleeps

---

## Post-Deployment Checklist

- [ ] Homepage loads correctly
- [ ] Question paper generation works with real questions
- [ ] Chat interface responds
- [ ] Image upload works
- [ ] Voice features work
- [ ] Search functionality works
- [ ] All CSS/JS assets load
- [ ] No console errors (F12 → Console)
- [ ] Database persists across restarts

---

## Monitoring Your App

### View Logs
1. Render Dashboard → Your Service
2. Click **"Logs"** tab
3. See real-time application logs

### View Metrics
1. Click **"Metrics"** tab
2. See:
   - CPU usage
   - Memory usage
   - Request count
   - Response times

### Set Up Alerts
1. Click **"Settings"** tab
2. Scroll to **"Notifications"**
3. Add email for deployment notifications

---

## Updating Your App

### Automatic Deploys (Recommended)
```bash
# Make changes locally
git add .
git commit -m "Update feature X"
git push

# Render automatically detects push and redeploys
# Takes 3-5 minutes
```

### Manual Deploy
1. Render Dashboard → Your Service
2. Click **"Manual Deploy"**
3. Select branch
4. Click **"Deploy"**

---

## Custom Domain (Optional)

### Add Your Own Domain

1. Buy domain (e.g., vidyatid.com)
2. In Render Dashboard:
   - Click **"Settings"** tab
   - Scroll to **"Custom Domains"**
   - Click **"Add Custom Domain"**
   - Enter: `vidyatid.com`
3. Add DNS records at your domain registrar:
   ```
   Type: CNAME
   Name: www
   Value: vidyatid.onrender.com
   ```
4. Wait for DNS propagation (5-60 minutes)
5. Free SSL certificate automatically provisioned

---

## Costs

### Free Tier Includes:
- ✅ 512 MB RAM
- ✅ Shared CPU
- ✅ 750 hours/month (enough for 24/7)
- ✅ Automatic HTTPS
- ✅ Automatic deploys
- ✅ Custom domains
- ⚠️ Sleeps after 15 min inactivity
- ⚠️ Slower cold starts

### Paid Tier ($7/month):
- ✅ 2 GB RAM
- ✅ Dedicated CPU
- ✅ Never sleeps
- ✅ Faster performance
- ✅ Priority support

---

## Next Steps

### After Successful Deployment:

1. **Share Your URL**
   - Demo video: Use `https://vidyatid.onrender.com`
   - Presentations: Show live app
   - Testing: Share with friends/testers

2. **Monitor Performance**
   - Check logs daily
   - Monitor error rates
   - Track response times

3. **Optimize Later**
   - Move to PostgreSQL for permanent storage
   - Add Cloudflare Pages for faster frontend
   - Upgrade to paid tier if needed

4. **Add More Questions**
   - Update `guruai.db` locally
   - Commit and push
   - Render auto-deploys with new questions

---

## Support

### Render Support:
- Docs: https://render.com/docs
- Community: https://community.render.com
- Status: https://status.render.com

### VidyaTid Issues:
- Check logs first
- Verify environment variables
- Test locally before deploying
- Check database file is in Git

---

## Success! 🎉

Your VidyaTid app is now live at:
**https://vidyatid.onrender.com**

- ✅ Question paper generation works
- ✅ All 12 questions available
- ✅ Database included in deployment
- ✅ Ready for demo video
- ✅ Zero code changes needed

---

**Deployment Time:** ~10 minutes  
**Cost:** $0 (Free tier)  
**Maintenance:** Automatic updates on git push  
**Uptime:** 24/7 (with 15-min sleep on inactivity)

---

**Last Updated:** December 7, 2024  
**Version:** 1.0  
**Status:** Production Ready ✅
