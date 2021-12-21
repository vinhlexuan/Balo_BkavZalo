from pydantic import BaseModel, Field

class ListPostRequest(BaseModel):
	count : str = Field(...)
	last_id : str = Field(...)
	index : str = Field(...)
	token : str = Field(...)

class PostRequest(BaseModel):
	describle : str = Field(...)
	video : str 
	image : list
	token : str = Field(...)

class ReportPost(BaseModel):
	token : str = Field(...)
	id : str = Field(...)
	subject : str = Field(...)
	details : str = Field(...)