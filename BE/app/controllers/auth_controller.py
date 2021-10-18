from fastapi import HTTPException
from app.models.user import User
from app.repositories import user_repo
from app.auth.auth import AuthHandler
from app.schemas.auth import LoginRequest, SignupRequest

auth_handler = AuthHandler()

def ok(data = None):
	res = {"code": "1000", "message": "OK"}
	if data is not None:
		res['data'] = data
	return res

def create_user(sign_info: SignupRequest):
	user_doc = user_repo.find_by_phonenumber(sign_info.phonenumber)

	if user_doc.exists:		# user existed
		raise HTTPException(status_code=400, detail='9996')

	sign_info.password = auth_handler.get_password_hash(sign_info.password)
	user_repo.create(sign_info.dict())
	return ok()

def login(login_request: LoginRequest):
	user_doc = user_repo.find_by_phonenumber(login_request.phonenumber)
	if user_doc is None:
		raise HTTPException(status_code=400, detail='9995')

	user_dict = user_doc.to_dict()
	if not auth_handler.verify_password(login_request.password, user_dict['password']):
		raise HTTPException(status_code=400, detail='1004')

	token = auth_handler.encode_token(login_request.phonenumber, user_doc.id)

	user_dict.pop('phonenumber')
	user_dict.pop('password')
	user_dict.pop('uuid')

	user_dict['token'] = token
	user_dict['id'] = user_doc.id
	
	return ok(user_dict)

def find_all():
	users = user_repo.find_all();
	return ok(users)

def find_one_by_phonenumber(phonenumber: str):
	user_doc = user_repo.find_by_phonenumber(phonenumber)
	return ok(user_doc.to_dict())