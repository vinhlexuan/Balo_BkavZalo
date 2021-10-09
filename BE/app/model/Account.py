from pydantic.main import BaseModel


class Account(BaseModel):
    username : str
    password : str
    user_id : str

    @staticmethod
    def to_dict(self):
        return vars(self)
    def from_dict(source):
        pass
    def __repr__(self) -> str:
        return(
            f'Account(\
                username={self.username}, \
                password={self.password}, \
                user_id={self.user_id}, \
            )'
        )
    
