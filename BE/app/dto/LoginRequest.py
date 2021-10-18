from pydantic import BaseModel, Field


class LoginRequest(BaseModel):
    phonenumber : str = Field(..., regex="^0\d{9}$")
    password : str = Field(..., regex="^.{6,10}$")
