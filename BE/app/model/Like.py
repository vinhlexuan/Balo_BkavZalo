class Like:
    def __init__(self, post_id : str, user_id : str):
        self.post_id = post_id
        self.user_id = user_id
    
    @staticmethod
    def to_dict(self):
        return vars(self)
    def from_dict(source):
        pass
    def __repr__(self) -> str:
        return(
            f'Account(\
                post_id={self.post_id}, \
                user_id={self.user_id}, \
            )'
        )