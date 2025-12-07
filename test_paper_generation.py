#!/usr/bin/env python3
"""
Test paper generation
"""
from models.database import init_db, create_tables, SessionLocal
from services.question_generator import QuestionGenerator, QuestionPaperConfig

# Initialize database
init_db()
create_tables()

# Import SessionLocal after init
from models.database import SessionLocal as Session

# Get session
db = Session()

try:
    # Initialize generator
    print("📦 Initializing Question Generator...")
    generator = QuestionGenerator(db)
    
    # Create config for 10 questions (we only have 12 in DB)
    config = QuestionPaperConfig(
        subjects=['Physics', 'Chemistry', 'Mathematics', 'Biology'],
        chapters=[],
        difficulty_distribution={'easy': 0.3, 'medium': 0.4, 'hard': 0.3},
        question_count=10,
        exam_type=None,
        include_solutions=True,
        randomize_order=True
    )
    
    print(f"\n🎯 Generating paper with config:")
    print(f"   Subjects: {config.subjects}")
    print(f"   Question count: {config.question_count}")
    print(f"   Difficulty: {config.difficulty_distribution}")
    
    # Generate paper
    paper = generator.generate_paper(config)
    
    print(f"\n✅ Paper generated successfully!")
    print(f"   Title: {paper.title}")
    print(f"   Questions: {len(paper.questions)}")
    print(f"   Duration: {paper.metadata.get('duration_minutes', 'N/A')} minutes")
    
    # Show first 3 questions
    print(f"\n📝 Sample Questions:")
    for i, q in enumerate(paper.questions[:3], 1):
        print(f"\n   Question {i}:")
        print(f"      Subject: {q.get('subject')}")
        print(f"      Difficulty: {q.get('difficulty')}")
        print(f"      Text: {q.get('question_text', '')[:80]}...")
    
except Exception as e:
    print(f"\n❌ Error: {e}")
    import traceback
    traceback.print_exc()

finally:
    db.close()
