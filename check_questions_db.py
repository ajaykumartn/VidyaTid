#!/usr/bin/env python3
"""
Check questions database status
"""
import sys
from models.database import init_db, SessionLocal
from models.question import Question

try:
    # Initialize database
    from models.database import init_db, create_tables
    init_db()
    create_tables()
    
    # Import SessionLocal after initialization
    from models.database import SessionLocal as Session
    db = Session()
    
    # Count total questions
    total = db.query(Question).count()
    print(f"\n📊 Database Status:")
    print(f"   Total questions: {total}")
    
    if total > 0:
        # Count by subject
        subjects = db.query(Question.subject, Question).group_by(Question.subject).all()
        print(f"\n📚 By Subject:")
        for subject, _ in subjects:
            count = db.query(Question).filter(Question.subject == subject).count()
            print(f"   {subject}: {count} questions")
        
        # Count by difficulty
        print(f"\n⭐ By Difficulty:")
        for difficulty in ['easy', 'medium', 'hard']:
            count = db.query(Question).filter(Question.difficulty == difficulty).count()
            print(f"   {difficulty}: {count} questions")
        
        # Sample question
        sample = db.query(Question).first()
        print(f"\n📝 Sample Question:")
        print(f"   ID: {sample.question_id}")
        print(f"   Subject: {sample.subject}")
        print(f"   Chapter: {sample.chapter}")
        print(f"   Difficulty: {sample.difficulty}")
        print(f"   Text: {sample.question_text[:100]}...")
    else:
        print(f"\n⚠️  No questions found in database!")
        print(f"   Run: python utils/question_importer.py import --file questions.json")
    
    db.close()
    
except Exception as e:
    print(f"\n❌ Error: {e}")
    import traceback
    traceback.print_exc()
