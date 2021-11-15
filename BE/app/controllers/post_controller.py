from fastapi.param_functions import Depends
from fastapi import HTTPException
from app.schemas.post import PostRequest
from app.repositories import post_repo, user_repo
from app.controllers.auth_controller import login


def ok(data = None):
	res = {'code': '1000', 'message': 'OK'}
	if data is not None:
		res['data'] = data
	return res

def create_post(post_info : PostRequest):
	post_dict = vars(post_info)
	user_doc = user_repo.find_by_phonenumber(post_info.phonenumber)
	if not user_doc.exists:
		raise HTTPException(status_code=400, detail='9995')
	post_repo.create(post_dict)
	return ok()

def delete_post(post_id : str):
	post_repo.delete_post(post_id)
	return ok()