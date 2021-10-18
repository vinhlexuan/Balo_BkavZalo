from fastapi import APIRouter, Depends, HTTPException
from fastapi.applications import FastAPI
from fastapi.security import OAuth2PasswordRequestForm
from fastapi.security.oauth2 import OAuth2PasswordBearer
from app.auth.auth import AuthHandler
from app.auth.RegisterRequest import RegisterRequest
from app.db_connect import db
from app.constants.APIConstants import ACCOUNT_PREFIX

# router = APIRouter()

app = FastAPI()
db_accounts = db.collection(u'accounts')
db_users = db.collection(u'users')

auth_handler = AuthHandler()
oauth2_scheme = OAuth2PasswordBearer(tokenUrl='token')
 
@app.post(ACCOUNT_PREFIX + '/register', tags=['account'])
async def register(auth_details : RegisterRequest):

    collection = db.collection(u'accounts').get()
    accounts = []
    for account in collection:
        accounts.append(account.to_dict())
    if any(x['username'] == auth_details.username for x in accounts):
        raise HTTPException(status_code=400, detail='username is taken')
    hashed_password = auth_handler.get_password_hash(auth_details.password)
    account_id = db_accounts.document().id
    user_id = db_users.document().id
    db_accounts.document(account_id).set({
        'username': auth_details.username,
        'password': hashed_password,
        'user_id': user_id
    })
    db_users.document(user_id).set({
        'name': auth_details.name,
        'phone_number': auth_details.phone_number,
        'avatar': auth_details.avatar,
        'account_id': account_id
    })
    return

@app.post('/token', tags=['account'])
async def login(auth_details : OAuth2PasswordRequestForm = Depends()):
    collection = db.collection(u'accounts').get()
    accounts = []
    for account in collection:
        accounts.append(account.to_dict())
    user = None
    for x in accounts:
        if x['username'] == auth_details.username:
            user = x
            break
    hashed_password = auth_handler.get_password_hash(auth_details.password)
    if (user is None) or (not auth_handler.verify_password(auth_details.password,hashed_password)):
        raise HTTPException(status_code=401,detail='Invalid username or password')
    token = auth_handler.encode_token(user['username'], user['user_id'])
    return {'token': token}

@app.post('/')
async def index(token : str = Depends(oauth2_scheme)):
    return {'token': token}