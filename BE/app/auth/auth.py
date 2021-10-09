from fastapi import security
import jwt
from fastapi import HTTPException, Security
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from passlib.context import CryptContext
from datetime import datetime, timedelta


class AuthHandler():
    sercurity = HTTPBearer()
    pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
    secret = 'SECRET'

    def get_password_hash(self, password):
        return self.pwd_context.hash(password)

    def verify_password(self, plain_password, hashed_password):
        return self.pwd_context.verify(plain_password,hashed_password)

    def encode_token(self, username, user_id):
        payload = {
            'at' : datetime.utcnow(),
            'exp' : datetime.utcnow() + timedelta(days = 0, hours = 10),
            'username' : username,
            'user_id': user_id
        }
        return jwt.encode(
            payload= payload,
            key=self.secret,
            algorithm='HS256'
        )
    def decode_token(self, token):
        try:
            payload = jwt.decode(token, key= self.secret, algorithms=['HS256'])
        except jwt.ExpiredSignatureError:
            raise HTTPException(status_code=401, detail='Signature has expired')
        except jwt.InvalidTokenError as e:
            raise HTTPException(status_code=401, detail='Invalid token')
    def auth_wrapper(self, auth : HTTPAuthorizationCredentials = Security(security)):
        return self.decode_token(auth.credentials)
