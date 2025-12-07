# Quick Start Testing Guide

## Current Status (Dec 7, 2025)

### ✅ Completed Tasks
1. **Gemini API Rate Limit Fix** - Using `gemini-2.5-flash` with 2 API keys rotation
2. **Multiple API Keys Setup** - Comma-separated format working with 2 keys
3. **Demo Video Documentation** - All feature docs created (VidyaTid branding)

### 🔄 Tasks Needing Verification

#### Task 4: Custom Question Paper Generation
**Status**: Code fixed, needs testing

**What was fixed**:
- Added chapter format conversion (`'Physics:1'` → extract subject)
- Added better error handling with fallback logic
- Added logging to track paper generation flow
- Fixed missing `import time` in fallback code

**How to test**:
1. Navigate to: http://localhost:5000/question-paper
2. Click "Custom Paper" button
3. Select subjects (Physics, Chemistry, etc.)
4. Select chapters (should auto-populate)
5. Adjust difficulty sliders
6. Set question count (try 10 first, since DB only has 12 questions)
7. Click "Generate Question Paper"
8. **Expected**: Real questions from database, NOT "Option A, Option B" placeholders
9. Check Flask console for logs starting with "📝", "✅", or "❌"

**Files modified**:
- `routes/paper_routes.py` - Chapter format conversion and error handling
- `services/question_generator.py` - Question retrieval logic

---

#### Task 5: Question Paper Page Buttons
**Status**: Code fixed, needs testing

**What was fixed**:
- Added `e.preventDefault()` and `e.stopPropagation()` to button handlers
- Added console.log debugging statements
- Added smooth scrolling to config sections

**How to test**:
1. Navigate to: http://localhost:5000/question-paper
2. Open browser console (F12 → Console tab)
3. Click each button and verify:
   - **Custom Paper** → Should show custom config section + log "Paper type selected: custom"
   - **Full-Length Test** → Should show full-length config + log "Paper type selected: full-length"
   - **Previous Papers** → Should show previous papers browser + log "Paper type selected: previous"
   - **AI Predictions** → Should show AI prediction config + log "Paper type selected: ai-prediction"
4. Check console for any JavaScript errors
5. Verify smooth scrolling to the config section

**Files modified**:
- `static/js/question-paper.js` - Event handlers and showConfigSection function
- `templates/question-paper.html` - Button data-type attributes verified

---

## Testing Checklist

### Question Paper Generation
- [ ] Custom Paper button works
- [ ] Full-Length Test button works
- [ ] Previous Papers button works
- [ ] AI Predictions button works
- [ ] Custom paper shows real questions (not placeholders)
- [ ] Generated paper has correct title
- [ ] Questions have proper options (A, B, C, D)
- [ ] Difficulty badges show correctly
- [ ] Subject badges show correctly

### Browser Console Checks
- [ ] No JavaScript errors
- [ ] Debug logs appear when clicking buttons
- [ ] Config sections show/hide correctly
- [ ] Smooth scrolling works

### Flask Console Checks
- [ ] Look for "📝 Extracted subjects from chapters: [...]"
- [ ] Look for "✅ Successfully generated paper with X questions"
- [ ] Look for "❌" errors if generation fails
- [ ] Check if falling back to mock data

---

## Known Issues

### Database Limitations
- **Only 12 questions in database** (4 Physics, 3 Chemistry, 3 Math, 2 Biology)
- Requesting 30+ questions will trigger fallback to mock data
- **Recommendation**: Test with 10 questions or less for real data

### Chapter Format Mismatch
- Frontend sends: `'Physics:1'`, `'Physics:2'`
- Database has: `'Mechanics'`, `'Thermodynamics'`
- **Current fix**: Extracts subject from chapter format, queries by subject only

---

## Next Steps

1. **Test both tasks** using the checklists above
2. **Report results**:
   - What works ✅
   - What doesn't work ❌
   - Any error messages from console or Flask logs
3. **If issues persist**:
   - Share browser console errors
   - Share Flask console logs
   - Share screenshots if helpful

---

## Quick Commands

### Restart Flask App
```bash
# Stop current process (Ctrl+C)
# Then restart:
python start_app.py
```

### Check Database Questions
```bash
python check_questions_db.py
```

### Test Paper Generation Directly
```bash
python test_paper_generation.py
```

---

## Current Configuration

### Gemini API Keys (2 keys active)
```
GEMINI_API_KEYS=AIzaSyBc7CqQyDnxg8qHeZ2pm4yQMBHsKzHYBRk,AIzaSyAQLfGMy19IDO2iNmz0aQA4B6nEmfo1ESw
```

### Database Status
- 12 real questions available
- Subjects: Physics (4), Chemistry (3), Mathematics (3), Biology (2)

### App Running
- URL: http://localhost:5000
- Video generation working ✅
- Question paper generation needs testing 🔄
