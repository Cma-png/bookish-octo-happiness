
# File: backend/src/services/llm_service.py
import openai

class LLMService:
    def __init__(self):
        openai.api_key = "YOUR_OPENAI_API_KEY"  # Store this securely

    async def analyze_sentiment(self, content: str) -> str:
        response = openai.Completion.create(
            engine="text-davinci-002",
            prompt=f"Analyze the sentiment of this text: {content}",
            max_tokens=60
        )
        
        return response.choices[0].text.strip()