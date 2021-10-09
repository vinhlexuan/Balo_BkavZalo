class Comment:
    def __init__(self, post_id : str, content: str, account_id: str):
        self.content = content
        self.post_id = post_id
        self.account_id = account_id
    
    @staticmethod
    def to_dict(self):
        return vars(self)
    def from_dict(source):
        pass
    def __repr__(self) -> str:
        return(
            f'Account(\
                content={self.content}, \
                account_id={self.account_id}, \
            )'
        )