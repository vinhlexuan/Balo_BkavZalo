from pydantic import BaseModel, Field

class PostRequest(BaseModel):
	content : str = Field(...)
	files : list
	phonenumber : str = Field(...,regex="^0\d{9}$")