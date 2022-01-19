from pydantic import BaseModel, Field

class SignupRequest(BaseModel):
	phonenumber : str = Field(..., regex="^0\d{9}$")
	password : str = Field(..., regex="^\w{6,10}$")
	username: str = Field(..., regex="^([a-zA-Z]{2,}\s[a-zA-Z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)")
	uuid: str = Field(...)

class LoginRequest(BaseModel):
	phonenumber : str = Field(..., regex="^0\d{9}$")
	password : str = Field(..., regex="^\w{6,10}$")
	
