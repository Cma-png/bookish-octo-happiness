# File: backend/src/api/routes.py
from fastapi import FastAPI, HTTPException
from ..models.journal_entry import JournalEntry
from ..services.notion_service import NotionService
from ..services.llm_service import LLMService

app = FastAPI()
notion_service = NotionService()
llm_service = LLMService()

@app.post("/entries")
async def create_entry(entry: JournalEntry):
    try:
        created_entry = await notion_service.create_entry(entry)
        sentiment = await llm_service.analyze_sentiment(entry.content)
        created_entry.sentiment = sentiment
        return created_entry
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/entries")
async def get_entries():
    try:
        return await notion_service.get_entries()
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
