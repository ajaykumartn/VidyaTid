# 🚀 VidyaTid - One-Command Deployment to Cloudflare

## Quick Deploy (5 Minutes)

### Step 1: Install Wrangler CLI

```bash
npm install -g wrangler
```

### Step 2: Login to Cloudflare

```bash
wrangler login
```

This will open your browser to authenticate.

### Step 3: Get Your Account ID

```bash
wrangler whoami
```

Copy your Account ID.

### Step 4: Run Deployment Script

```bash
python cloudflare/deploy_all.py
```

This script will:
- ✅ Create D1 database
- ✅ Apply schema
- ✅ Migrate data
- ✅ Create R2 bucket
- ✅ Create KV namespace
- ✅ Deploy Workers
- ✅ Deploy Pages (frontend)
- ✅ Configure everything

### Step 5: Access Your App

After deployment completes, you'll get:
- **Frontend URL**: `https://vidyatid.pages.dev`
- **API URL**: `https://vidyatid-api.workers.dev`

## Manual Deployment (If Script Fails)

### Phase 1: Database (D1)

```bash
# Create database
wrangler d1 create vidyatid-db

# Copy the database_id from output
# Update cloudflare/wrangler.toml with the ID

# Apply schema
wrangler d1 execute vidyatid-db --file=cloudflare/d1_schema.sql

# Export and import data
python cloudflare/export_sqlite_data.py
python cloudflare/import_to_d1.py
wrangler d1 execute vidyatid-db --file=cloudflare/d1_import.sql
```

### Phase 2: Storage (R2)

```bash
# Create bucket
wrangler r2 bucket create vidyatid-storage

# Upload files (if needed)
# Files will be uploaded via Workers
```

### Phase 3: Cache (KV)

```bash
# Create namespace
wrangler kv:namespace create "vidyatid-cache"

# Copy the id from output
# Update cloudflare/wrangler.toml with the ID
```

### Phase 4: Workers (Backend API)

```bash
# Navigate to cloudflare directory
cd cloudflare

# Deploy worker
wrangler deploy

# Set secrets
wrangler secret put GEMINI_API_KEYS
wrangler secret put RAZORPAY_KEY_ID
wrangler secret put RAZORPAY_KEY_SECRET
```

### Phase 5: Pages (Frontend)

```bash
# Deploy frontend
wrangler pages deploy ../static --project-name=vidyatid

# Or connect to GitHub for auto-deploy
# 1. Push code to GitHub
# 2. Go to Cloudflare Dashboard → Pages
# 3. Connect repository
# 4. Deploy
```

## Environment Variables

Create `cloudflare/.dev.vars` for local testing:

```env
GEMINI_API_KEYS=your-key-1,your-key-2
CLOUDFLARE_ACCOUNT_ID=your-account-id
RAZORPAY_KEY_ID=your-razorpay-key
RAZORPAY_KEY_SECRET=your-razorpay-secret
```

## Testing Deployment

```bash
# Test D1
wrangler d1 execute vidyatid-db --command="SELECT COUNT(*) FROM users"

# Test Worker
curl https://vidyatid-api.workers.dev/api/health

# Test Frontend
curl https://vidyatid.pages.dev
```

## Custom Domain Setup

### For Workers (API):
1. Go to Workers dashboard
2. Select your worker
3. Click "Triggers" → "Custom Domains"
4. Add: `api.vidyatid.com`

### For Pages (Frontend):
1. Go to Pages dashboard
2. Select your project
3. Click "Custom domains"
4. Add: `vidyatid.com` or `www.vidyatid.com`

## Cost Estimate

### Free Tier (Perfect for Starting):
- Workers: 100,000 requests/day
- D1: 5M reads/day, 100k writes/day
- R2: 10 GB storage
- KV: 100,000 reads/day
- Pages: Unlimited
- Workers AI: 10,000 neurons/day

**Total: ₹0/month**

### When You Scale (1M users/month):
- Workers: ~₹4,000
- D1: ~₹800
- R2: ~₹400
- KV: ~₹2,000
- Workers AI: ~₹9,000

**Total: ~₹16,000/month** (vs ₹4,00,000+ on AWS/GCP)

## Troubleshooting

### Error: "Database not found"
```bash
wrangler d1 list
# Copy the correct database_id to wrangler.toml
```

### Error: "Namespace not found"
```bash
wrangler kv:namespace list
# Copy the correct id to wrangler.toml
```

### Error: "Deployment failed"
```bash
# Check logs
wrangler tail vidyatid-api

# Validate wrangler.toml
wrangler deploy --dry-run
```

## Support

- **Cloudflare Docs**: https://developers.cloudflare.com/
- **Discord**: https://discord.gg/cloudflaredev
- **Dashboard**: https://dash.cloudflare.com/

## Next Steps After Deployment

1. ✅ Test all features
2. ✅ Configure custom domain
3. ✅ Set up monitoring
4. ✅ Enable analytics
5. ✅ Add team members
6. ✅ Configure CI/CD

Your VidyaTid app is now live on Cloudflare's global network! 🎉
