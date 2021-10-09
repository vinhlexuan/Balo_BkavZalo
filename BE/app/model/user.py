class Account:
    def __init__(self, name : str, phone_number : str, avatar : str, account_id : str):
        self.name = name
        self.phone_number = phone_number
        self.avatar = avatar
        self.account_id = account_id

    @staticmethod
    def to_dict(self):
        return vars(self)
    def from_dict(source):
        pass
    def __repr__(self) -> str:
        return(
            f'User(\
                name={self.name}, \
                phone_number={self.phone_number}, \
                avatar={self.avatar}, \
                account_id={self.account_id}, \
            )'
        )