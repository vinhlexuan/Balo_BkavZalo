from pydantic import BaseModel, Field
from typing import Optional

class SetRequestFriend(BaseModel):
    token : str = Field(...)
    user_id : str = Field(...)

class GetRequestedFriend(BaseModel):
    user_id: Optional[str]
    token: str = Field(...)
    index: str = Field(...)
    count: str = Field(...)

class SetAcceptFriend(BaseModel):
    token : str = Field(...)
    user_id : str = Field(...)
    is_accept : str = Field(...)