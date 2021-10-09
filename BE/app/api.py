from typing import Optional
from fastapi import FastAPI
# from app.controller import test
from app.db_connect import db

app = FastAPI()

@app.get("/")
async def read_root():
    return {"Hello": "World"}

