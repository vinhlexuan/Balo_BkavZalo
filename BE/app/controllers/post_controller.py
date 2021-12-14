from fastapi.param_functions import Depends
from fastapi import HTTPException
from app.schemas.post import PostRequest
from app.schemas.post import ListPostRequest
from app.repositories import post_repo, user_repo
from app.controllers.auth_controller import login
from app.auth.auth import AuthHandler
from app.utils.response import ResponseModel, ErrorResponseModel

auth_handle = AuthHandler()

def ok(data = None):
	res = {'code': '1000', 'message': 'OK'}
	if data is not None:
		res['data'] = data
	return res

def create_post(post_info : PostRequest):
	post_dict = vars(post_info)
	payload = auth_handle.decode_token(post_info.token)
	post_dict['user_id'] = payload['user_id']
	post_dict.pop('token',None)
	id = post_repo.create(post_dict)
	return ResponseModel(code=200, message='Success', data={
		'id' : id,
		'url' : 'url'
	})

def find_by_id(id : str, token : str):
	if post_repo.find_by_id(id) is None:
		# raise HTTPException(status_code=400, detail='9992')
		return ErrorResponseModel(None, 400, '9992')
	post_res = post_repo.find_by_id(id)
	post_dict = post_res.dict()
	payload = auth_handle.decode_token(token)
	if post_dict['user_id'] != payload['user_id']:
		post_dict['can_edit'] = True
	post_dict['can_comment'] = True
	post_dict['banned'] = False
	return ResponseModel(code=200, message='Success', data=post_dict)

def update_post(id : str, post_info : PostRequest):
	if post_repo.find_by_id(id) is None:
		# raise HTTPException(status_code=400, detail='9992')
		return ErrorResponseModel(None, 400, '9992')
	post_dict = vars(post_info)
	post_dict.pop('token', None)
	post_repo.update(id, post_dict)
	return ResponseModel(code=200, message='Success', data=post_dict)

def delete_post(post_id : str):
	post_repo.delete_post(post_id)
	return ok()

