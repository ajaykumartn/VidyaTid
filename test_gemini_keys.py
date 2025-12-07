#!/usr/bin/env python3
"""
Test script for Gemini API multiple key rotation
Run this to verify your API keys are working correctly
"""

import os
import sys
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Add project root to path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

def test_gemini_keys():
    """Test Gemini API with multiple keys"""
    
    print("=" * 60)
    print("🧪 Testing Gemini API Multiple Key Setup")
    print("=" * 60)
    
    try:
        from services.gemini_ai import GeminiAI
        
        # Initialize Gemini
        print("\n📦 Initializing Gemini AI...")
        gemini = GeminiAI()
        
        # Get status
        status = gemini.get_status()
        
        print(f"\n📊 Configuration:")
        print(f"   Model: {status['model']}")
        print(f"   Provider: {status['provider']}")
        print(f"   Total API Keys: {status['total_keys']}")
        print(f"   Active Keys: {status['active_keys']}")
        print(f"   Current Key: #{status['current_key']}")
        print(f"   Rate Limit: {status['rate_limit']}")
        
        # Test generation
        print(f"\n🧪 Running test generations...")
        
        test_prompts = [
            "Say 'Hello from key test 1'",
            "Say 'Hello from key test 2'",
            "Say 'Hello from key test 3'",
        ]
        
        success_count = 0
        for i, prompt in enumerate(test_prompts, 1):
            print(f"\n   Test {i}/{len(test_prompts)}: ", end="")
            
            result = gemini.generate(prompt, max_tokens=50, temperature=0.5)
            
            if result['success']:
                print(f"✅ Success")
                print(f"      Response: {result['text'][:60]}...")
                print(f"      Tokens: ~{result['tokens_used']}")
                success_count += 1
            else:
                print(f"❌ Failed")
                print(f"      Error: {result['error']}")
        
        # Summary
        print(f"\n{'=' * 60}")
        print(f"📈 Test Results:")
        print(f"   Successful: {success_count}/{len(test_prompts)}")
        print(f"   Failed: {len(test_prompts) - success_count}/{len(test_prompts)}")
        
        if success_count == len(test_prompts):
            print(f"\n✅ All tests passed! Your Gemini setup is working correctly.")
        elif success_count > 0:
            print(f"\n⚠️  Some tests failed. Check your API keys.")
        else:
            print(f"\n❌ All tests failed. Please check your configuration.")
        
        print(f"{'=' * 60}\n")
        
        return success_count == len(test_prompts)
        
    except Exception as e:
        print(f"\n❌ Error: {e}")
        print(f"\nTroubleshooting:")
        print(f"   1. Make sure GEMINI_API_KEY is set in .env")
        print(f"   2. Check your API key is valid")
        print(f"   3. Verify USE_GEMINI=true in .env")
        print(f"   4. Install required packages: pip install google-generativeai")
        return False


if __name__ == "__main__":
    success = test_gemini_keys()
    sys.exit(0 if success else 1)
