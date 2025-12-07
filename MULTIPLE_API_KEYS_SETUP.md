# Multiple Gemini API Keys Setup Guide

## 🎯 Why Use Multiple API Keys?

Each Gemini API key has rate limits:
- **15 requests per minute**
- **1,500 requests per day**

With multiple keys, you get:
- **3 keys = 45 requests/min, 4,500 requests/day**
- **5 keys = 75 requests/min, 7,500 requests/day**
- **Automatic rotation** when one key hits limit
- **No downtime** - seamless failover

---

## 🔑 How to Get Multiple API Keys

### **Step 1: Get Your First Key**
1. Go to: https://makersuite.google.com/app/apikey
2. Sign in with Google account
3. Click "Create API Key"
4. Copy the key

### **Step 2: Get Additional Keys (Optional)**
You have two options:

#### **Option A: Use Same Google Account**
1. Go back to: https://makersuite.google.com/app/apikey
2. Click "Create API Key" again
3. You can create multiple keys per account
4. Each key has the same rate limits

#### **Option B: Use Different Google Accounts** (Recommended)
1. Sign out from current Google account
2. Sign in with a different Google account
3. Go to: https://makersuite.google.com/app/apikey
4. Create API key
5. Repeat for more accounts

**Tip:** Use family members' accounts or create new Google accounts

---

## ⚙️ Configuration

### **Method 1: Using .env File** (Recommended)

Edit your `.env` file:

```bash
# Multiple keys (comma-separated) - Preferred method
GEMINI_API_KEYS=AIzaSyBAOr96X2-xihvxDieNm6yMsHWM_dF6Iw8,AIzaSyC1234567890abcdefghijklmnopqrstuv,AIzaSyD9876543210zyxwvutsrqponmlkjihgfe

# Or use legacy single key (fallback)
GEMINI_API_KEY=AIzaSyBAOr96X2-xihvxDieNm6yMsHWM_dF6Iw8
```

**Note:** `GEMINI_API_KEYS` (plural) takes priority over `GEMINI_API_KEY` (singular)

### **Method 2: Environment Variables**

Set in your terminal:

**Windows (PowerShell):**
```powershell
$env:GEMINI_API_KEYS="your_key_1,your_key_2,your_key_3"
```

**Linux/Mac:**
```bash
export GEMINI_API_KEYS="your_key_1,your_key_2,your_key_3"
```

---

## 🔄 How Automatic Rotation Works

### **Smart Key Rotation Algorithm**

```
1. Start with GEMINI_API_KEY (primary)
2. Make API request
3. If rate limit hit (429 error):
   ├─> Mark current key as "failed"
   ├─> Rotate to next available key
   ├─> Retry request automatically
   └─> Continue until success or all keys exhausted
4. Failed keys cool down after 60 seconds
5. Automatically reuse cooled-down keys
```

### **Example Scenario**

You have 3 API keys:

```
Time 0:00 - Using Key #1
Time 0:04 - Key #1 hits rate limit (15 requests in 1 minute)
Time 0:04 - Auto-rotate to Key #2
Time 0:08 - Key #2 hits rate limit
Time 0:08 - Auto-rotate to Key #3
Time 1:00 - Key #1 cooldown complete, available again
```

---

## 📊 Monitoring Key Usage

### **Check Status in Logs**

When the app starts, you'll see:
```
✅ Gemini AI initialized with 3 API key(s) (gemini-2.5-flash)
```

When rotating:
```
⚠️ Rate limit hit on key #1
🔄 Rotated to API key #2/3
✅ Gemini generation successful with key #2
```

### **Check Status via API**

```python
from services.gemini_ai import get_gemini_ai

gemini = get_gemini_ai()
status = gemini.get_status()

print(f"Total keys: {status['total_keys']}")
print(f"Active keys: {status['active_keys']}")
print(f"Current key: {status['current_key']}")
print(f"Rate limit: {status['rate_limit']}")
```

---

## 🧪 Testing Multiple Keys

### **Test Script**

Create `test_multiple_keys.py`:

```python
import os
from dotenv import load_dotenv
from services.gemini_ai import GeminiAI

# Load environment
load_dotenv()

# Initialize Gemini
gemini = GeminiAI()

# Check status
status = gemini.get_status()
print(f"\n📊 Gemini Status:")
print(f"   Total keys: {status['total_keys']}")
print(f"   Active keys: {status['active_keys']}")
print(f"   Current key: #{status['current_key']}")
print(f"   Rate limit: {status['rate_limit']}\n")

# Test generation
for i in range(5):
    print(f"Test {i+1}:")
    result = gemini.generate(f"Say hello {i+1}", max_tokens=50)
    
    if result['success']:
        print(f"  ✅ Success: {result['text'][:50]}...")
    else:
        print(f"  ❌ Failed: {result['error']}")
    print()
```

Run:
```bash
python test_multiple_keys.py
```

---

## 🎯 Best Practices

### **1. Use Different Google Accounts**
- Better isolation
- Independent rate limits
- More reliable

### **2. Label Your Keys**
Keep track in a spreadsheet:
```
Key #1: personal@gmail.com - AIzaSyBAOr96...
Key #2: work@gmail.com - AIzaSyC1234...
Key #3: family@gmail.com - AIzaSyD9876...
```

### **3. Monitor Usage**
Check usage for each key:
- https://ai.dev/usage?tab=rate-limit

### **4. Rotate Keys Manually (Optional)**
If one key consistently fails, remove it:
```bash
# Comment out in .env
# GEMINI_API_KEY_2=bad_key_here
```

### **5. Keep Keys Secure**
- Never commit `.env` to git
- Use `.env.example` for templates
- Rotate keys if exposed

---

## 🔧 Troubleshooting

### **Issue: "No GEMINI_API_KEY found"**

**Solution:** Make sure at least one key is set:
```bash
# Preferred: Multiple keys
GEMINI_API_KEYS=your_key_1,your_key_2,your_key_3

# Or single key
GEMINI_API_KEY=your_key_here
```

### **Issue: "All API keys rate-limited"**

**Solutions:**
1. Wait 60 seconds for cooldown
2. Add more API keys
3. Enable Cloudflare AI fallback:
   ```bash
   USE_CLOUDFLARE_AI=true
   ```

### **Issue: Keys not rotating**

**Check:**
1. Keys are different (not duplicates)
2. Keys are valid (test individually)
3. Restart Flask app after adding keys

### **Issue: One key always fails**

**Solution:** Remove the bad key from comma-separated list:
```bash
# Before:
GEMINI_API_KEYS=good_key_1,bad_key,good_key_2

# After:
GEMINI_API_KEYS=good_key_1,good_key_2
```

---

## 📈 Performance Comparison

| Keys | Requests/Min | Requests/Day | Concurrent Users* |
|------|--------------|--------------|-------------------|
| 1    | 15           | 1,500        | ~7                |
| 2    | 30           | 3,000        | ~15               |
| 3    | 45           | 4,500        | ~22               |
| 5    | 75           | 7,500        | ~37               |
| 10   | 150          | 15,000       | ~75               |

*Assuming 2-second average response time

---

## 🚀 Production Recommendations

### **For Small Apps (< 100 users/day)**
- **2-3 keys** sufficient
- Cost: Free
- Setup time: 10 minutes

### **For Medium Apps (100-1000 users/day)**
- **5-10 keys** recommended
- Cost: Free
- Setup time: 30 minutes

### **For Large Apps (> 1000 users/day)**
- **10+ keys** or paid tier
- Consider Gemini Pro (paid)
- Or use Cloudflare Workers AI

---

## 💡 Advanced: Key Pool Management

For very high traffic, implement a key pool:

```python
# services/gemini_key_pool.py
import os
from typing import List
import time

class GeminiKeyPool:
    def __init__(self):
        self.keys = self._load_all_keys()
        self.key_stats = {
            key: {
                'requests': 0,
                'last_reset': time.time(),
                'failed': False
            }
            for key in self.keys
        }
    
    def get_best_key(self) -> str:
        """Get key with lowest usage"""
        current_time = time.time()
        
        # Reset counters every minute
        for key, stats in self.key_stats.items():
            if current_time - stats['last_reset'] > 60:
                stats['requests'] = 0
                stats['last_reset'] = current_time
                stats['failed'] = False
        
        # Find key with lowest usage
        available_keys = [
            (key, stats) 
            for key, stats in self.key_stats.items() 
            if not stats['failed'] and stats['requests'] < 15
        ]
        
        if available_keys:
            best_key = min(available_keys, key=lambda x: x[1]['requests'])[0]
            self.key_stats[best_key]['requests'] += 1
            return best_key
        
        return None  # All keys exhausted
```

---

## 📞 Support

If you need help:
1. Check logs for error messages
2. Test keys individually
3. Verify rate limits: https://ai.dev/usage
4. Contact: dev@vidyatid.com

---

**Last Updated:** December 7, 2024  
**Status:** Production Ready ✅
