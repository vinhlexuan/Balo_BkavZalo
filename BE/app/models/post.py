class Post: 
    def __init__(self, content : str, user_id : str, files = [], comments = [], likes = []):
        self.content = content
        self.files = files
        self.comments = comments
        self.likes = likes
        self.user_id = user_id

    @staticmethod
    def to_dict(self):
        return vars(self)
    def from_dict(source):
        pass
    def __repr__(self) -> str:
        return(
            f'Account(\
                content={self.content}, \
                _id={self.user_id}, \
                files={self.files}, \
            )'
        )