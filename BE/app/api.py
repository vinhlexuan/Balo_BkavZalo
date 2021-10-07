from typing import Optional
from fastapi import FastAPI
# from app.controller import test
from app.db_connect import db

app = FastAPI()

@app.get("/")
async def read_root():
    return {"Hello": "World"}


@app.get("/items/{item_id}")
async def read_item(item_id: int, q: Optional[str] = None):
    return {"item_id": item_id, "q": q}

# @app.post("/write/{city}")
# def wrote(city):
#     data = {
#         u'name': city,
#         u'state': u'CA',
#         u'country': u'USA'
#     }

#     # Add a new doc in collection 'cities' with ID 'LA'
#     db.collection(u'cities').document(u'LA').set(data)
#     return 1