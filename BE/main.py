import uvicorn
from app.db_connect import db
if __name__ == "__main__":
    uvicorn.run("app.controller.UserController:app", host="127.0.0.1", port=8000, reload=True)
