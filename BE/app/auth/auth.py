from fastapi import security
from fastapi.param_functions import Depends
from jose import JWTError, jwt
from fastapi import HTTPException, Security, status
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer, OAuth2PasswordBearer
from passlib.context import CryptContext
from app.repositories import user_repo
from datetime import datetime, timedelta

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")

SECRET = 'SECRET'
ALGORITHM = 'HS256'
class AuthHandler():
    sercurity = HTTPBearer()
    pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
    

    def get_password_hash(self, password):
        return self.pwd_context.hash(password)

    def verify_password(self, plain_password, hashed_password):
        return self.pwd_context.verify(plain_password,hashed_password)

    def encode_token(self, phonenumber, user_id):
        payload = {
    #        'at' : datetime.utcnow(),
            'exp' : datetime.utcnow() + timedelta(days = 0, hours = 10),
            'phonenumber' : phonenumber,
            'user_id': user_id
        }
        return jwt.encode(
            payload= payload,
            key=SECRET,
            algorithm=ALGORITHM
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
