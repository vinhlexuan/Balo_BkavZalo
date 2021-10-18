from pydantic import BaseModel, Field

class SignupRequest(BaseModel):
	phonenumber : str = Field(..., regex="^0\d{9}$")
	password : str = Field(..., regex="^.{6,10}$")
	uuid: str = Field(...)

class LoginRequest(BaseModel):
	phonenumber : str = Field(..., regex="^0\d{9}$")
	password : str = Field(..., regex="^.{6,10}$")
