"""
Google Gemini AI Service with Multiple API Key Support
Free tier: 15 requests per minute, 1500 requests per day per key
Get API key from: https://makersuite.google.com/app/apikey
"""
import os
import logging
import google.generativeai as genai
from typing import Dict, Any, List, Optional
import time

logger = logging.getLogger(__name__)

class GeminiAI:
    """Google Gemini AI service with multiple API key rotation for better rate limits"""
    
    def __init__(self):
        # Load all available API keys
        self.api_keys = self._load_api_keys()
        
        if not self.api_keys:
            raise ValueError(
                "No GEMINI_API_KEY found. Get free key from: https://makersuite.google.com/app/apikey\n"
                "Set GEMINI_API_KEYS (comma-separated) or GEMINI_API_KEY in .env"
            )
        
        # Track which key to use next (round-robin)
        self.current_key_index = 0
        
        # Track failed keys to avoid using them temporarily
        self.failed_keys = {}  # {key_index: timestamp}
        self.key_cooldown = 60  # seconds to wait before retrying a failed key
        
        try:
            # Initialize with first available key
            self._configure_with_key(0)
            
            # Use Gemini 2.5 Flash (stable, better rate limits)
            # Free tier: 15 RPM, 1500 RPD, 1M TPM per key
            self.model = genai.GenerativeModel('gemini-2.5-flash')
            self.enabled = True
            
            logger.info(f"✅ Gemini AI initialized with {len(self.api_keys)} API key(s) (gemini-2.5-flash)")
        except Exception as e:
            logger.error(f"Failed to initialize Gemini: {e}")
            raise
    
    def _load_api_keys(self) -> List[str]:
        """Load all available Gemini API keys from environment"""
        keys = []
        
        # Try GEMINI_API_KEYS first (comma-separated, preferred method)
        multi_keys = os.getenv("GEMINI_API_KEYS")
        if multi_keys:
            # Split by comma and strip whitespace
            keys = [key.strip() for key in multi_keys.split(',') if key.strip()]
        
        # Fallback to legacy GEMINI_API_KEY (single key)
        if not keys:
            main_key = os.getenv("GEMINI_API_KEY")
            if main_key:
                keys.append(main_key.strip())
        
        # Remove duplicates while preserving order
        seen = set()
        unique_keys = []
        for key in keys:
            if key not in seen:
                seen.add(key)
                unique_keys.append(key)
        
        return unique_keys
    
    def _configure_with_key(self, key_index: int):
        """Configure Gemini with a specific API key"""
        if 0 <= key_index < len(self.api_keys):
            genai.configure(api_key=self.api_keys[key_index])
            self.current_key_index = key_index
            logger.debug(f"Configured Gemini with API key #{key_index + 1}")
    
    def _get_next_available_key(self) -> Optional[int]:
        """Get next available API key index (skip failed keys in cooldown)"""
        current_time = time.time()
        
        # Remove keys that have cooled down
        self.failed_keys = {
            idx: timestamp 
            for idx, timestamp in self.failed_keys.items() 
            if current_time - timestamp < self.key_cooldown
        }
        
        # Try to find next available key
        for i in range(len(self.api_keys)):
            next_index = (self.current_key_index + i) % len(self.api_keys)
            
            if next_index not in self.failed_keys:
                return next_index
        
        # All keys are in cooldown, return the oldest one
        if self.failed_keys:
            oldest_key = min(self.failed_keys.items(), key=lambda x: x[1])[0]
            logger.warning(f"All API keys in cooldown, using oldest: #{oldest_key + 1}")
            return oldest_key
        
        return 0
    
    def _rotate_key(self):
        """Rotate to next available API key"""
        next_key = self._get_next_available_key()
        if next_key is not None and next_key != self.current_key_index:
            self._configure_with_key(next_key)
            logger.info(f"🔄 Rotated to API key #{next_key + 1}/{len(self.api_keys)}")
    
    def _mark_key_failed(self, key_index: int):
        """Mark a key as failed (rate limited)"""
        self.failed_keys[key_index] = time.time()
        logger.warning(f"⚠️ API key #{key_index + 1} marked as rate-limited (cooldown: {self.key_cooldown}s)")
    
    def generate(self, prompt: str, temperature: float = 0.7, max_tokens: int = 2000, 
                 stop: Optional[List[str]] = None, **kwargs) -> Dict[str, Any]:
        """
        Generate text completion using Gemini
        Compatible with ModelManager interface
        
        Args:
            prompt: Input prompt
            temperature: Sampling temperature (0-1)
            max_tokens: Maximum tokens to generate
            stop: Stop sequences (optional)
            **kwargs: Additional arguments (ignored for compatibility)
        
        Returns:
            Dictionary with 'text', 'success', 'tokens_used', 'error'
        """
        # Try with current key, rotate on rate limit
        max_retries = len(self.api_keys)
        
        for attempt in range(max_retries):
            try:
                # Configure generation
                generation_config = genai.types.GenerationConfig(
                    temperature=temperature,
                    max_output_tokens=max_tokens,
                    stop_sequences=stop if stop else None
                )
                
                # Generate response
                response = self.model.generate_content(
                    prompt,
                    generation_config=generation_config
                )
                
                # Extract text - handle different response formats with robust error handling
                text = ""
                
                # Try to get text directly first
                try:
                    if hasattr(response, 'text'):
                        text = response.text
                except (IndexError, AttributeError, ValueError) as e:
                    logger.debug(f"Could not access response.text directly: {e}")
                
                # If that didn't work, try candidates
                if not text:
                    try:
                        if hasattr(response, 'candidates') and response.candidates:
                            if len(response.candidates) > 0:
                                candidate = response.candidates[0]
                                if hasattr(candidate, 'content'):
                                    content = candidate.content
                                    if hasattr(content, 'parts') and content.parts:
                                        if len(content.parts) > 0:
                                            part = content.parts[0]
                                            if hasattr(part, 'text'):
                                                text = part.text
                    except (IndexError, AttributeError, ValueError) as e:
                        logger.debug(f"Could not access response via candidates: {e}")
                
                # Final check
                if not text:
                    logger.warning("Empty or inaccessible response from Gemini")
                    return {
                        'text': '',
                        'success': False,
                        'tokens_used': 0,
                        'error': 'Empty response from API'
                    }
                
                # Estimate tokens (rough approximation)
                tokens_used = len(text.split()) + len(prompt.split())
                
                result = {
                    'text': text,
                    'success': True,
                    'tokens_used': tokens_used,
                    'error': None
                }
                
                logger.info(f"✅ Gemini generation successful with key #{self.current_key_index + 1} (~{tokens_used} tokens)")
                return result
                
            except Exception as e:
                error_msg = str(e)
                
                # Check if it's a rate limit error
                if '429' in error_msg or 'quota' in error_msg.lower() or 'rate limit' in error_msg.lower():
                    logger.warning(f"⚠️ Rate limit hit on key #{self.current_key_index + 1}: {error_msg}")
                    
                    # Mark current key as failed
                    self._mark_key_failed(self.current_key_index)
                    
                    # If we have more keys to try, rotate and retry
                    if attempt < max_retries - 1:
                        self._rotate_key()
                        logger.info(f"🔄 Retrying with key #{self.current_key_index + 1}...")
                        continue
                    else:
                        # All keys exhausted
                        logger.error("❌ All API keys rate-limited!")
                        return {
                            'text': '',
                            'success': False,
                            'tokens_used': 0,
                            'error': 'RATE_LIMIT_EXCEEDED',
                            'retry_after': 30
                        }
                
                # Other errors - don't retry
                logger.error(f"❌ Gemini generation failed: {e}")
                return {
                    'text': '',
                    'success': False,
                    'tokens_used': 0,
                    'error': error_msg
                }
        
        # Should never reach here
        return {
            'text': '',
            'success': False,
            'tokens_used': 0,
            'error': 'Unknown error'
        }
    
    def chat(self, messages: List[Dict[str, str]], temperature: float = 0.7, 
             max_tokens: int = 1024) -> str:
        """
        Generate chat response using Gemini
        
        Args:
            messages: List of message dicts with 'role' and 'content'
            temperature: Sampling temperature
            max_tokens: Maximum tokens to generate
            
        Returns:
            Generated response text
        """
        try:
            # Convert messages to prompt format
            prompt = self._messages_to_prompt(messages)
            
            # Generate
            result = self.generate(prompt, temperature, max_tokens)
            
            if result['success']:
                return result['text']
            else:
                raise Exception(result['error'])
                
        except Exception as e:
            logger.error(f"Gemini chat failed: {e}")
            raise
    
    def _messages_to_prompt(self, messages: List[Dict[str, str]]) -> str:
        """Convert chat messages to prompt format"""
        prompt_parts = []
        
        for msg in messages:
            role = msg.get('role', 'user')
            content = msg.get('content', '')
            
            if role == 'system':
                prompt_parts.append(f"System Instructions: {content}\n")
            elif role == 'user':
                prompt_parts.append(f"User: {content}\n")
            elif role == 'assistant':
                prompt_parts.append(f"Assistant: {content}\n")
        
        prompt_parts.append("Assistant: ")
        return "\n".join(prompt_parts)
    
    def get_status(self) -> Dict[str, Any]:
        """Get status info (compatible with ModelManager)"""
        active_keys = len(self.api_keys) - len(self.failed_keys)
        
        return {
            'enabled': self.enabled,
            'model': 'gemini-2.5-flash',
            'provider': 'Google Gemini',
            'tier': 'Free (Stable)',
            'rate_limit': f'15 RPM, 1500 RPD per key × {len(self.api_keys)} keys',
            'total_keys': len(self.api_keys),
            'active_keys': active_keys,
            'current_key': self.current_key_index + 1,
            'quality': 'Excellent'
        }


def get_gemini_ai():
    """Get or create Gemini AI instance"""
    global _gemini_ai
    if '_gemini_ai' not in globals():
        _gemini_ai = GeminiAI()
    return _gemini_ai


def is_gemini_enabled():
    """Check if Gemini is enabled"""
    return os.getenv('USE_GEMINI', 'false').lower() == 'true'
