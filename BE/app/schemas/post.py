from pydantic import BaseModel, Field

class PostRequest(BaseModel):
	described : str = Field(...)
	video : str 
	image : list 
	token : str = Field(...)