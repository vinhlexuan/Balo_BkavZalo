from pydantic import BaseModel, Field

class CommentRequest(BaseModel):
    token : str = Field(...)
    id : str = Field(...)
    comment: str = Field(...)
    index : str = Field(...)
    count: str = Field(...)

class GetCommentRequest(BaseModel):
    token : str = Field(...)
    id : str = Field(...)
    index : str = Field(...)
    count: str = Field(...)

class DeleteCommentRequest(BaseModel):
    token : str = Field(...)
    id : str = Field(...)
    id_com : str = Field(...)

class EditCommentRequest(BaseModel):
    token : str = Field(...)
    id : str = Field(...)
    id_com : str = Field(...)
    comment: str = Field(...)