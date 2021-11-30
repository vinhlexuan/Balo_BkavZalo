from pydantic import BaseModel, Field

class ListPostRequest(BaseModel):
	count : str = Field(...)
	last_id : str = Field(...)
	index : str = Field(...)
	token : str = Field(...)

class PostRequest(BaseModel):
	described : str = Field(...)
	video : str 
	image : list
	token : str = Field(...)

class Author(BaseModel):
	id : str
	name : str
	avatar: str

class Video(BaseModel):
	url : str
	thumb : str

class PostResponse(BaseModel):

	def __init__(self, **entries):
		self.__dict__.update(entries)
	id : str
	described : str
	created : str
	modified : str
	like : str
	comment : str
	is_liked : str
	image : list[str]
	video : Video
	author : Author
	state : str
	is_blocked: str
	can_edit : str
	banned : str
	can_comment: str


