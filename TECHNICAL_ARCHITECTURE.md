# VidyaTid - Technical Architecture & Flow Documentation

## 📋 Table of Contents
1. [System Overview](#system-overview)
2. [Technology Stack](#technology-stack)
3. [Architecture Diagram](#architecture-diagram)
4. [Feature-wise Technical Flow](#feature-wise-technical-flow)
5. [Database Schema](#database-schema)
6. [API Endpoints](#api-endpoints)
7. [Deployment Architecture](#deployment-architecture)

---

## 🎯 System Overview

**VidyaTid** is an AI-powered educational platform for JEE & NEET preparation built with a hybrid architecture:
- **Cloud AI** for intelligent processing (Google Gemini, Cloudflare Workers AI)
- **Local Storage** for fast data access (ChromaDB, SQLite)
- **Modern Web Stack** (Flask, JavaScript, HTML/CSS)

### Key Characteristics:
- Hybrid cloud-local architecture
- RAG (Retrieval Augmented Generation) system
- Multi-AI service integration
- Real-time processing
- Scalable and modular design

---

## 🛠️ Technology Stack

### **Backend Framework**
```
Flask (Python 3.10+)
├── Flask-CORS (Cross-origin support)
├── Flask-SQLAlchemy (ORM)
└── Werkzeug (WSGI utilities)
```

### **AI & Machine Learning**

```
Primary AI Services:
├── Google Gemini AI (gemini-2.5-flash)
│   ├── Natural language understanding
│   ├── Problem solving
│   ├── Question generation
│   ├── Script generation
│   └── Voice transcription
│
├── Cloudflare Workers AI
│   ├── Text embeddings (@cf/baai/bge-base-en-v1.5)
│   ├── Fallback processing
│   └── Fast inference
│
└── ElevenLabs API
    ├── Text-to-speech
    ├── Voice narration
    └── Audio generation

Supporting ML:
├── Tesseract OCR (Image text extraction)
├── Sentence Transformers (Local embeddings fallback)
└── PIL/Pillow (Image processing)
```

### **Databases & Storage**
```
Vector Database:
└── ChromaDB
    ├── NCERT content embeddings
    ├── Semantic search
    └── 768-dimensional vectors

Relational Database:
└── SQLite
    ├── User accounts & authentication
    ├── Questions database (10,000+ questions)
    ├── Progress tracking
    ├── Subscription management
    └── Payment records

File Storage:
├── Local filesystem
│   ├── NCERT PDFs
│   ├── Diagrams (PNG/JPG)
│   ├── Generated videos (MP4)
│   └── Audio files (MP3)
```

### **Frontend Technologies**
```
├── HTML5 (Semantic markup)
├── CSS3 (Modern styling, animations)
├── JavaScript (ES6+)
│   ├── Fetch API (AJAX requests)
│   ├── Web Audio API (Voice recording)
│   └── Canvas API (Diagram rendering)
└── No frontend framework (Vanilla JS for performance)
```

### **Payment & Communication**
```
├── Razorpay (Payment gateway)
├── SendGrid (Email service)
└── Session management (Flask sessions)
```

### **Video Generation Stack**
```
├── MoviePy (Video compilation)
├── PIL/Pillow (Frame generation)
├── Google Gemini (Script generation)
├── ElevenLabs (Audio narration)
└── FFmpeg (Video encoding)
```

---

## 🏗️ Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                     CLIENT LAYER                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Browser    │  │   Mobile     │  │   Desktop    │      │
│  │   (HTML/CSS/ │  │   (Future)   │  │   (Future)   │      │
│  │   JavaScript)│  │              │  │              │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                          ↓ HTTPS
┌─────────────────────────────────────────────────────────────┐
│                   WEB SERVER LAYER                           │
│  ┌──────────────────────────────────────────────────────┐   │
│  │              Flask Application                        │   │
│  │  ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐       │   │
│  │  │ Routes │ │ Auth   │ │ Error  │ │ CORS   │       │   │
│  │  │        │ │ Middleware│ Handler│ │        │       │   │
│  │  └────────┘ └────────┘ └────────┘ └────────┘       │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘

                          ↓
┌─────────────────────────────────────────────────────────────┐
│                   SERVICE LAYER                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │ Query Handler│  │ Problem      │  │ Video        │      │
│  │              │  │ Solver       │  │ Generator    │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │ RAG System   │  │ Image        │  │ Voice        │      │
│  │              │  │ Processor    │  │ Service      │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │ Question     │  │ Progress     │  │ Payment      │      │
│  │ Predictor    │  │ Tracker      │  │ Service      │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│                   AI LAYER (Cloud)                           │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │ Google       │  │ Cloudflare   │  │ ElevenLabs   │      │
│  │ Gemini AI    │  │ Workers AI   │  │ API          │      │
│  │ (Primary)    │  │ (Embeddings) │  │ (Voice)      │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│                   DATA LAYER (Local)                         │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │ ChromaDB     │  │ SQLite       │  │ File System  │      │
│  │ (Vectors)    │  │ (Relational) │  │ (Media)      │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

---

## 🔄 Feature-wise Technical Flow

### **1. AI Chat Interface (Query System)**

**User Flow:**
```
User types question → Frontend sends to /api/ask → Backend processes → AI responds
```

**Technical Flow:**

```
1. User Input
   └─> Frontend (index.html)
       └─> JavaScript captures query

2. API Request
   └─> POST /api/ask
       └─> JSON: { "query": "Explain photoelectric effect" }

3. Query Handler Service
   └─> Receives query
   └─> Detects query type (concept/problem/quiz)
   └─> Routes to appropriate handler

4. RAG System (Retrieval)
   └─> Generate query embedding
       ├─> Cloudflare AI (primary)
       └─> Local model (fallback)
   └─> Search ChromaDB vector store
   └─> Retrieve top 3 relevant NCERT chunks
   └─> Extract metadata (subject, chapter, page)

5. Context Building
   └─> Combine retrieved NCERT content
   └─> Add relevant diagrams
   └─> Build prompt with context

6. AI Generation
   └─> Send to Google Gemini AI
       ├─> Model: gemini-2.5-flash
       ├─> Temperature: 0.7
       └─> Max tokens: 512
   └─> Receive structured response

7. Post-processing
   └─> Format response (markdown)
   └─> Add diagram references
   └─> Generate follow-up quiz questions
   └─> Calculate relevance score

8. Response
   └─> JSON response to frontend
   └─> Display formatted answer
   └─> Show diagrams
   └─> Present quiz questions
```

**Tech Stack Used:**
- Flask (routing)
- Google Gemini AI (generation)
- Cloudflare AI (embeddings)
- ChromaDB (vector search)
- SQLite (logging)

---

### **2. Snap & Solve (Image Problem Solving)**

**User Flow:**
```
User uploads image → OCR extracts text → AI solves → Step-by-step solution
```

**Technical Flow:**
```
1. Image Upload
   └─> Frontend file input
   └─> JavaScript FileReader API
   └─> Base64 encoding

2. API Request
   └─> POST /api/solve-problem
   └─> Multipart form data with image

3. Image Preprocessing
   └─> PIL/Pillow loads image
   └─> Resize if needed (max 4MB)
   └─> Convert to grayscale
   └─> Enhance contrast
   └─> Denoise

4. OCR Processing
   └─> Tesseract OCR
       ├─> Language: English
       ├─> PSM mode: Auto
       └─> Extract text + confidence
   └─> Clean extracted text
   └─> Identify mathematical symbols

5. Context Retrieval
   └─> Detect subject from text
   └─> Search NCERT content (RAG)
   └─> Get relevant formulas/concepts

6. Problem Solving
   └─> Google Gemini AI
       ├─> Prompt: "Solve step-by-step"
       ├─> Include OCR text
       ├─> Include NCERT context
       └─> Request structured solution
   └─> Parse response

7. Solution Formatting
   └─> Extract steps
   └─> Format equations (LaTeX)
   └─> Add diagrams if needed
   └─> Include NCERT reference

8. Response
   └─> JSON with solution
   └─> Display step-by-step
   └─> Show original image
   └─> Provide explanation
```

**Tech Stack Used:**
- Tesseract OCR (text extraction)
- PIL/Pillow (image processing)
- Google Gemini AI (solving)
- RAG System (context)
- Flask (API)

---

### **3. Voice Input & Output**

**User Flow:**
```
User speaks → Audio recorded → Transcribed → AI responds → Text-to-speech
```

**Technical Flow:**
```
1. Voice Input (Recording)
   └─> Frontend Web Audio API
   └─> MediaRecorder captures audio
   └─> Format: WebM/WAV
   └─> Stop recording on silence

2. Audio Upload
   └─> POST /api/voice/transcribe
   └─> Multipart form data
   └─> Audio blob

3. Transcription
   └─> Google Gemini AI
       ├─> Audio API
       ├─> Language: English/Hindi/Hinglish
       └─> Return text
   └─> Clean transcription
   └─> Detect language

4. Query Processing
   └─> Same as Chat Interface
   └─> Process transcribed text
   └─> Get AI response

5. Text-to-Speech
   └─> ElevenLabs API
       ├─> Voice: Professional narrator
       ├─> Language: Match input
       ├─> Speed: 1.0x
       └─> Generate MP3
   └─> Stream audio

6. Audio Playback
   └─> Frontend Audio element
   └─> Play generated speech
   └─> Show transcript
```

**Tech Stack Used:**
- Web Audio API (recording)
- Google Gemini AI (transcription)
- ElevenLabs (TTS)
- Flask (streaming)

---

### **4. Interactive Diagrams**

**User Flow:**
```
User searches diagram → System retrieves → Display with labels → Click for details
```

**Technical Flow:**
```
1. Diagram Search
   └─> GET /api/diagrams/search?query=heart
   └─> Search query

2. Database Query
   └─> SQLite diagrams table
   └─> Full-text search
   └─> Filter by subject/chapter
   └─> Get metadata

3. Diagram Retrieval
   └─> Load image from filesystem
   └─> Path: diagrams/{subject}/{filename}
   └─> Get labeled parts JSON

4. Response
   └─> JSON with:
       ├─> Image URL
       ├─> Labeled parts
       ├─> NCERT reference
       └─> Description

5. Frontend Display
   └─> Canvas rendering
   └─> Clickable hotspots
   └─> Tooltip on hover
   └─> Zoom/pan controls
```

**Tech Stack Used:**
- SQLite (metadata)
- File system (images)
- Canvas API (rendering)
- Flask (serving)

---

### **5. Smart Search**

**User Flow:**
```
User searches → Semantic search → Results ranked → Display with context
```

**Technical Flow:**
```
1. Search Query
   └─> GET /api/search?q=thermodynamics
   └─> Query string

2. Embedding Generation
   └─> Cloudflare AI
       ├─> Model: BGE-base-en-v1.5
       ├─> Generate 768d vector
       └─> Normalize

3. Vector Search
   └─> ChromaDB query
       ├─> Cosine similarity
       ├─> Top K=10 results
       └─> Relevance threshold: 0.7

4. Result Processing
   └─> Extract metadata
       ├─> Subject
       ├─> Class (11/12)
       ├─> Chapter
       ├─> Page number
       └─> Content snippet
   └─> Rank by relevance
   └─> Group by chapter

5. Response
   └─> JSON array of results
   └─> Each with:
       ├─> Content preview
       ├─> Relevance score
       ├─> Source reference
       └─> Related diagrams

6. Frontend Display
   └─> Paginated results
   └─> Highlight query terms
   └─> Filter options
   └─> Sort by relevance/date
```

**Tech Stack Used:**
- Cloudflare AI (embeddings)
- ChromaDB (vector search)
- Flask (API)
- JavaScript (UI)

---

### **6. Previous Year Papers**

**User Flow:**
```
User selects filters → Query database → Display questions → Show solutions
```

**Technical Flow:**
```
1. Filter Selection
   └─> Frontend form
       ├─> Exam: JEE/NEET
       ├─> Subject: Physics/Chemistry/etc
       ├─> Year: 2004-2024
       ├─> Difficulty: Easy/Medium/Hard
       └─> Chapter (optional)

2. API Request
   └─> GET /api/papers/questions
   └─> Query parameters

3. Database Query
   └─> SQLite questions table
   └─> WHERE clauses for filters
   └─> ORDER BY year DESC
   └─> LIMIT 50 OFFSET page*50

4. Question Retrieval
   └─> Fetch questions with:
       ├─> Question text
       ├─> Options (if MCQ)
       ├─> Correct answer
       ├─> Solution
       ├─> NCERT reference
       └─> Marks

5. Response
   └─> JSON array of questions
   └─> Pagination metadata
   └─> Statistics (total count)

6. Frontend Display
   └─> Question cards
   └─> Show/hide solution
   └─> Bookmark feature
   └─> Practice mode
```

**Tech Stack Used:**
- SQLite (questions DB)
- Flask-SQLAlchemy (ORM)
- Flask (API)
- JavaScript (UI)

---

### **7. AI Question Predictions**

**User Flow:**
```
User selects subject/year → AI analyzes patterns → Generate predicted paper
```

**Technical Flow:**
```
1. Prediction Request
   └─> POST /api/prediction/predict-paper
   └─> JSON: { "subject": "Physics", "year": 2026 }

2. Historical Analysis
   └─> Query SQLite
       ├─> Get last 20 years questions
       ├─> Filter by subject
       └─> Group by chapter/topic

3. Pattern Analysis
   └─> Calculate frequencies
       ├─> Chapter appearance rate
       ├─> Topic repetition
       ├─> Difficulty distribution
       └─> Trend analysis (increasing/decreasing)

4. Probability Calculation
   └─> For each chapter:
       ├─> Frequency score (0-100)
       ├─> Recency weight
       ├─> Trend factor
       └─> Final probability

5. Question Selection (if USE_GEMINI=true)
   └─> Google Gemini AI
       ├─> Prompt: Generate NEET-style questions
       ├─> Include high-probability topics
       ├─> NCERT context from RAG
       └─> Structured JSON output
   └─> Parse AI response
   └─> Validate question format

6. Fallback (if Gemini unavailable)
   └─> Select from database
       ├─> Filter by high-probability chapters
       ├─> Random sampling
       └─> Ensure variety

7. Paper Assembly
   └─> Combine questions
   └─> Add confidence scores
   └─> Include chapter analysis
   └─> Generate metadata

8. Response
   └─> JSON with:
       ├─> Predicted questions
       ├─> Confidence scores
       ├─> Chapter probabilities
       └─> Insights
```

**Tech Stack Used:**
- SQLite (historical data)
- Google Gemini AI (generation)
- RAG System (NCERT context)
- Python (analysis algorithms)
- Flask (API)

---

### **8. Video Explainer Generator** ⭐

**User Flow:**
```
User enters topic → AI generates script → Creates audio → Renders video → Download
```

**Technical Flow:**
```
1. Video Request
   └─> POST /video/api/generate
   └─> JSON: { "topic": "Thermodynamics", "subject": "Physics" }

2. Script Generation
   └─> Google Gemini AI
       ├─> Model: gemini-2.5-flash
       ├─> Prompt: Educational video script
       ├─> Structure: Intro + 4 scenes + Summary
       ├─> Include narration text
       └─> Visual cues for each scene
   └─> Parse JSON response
   └─> Validate scene structure

3. Audio Generation (for each scene)
   └─> ElevenLabs API
       ├─> Voice: Professional narrator
       ├─> Text: Scene narration
       ├─> Format: MP3
       └─> Quality: High
   └─> Save: audio/scene_01.mp3
   └─> Get duration (for timing)

4. Thumbnail Creation
   └─> PIL/Pillow
       ├─> Canvas: 1920x1080
       ├─> Background: Subject color
       ├─> Title text
       ├─> Subject icon
       └─> Save: thumb_{timestamp}.png

5. Video Frame Generation
   └─> For each scene:
       ├─> Calculate frame count (duration * 30 FPS)
       ├─> Create intro frame
       ├─> Generate explanation frames
       │   ├─> Animated character
       │   ├─> Topic visualization
       │   ├─> Text overlay
       │   └─> Progress indicator
       ├─> Create transition frames
       └─> Generate summary frame

6. Character Animation
   └─> Draw character with:
       ├─> Body (stick figure style)
       ├─> Gestures (pointing, explaining)
       ├─> Expressions (smile, thinking)
       └─> Lip sync (basic)

7. Topic Visualization
   └─> Based on subject:
       ├─> Physics: Circuits, waves, forces
       ├─> Chemistry: Molecules, reactions
       ├─> Biology: DNA, cells, organs
       └─> Math: Graphs, equations

8. Video Compilation
   └─> MoviePy
       ├─> Load all frames
       ├─> Add audio tracks
       ├─> Set FPS: 30
       ├─> Codec: H.264
       ├─> Resolution: 1920x1080
       └─> Output: explainer_{topic}_{timestamp}.mp4

9. Fallback (if MoviePy unavailable)
   └─> Save frames as PNG sequence
   └─> Provide FFmpeg command
   └─> User can compile manually

10. Response
    └─> JSON with:
        ├─> Video path
        ├─> Duration
        ├─> Thumbnail
        └─> Download URL
```

**Tech Stack Used:**
- Google Gemini AI (script)
- ElevenLabs (narration)
- PIL/Pillow (frames)
- MoviePy (compilation)
- FFmpeg (encoding)
- Flask (API)

---

### **9. Custom Question Paper Generation**

**User Flow:**
```
User selects chapters/difficulty → System generates paper → Download PDF
```

**Technical Flow:**
```
1. Paper Configuration
   └─> Frontend form
       ├─> Subjects: Multi-select
       ├─> Chapters: Multi-select
       ├─> Difficulty: Easy/Medium/Hard/Mixed
       ├─> Question count: 10-100
       └─> Include solutions: Yes/No

2. API Request
   └─> POST /api/papers/generate
   └─> JSON with configuration

3. Question Selection
   └─> SQLite query
       ├─> Filter by chapters
       ├─> Filter by difficulty
       ├─> Random sampling
       └─> Ensure variety (MCQ, Numerical, etc)

4. Paper Assembly
   └─> Group by subject
   └─> Order by difficulty
   └─> Add section headers
   └─> Number questions
   └─> Calculate total marks

5. PDF Generation
   └─> ReportLab/WeasyPrint
       ├─> Header: Title, Date
       ├─> Instructions
       ├─> Questions section
       ├─> Solutions section (if enabled)
       └─> Footer: Page numbers

6. Save & Response
   └─> Save PDF to filesystem
   └─> Generate download URL
   └─> Return metadata

7. Frontend Download
   └─> Trigger download
   └─> Show preview option
```

**Tech Stack Used:**
- SQLite (questions)
- ReportLab (PDF)
- Flask (API)
- Python (logic)

---

### **10. Progress Tracking**

**User Flow:**
```
User studies → System logs activity → Analytics calculated → Dashboard display
```

**Technical Flow:**
```
1. Activity Logging
   └─> Every user action:
       ├─> Question attempted
       ├─> Topic studied
       ├─> Time spent
       ├─> Accuracy
       └─> Timestamp

2. Database Insert
   └─> SQLite progress table
       ├─> user_id
       ├─> activity_type
       ├─> subject
       ├─> chapter
       ├─> correct/incorrect
       └─> timestamp

3. Analytics Calculation
   └─> Aggregate queries:
       ├─> Total questions attempted
       ├─> Subject-wise accuracy
       ├─> Chapter-wise performance
       ├─> Time spent per subject
       ├─> Weak areas (accuracy < 60%)
       └─> Improvement trends

4. Dashboard API
   └─> GET /api/progress/dashboard
   └─> Calculate metrics
   └─> Generate charts data

5. Response
   └─> JSON with:
       ├─> Overall statistics
       ├─> Subject breakdown
       ├─> Weak areas
       ├─> Recommendations
       └─> Chart data

6. Frontend Display
   └─> Charts (Chart.js)
   └─> Progress bars
   └─> Heatmaps
   └─> Recommendations
```

**Tech Stack Used:**
- SQLite (logging)
- Python (analytics)
- Flask (API)
- Chart.js (visualization)

---

### **11. Subscription & Payment System**

**User Flow:**
```
User selects plan → Razorpay checkout → Payment → Subscription activated
```

**Technical Flow:**
```
1. Plan Selection
   └─> Frontend pricing page
       ├─> Free tier
       ├─> Premium (₹499/month)
       └─> Pro (₹999/month)

2. Checkout Initiation
   └─> POST /api/subscription/create-order
   └─> JSON: { "plan": "premium" }

3. Razorpay Order Creation
   └─> Backend calls Razorpay API
       ├─> Amount: Plan price
       ├─> Currency: INR
       ├─> Receipt: order_id
       └─> Get order_id

4. Frontend Checkout
   └─> Razorpay.js SDK
       ├─> Display payment modal
       ├─> Accept payment methods
       └─> Handle payment

5. Payment Verification
   └─> Razorpay webhook
   └─> POST /api/payment/webhook
   └─> Verify signature
   └─> Validate payment

6. Subscription Activation
   └─> Update SQLite
       ├─> user_subscriptions table
       ├─> Set tier
       ├─> Set start_date
       ├─> Set end_date
       └─> Set status: active

7. Email Confirmation
   └─> SendGrid API
       ├─> Template: subscription_success
       ├─> Include invoice
       └─> Send to user email

8. Feature Gating
   └─> Middleware checks
       ├─> User tier
       ├─> Feature access
       └─> Usage limits

9. Response
   └─> Redirect to dashboard
   └─> Show success message
   └─> Enable premium features
```

**Tech Stack Used:**
- Razorpay (payments)
- SendGrid (emails)
- SQLite (subscriptions)
- Flask (webhooks)
- Middleware (gating)

---

## 📊 Database Schema

### **Users Table**
```sql
CREATE TABLE users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    phone VARCHAR(20),
    target_exam VARCHAR(20), -- JEE/NEET
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP,
    is_active BOOLEAN DEFAULT 1
);
```

### **Questions Table**
```sql
CREATE TABLE questions (
    question_id VARCHAR(36) PRIMARY KEY,
    source VARCHAR(100), -- "JEE Main 2023"
    year INTEGER,
    exam VARCHAR(50), -- JEE Main/Advanced/NEET
    subject VARCHAR(50),
    chapter VARCHAR(100),
    topic VARCHAR(100),
    difficulty VARCHAR(20), -- easy/medium/hard
    question_text TEXT NOT NULL,
    question_type VARCHAR(50), -- MCQ/Numerical/Integer
    options TEXT, -- JSON array
    correct_answer TEXT,
    solution TEXT,
    ncert_reference VARCHAR(200),
    marks INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### **Subscriptions Table**
```sql
CREATE TABLE user_subscriptions (
    subscription_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    tier VARCHAR(20), -- free/premium/pro
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    status VARCHAR(20), -- active/expired/cancelled
    payment_id VARCHAR(100),
    amount DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
```

### **Progress Table**
```sql
CREATE TABLE user_progress (
    progress_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    activity_type VARCHAR(50), -- question_attempted/topic_studied
    subject VARCHAR(50),
    chapter VARCHAR(100),
    question_id VARCHAR(36),
    is_correct BOOLEAN,
    time_spent INTEGER, -- seconds
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
```

### **Diagrams Table**
```sql
CREATE TABLE diagrams (
    diagram_id INTEGER PRIMARY KEY AUTOINCREMENT,
    page_id VARCHAR(50) UNIQUE,
    subject VARCHAR(50),
    class INTEGER, -- 11 or 12
    chapter VARCHAR(100),
    page_number INTEGER,
    title VARCHAR(255),
    description TEXT,
    file_path VARCHAR(255),
    labeled_parts TEXT, -- JSON
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### **ChromaDB Collections**
```python
# NCERT Content Collection
{
    "collection_name": "ncert_content",
    "embedding_dimension": 768,
    "metadata": {
        "subject": str,
        "class": int,
        "chapter": str,
        "page": int,
        "content_type": str  # text/diagram/formula
    }
}
```

---

## 🔌 API Endpoints

### **Authentication**
```
POST   /api/auth/register          # User registration
POST   /api/auth/login             # User login
POST   /api/auth/logout            # User logout
GET    /api/auth/verify            # Verify session
POST   /api/auth/reset-password    # Password reset
```

### **Query & Chat**
```
POST   /api/ask                    # Ask question
POST   /api/solve-problem          # Solve from image
GET    /api/query/history          # Query history
POST   /api/query/feedback         # Submit feedback
```

### **Voice**
```
POST   /api/voice/transcribe       # Audio to text
POST   /api/voice/synthesize       # Text to speech
```

### **Search**
```
GET    /api/search                 # Semantic search
GET    /api/search/suggestions     # Search suggestions
```

### **Diagrams**
```
GET    /api/diagrams/search        # Search diagrams
GET    /api/diagrams/by-id/:id     # Get by ID
GET    /api/diagrams/by-chapter    # Get by chapter
```

### **Previous Papers**
```
GET    /api/papers/questions       # Get questions with filters
GET    /api/papers/statistics      # Get statistics
POST   /api/papers/generate        # Generate custom paper
GET    /api/papers/download/:id    # Download paper PDF
```

### **Predictions**
```
POST   /api/prediction/predict-paper           # Predict subject paper
GET    /api/prediction/chapter-analysis/:sub   # Chapter probabilities
GET    /api/prediction/insights/:subject       # Prediction insights
GET    /api/prediction/complete-neet/:year     # Complete NEET paper
POST   /api/prediction/smart-paper             # Smart personalized paper
```

### **Video Generator**
```
GET    /video/                     # Video generator UI
POST   /video/api/generate         # Generate video
POST   /video/api/preview          # Preview script
GET    /video/api/videos           # List videos
GET    /video/api/download/:path   # Download video
GET    /video/api/status           # Service status
GET    /video/api/topics           # Sample topics
```

### **Progress**
```
GET    /api/progress/dashboard     # User dashboard
GET    /api/progress/subject/:sub  # Subject progress
GET    /api/progress/weak-areas    # Weak areas
POST   /api/progress/log           # Log activity
```

### **Subscription**
```
GET    /api/subscription/plans     # Available plans
POST   /api/subscription/create-order  # Create Razorpay order
POST   /api/subscription/verify    # Verify payment
GET    /api/subscription/status    # Current subscription
POST   /api/subscription/cancel    # Cancel subscription
```

### **User Profile**
```
GET    /api/user/profile           # Get profile
PUT    /api/user/profile           # Update profile
GET    /api/user/settings          # Get settings
PUT    /api/user/settings          # Update settings
```

---

## 🚀 Deployment Architecture

### **Development Environment**
```
Local Machine
├── Python 3.10+ (Flask app)
├── SQLite (database)
├── ChromaDB (vector store)
├── File system (media storage)
└── Environment variables (.env)
```

### **Production Environment (Recommended)**
```
Cloud Platform (AWS/GCP/Azure/Cloudflare)
│
├── Application Server
│   ├── Flask app (Gunicorn/uWSGI)
│   ├── Nginx (reverse proxy)
│   └── SSL/TLS (HTTPS)
│
├── Database
│   ├── PostgreSQL (production DB)
│   └── Redis (caching)
│
├── Storage
│   ├── S3/R2 (media files)
│   └── CDN (static assets)
│
├── AI Services (External)
│   ├── Google Gemini API
│   ├── Cloudflare Workers AI
│   └── ElevenLabs API
│
└── Monitoring
    ├── Logging (CloudWatch/Datadog)
    ├── Error tracking (Sentry)
    └── Analytics (Google Analytics)
```

### **Cloudflare Deployment (Recommended)**
```
Cloudflare Platform
│
├── Cloudflare Workers
│   └── Flask app (Python Workers)
│
├── Cloudflare D1
│   └── SQLite-compatible database
│
├── Cloudflare R2
│   └── S3-compatible object storage
│
├── Cloudflare KV
│   └── Key-value cache
│
├── Cloudflare Workers AI
│   └── Built-in AI inference
│
└── Cloudflare CDN
    └── Global content delivery
```

### **Scaling Strategy**
```
Horizontal Scaling:
├── Load balancer (Nginx/Cloudflare)
├── Multiple Flask instances
├── Database read replicas
└── Distributed caching (Redis)

Vertical Scaling:
├── Increase server resources
├── Optimize database queries
├── Cache frequently accessed data
└── Use CDN for static assets

AI Optimization:
├── Batch API requests
├── Cache AI responses
├── Use streaming for long responses
└── Implement rate limiting
```

---

## 🔒 Security Measures

### **Authentication & Authorization**
```
├── Bcrypt password hashing (12 rounds)
├── Session-based authentication
├── CSRF protection (Flask-WTF)
├── Rate limiting (Flask-Limiter)
└── JWT tokens (for API access)
```

### **Data Protection**
```
├── HTTPS/TLS encryption
├── SQL injection prevention (parameterized queries)
├── XSS protection (input sanitization)
├── File upload validation
└── Environment variable secrets
```

### **API Security**
```
├── API key rotation
├── Request signing (Razorpay)
├── Webhook verification
├── CORS configuration
└── Input validation
```

---

## 📈 Performance Optimization

### **Caching Strategy**
```
Level 1: Browser Cache
├── Static assets (CSS, JS, images)
├── Cache-Control headers
└── Service workers (future)

Level 2: Application Cache
├── Flask caching (Flask-Caching)
├── AI response caching
└── Database query caching

Level 3: CDN Cache
├── Cloudflare CDN
├── Static file delivery
└── Global edge caching
```

### **Database Optimization**
```
├── Indexes on frequently queried columns
├── Query optimization (EXPLAIN ANALYZE)
├── Connection pooling
├── Lazy loading
└── Pagination for large datasets
```

### **AI Optimization**
```
├── Response streaming (for long outputs)
├── Batch processing
├── Prompt caching
├── Model selection (fast vs accurate)
└── Fallback mechanisms
```

---

## 🔄 Data Flow Summary

### **Complete Request-Response Cycle**

```
┌─────────────────────────────────────────────────────────────┐
│ 1. USER ACTION                                               │
│    User types question / uploads image / speaks             │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│ 2. FRONTEND PROCESSING                                       │
│    ├─> Capture input (text/image/audio)                     │
│    ├─> Validate input                                       │
│    ├─> Show loading state                                   │
│    └─> Send API request (AJAX)                              │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│ 3. FLASK ROUTING                                             │
│    ├─> Route to appropriate endpoint                        │
│    ├─> Authentication check                                 │
│    ├─> Rate limiting                                        │
│    └─> Input validation                                     │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│ 4. SERVICE LAYER                                             │
│    ├─> Query Handler / Problem Solver / Video Generator     │
│    ├─> Business logic processing                            │
│    └─> Coordinate multiple services                         │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│ 5. DATA RETRIEVAL (if needed)                               │
│    ├─> RAG System queries ChromaDB                          │
│    ├─> Get NCERT context                                    │
│    ├─> Fetch diagrams from filesystem                       │
│    └─> Query SQLite for questions/user data                 │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│ 6. AI PROCESSING                                             │
│    ├─> Google Gemini AI (primary)                           │
│    │   ├─> Generate response                                │
│    │   ├─> Solve problems                                   │
│    │   └─> Create content                                   │
│    ├─> Cloudflare AI (embeddings)                           │
│    └─> ElevenLabs (voice)                                   │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│ 7. POST-PROCESSING                                           │
│    ├─> Format response (markdown/JSON)                      │
│    ├─> Add metadata                                         │
│    ├─> Log activity                                         │
│    └─> Update user progress                                 │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│ 8. RESPONSE                                                  │
│    ├─> JSON response to frontend                            │
│    ├─> Include all necessary data                           │
│    └─> Error handling if needed                             │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│ 9. FRONTEND RENDERING                                        │
│    ├─> Parse JSON response                                  │
│    ├─> Update UI dynamically                                │
│    ├─> Display results                                      │
│    └─> Enable user interactions                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 🧪 Testing Strategy

### **Unit Tests**
```python
# Test individual functions
tests/
├── test_query_handler.py
├── test_rag_system.py
├── test_problem_solver.py
└── test_video_generator.py
```

### **Integration Tests**
```python
# Test API endpoints
tests/integration/
├── test_api_auth.py
├── test_api_query.py
├── test_api_predictions.py
└── test_api_video.py
```

### **End-to-End Tests**
```python
# Test complete user flows
tests/e2e/
├── test_user_registration.py
├── test_question_solving.py
├── test_video_generation.py
└── test_payment_flow.py
```

---

## 📝 Environment Variables

```bash
# Flask Configuration
SECRET_KEY=your-secret-key
DEBUG=False
LOG_LEVEL=INFO

# Database
DATABASE_URL=sqlite:///guruai.db

# AI Services
USE_GEMINI=true
GEMINI_API_KEY=your_gemini_key

USE_CLOUDFLARE_AI=true
CLOUDFLARE_ACCOUNT_ID=your_account_id
CLOUDFLARE_API_TOKEN=your_api_token

ELEVENLABS_API_KEY=your_elevenlabs_key

# Payment
RAZORPAY_KEY_ID=your_razorpay_key
RAZORPAY_KEY_SECRET=your_razorpay_secret

# Email
SENDGRID_API_KEY=your_sendgrid_key
SENDGRID_FROM_EMAIL=noreply@vidyatid.com

# Model Configuration
LLM_N_CTX=4096
LLM_TEMPERATURE=0.7
LLM_MAX_TOKENS=512
```

---

## 🎯 Key Technical Decisions

### **Why Hybrid Architecture?**
- **Cloud AI**: Latest models, no local compute needed
- **Local Storage**: Fast access, reduced API costs
- **Best of both worlds**: Intelligence + Speed

### **Why Google Gemini?**
- Free tier available
- Multimodal (text, image, audio)
- Fast inference
- Good quality responses
- Easy integration

### **Why ChromaDB?**
- Open source
- Easy to use
- Fast vector search
- Local deployment
- Python native

### **Why Flask?**
- Lightweight
- Easy to learn
- Flexible
- Large ecosystem
- Python integration

### **Why SQLite?**
- No server needed
- Fast for read-heavy workloads
- Easy backup
- Perfect for development
- Can migrate to PostgreSQL later

---

## 📚 Dependencies

### **Core Dependencies**
```
flask>=2.0.0
flask-cors>=3.0.0
flask-sqlalchemy>=2.5.0
python-dotenv>=0.19.0
```

### **AI & ML**
```
google-generativeai>=0.3.0
sentence-transformers>=2.2.0
chromadb>=0.4.0
pillow>=9.0.0
pytesseract>=0.3.0
```

### **Video Generation**
```
moviepy>=1.0.3
numpy>=1.20.0
```

### **Payment & Email**
```
razorpay>=1.3.0
sendgrid>=6.9.0
```

---

## 🔮 Future Enhancements

### **Planned Features**
1. Mobile app (React Native)
2. Real-time collaboration
3. Live doubt sessions
4. Gamification
5. Adaptive learning paths
6. AR/VR diagrams
7. Offline mode improvements
8. Multi-language support

### **Technical Improvements**
1. Microservices architecture
2. GraphQL API
3. WebSocket for real-time
4. Progressive Web App (PWA)
5. Edge computing
6. Advanced caching
7. A/B testing framework
8. Analytics dashboard

---

## 📞 Support & Documentation

### **Developer Resources**
- API Documentation: `/docs/API_DOCUMENTATION.md`
- Setup Guide: `/README.md`
- Deployment Guide: `/cloudflare/DEPLOYMENT_COMPLETE_GUIDE.md`
- Contributing Guide: `/CONTRIBUTING.md`

### **Contact**
- Email: dev@vidyatid.com
- GitHub: github.com/vidyatid
- Discord: discord.gg/vidyatid

---

**Last Updated:** December 2025  
**Version:** 1.0  
**Maintained by:** VidyaTid Development Team
