from pydantic import BaseModel, Field


class RegisterRequest(BaseModel):
    username : str
    password : str
    name : str
    phone_number : str = Field(None, nullable=True)
    avatar : str = Field(None, nullable=True)