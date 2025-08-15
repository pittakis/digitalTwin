# backend/routers/energy.py
from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
import os
from openai import OpenAI
client = OpenAI()

router = APIRouter()

client.api_key = os.getenv("OPENAI_API_KEY")
if not client.api_key:
    raise RuntimeError("OPENAI_API_KEY environment variable not set")


class MessageRequest(BaseModel):
    message: str

@router.post("/getAIResponse")
async def getAIResponse(
    payload: MessageRequest
):
    # print(f"Received message: {payload.message}")
    try:
        # call ChatGPT
        response = client.responses.create(
            model="gpt-4.1",
            input="You are an AI assistant. Your response should be very short. Answer the following question only if it is related to sensors or digital twin: " + payload.message      
            )
        reply = response.output_text
        # print(f"AI response: {reply}")
        return {"response": reply}

    except Exception as e:
        # handle errors
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/aiTest")
async def aiTest():
    try:
        # print("Calling AI service...")
        # call ChatGPT
        response = client.responses.create(
            model="gpt-3.5-turbo",
            input="Translate the below text to Hindi. Text: \"\"\"I work at Geeks for Geeks \"\"\""        
            )
        reply = response.output_text
        # print(f"AI response: {reply}")
        return {"response": reply}

    except Exception as e:
        # handle errors
        raise HTTPException(status_code=500, detail=str(e))