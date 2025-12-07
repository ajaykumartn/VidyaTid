"""
Fix imports to make heavy ML packages optional for Render deployment
"""
import os
import re

files_to_fix = [
    'services/rag_system.py',
    'services/ncert_processor.py',
    'services/cloudflare_ai.py',
    'services/model_manager.py'
]

def make_import_optional(file_path):
    """Make imports optional with try-except"""
    if not os.path.exists(file_path):
        print(f"⚠️ File not found: {file_path}")
        return
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    original_content = content
    
    # Fix sentence_transformers import
    content = re.sub(
        r'^from sentence_transformers import SentenceTransformer$',
        '''try:
    from sentence_transformers import SentenceTransformer
    SENTENCE_TRANSFORMERS_AVAILABLE = True
except ImportError:
    SENTENCE_TRANSFORMERS_AVAILABLE = False
    SentenceTransformer = None''',
        content,
        flags=re.MULTILINE
    )
    
    # Fix chromadb import
    content = re.sub(
        r'^import chromadb$',
        '''try:
    import chromadb
    CHROMADB_AVAILABLE = True
except ImportError:
    CHROMADB_AVAILABLE = False
    chromadb = None''',
        content,
        flags=re.MULTILINE
    )
    
    # Fix llama_cpp import
    content = re.sub(
        r'^from llama_cpp import Llama$',
        '''try:
    from llama_cpp import Llama
    LLAMA_CPP_AVAILABLE = True
except ImportError:
    LLAMA_CPP_AVAILABLE = False
    Llama = None''',
        content,
        flags=re.MULTILINE
    )
    
    if content != original_content:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"✅ Fixed: {file_path}")
    else:
        print(f"ℹ️ No changes needed: {file_path}")

if __name__ == '__main__':
    print("Fixing imports for Render deployment...")
    print()
    for file_path in files_to_fix:
        make_import_optional(file_path)
    print()
    print("✅ Done! All imports are now optional.")
