
# File: backend/src/models/journal_entry.py
from pydantic import BaseModel
from datetime import datetime

class JournalEntry(BaseModel):
    id: str = None
    date: datetime
    content: str
    sentiment: str = None
