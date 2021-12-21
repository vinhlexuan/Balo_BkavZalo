from fastapi.param_functions import Depends
from app.schemas.post import ReportPost
from app.schemas.post import PostRequest
from app.schemas.post import ListPostRequest
from app.repositories import post_repo, reported_post_repo, user_repo
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
	post_dict['author_id'] = payload['user_id']
	post_dict['can_comment'] = True
	post_dict.pop('token',None)
	id = post_repo.create(post_dict)
	return ResponseModel(code=1000, message='Success', data={
		'id' : id,
		'url' : 'url'
	})

def find_by_id(id : str, token : str):
	if post_repo.find_by_id(id) is None:
		# raise HTTPException(status_code=400, detail='9992')
		return ErrorResponseModel(None, 9992, '9992')
	post_dict = process_post_reponse(id, token)
	return ResponseModel(code=1000, message='Success', data=post_dict)

def update_post(id : str, post_info : PostRequest):
	if post_repo.find_by_id(id) is None:
		# raise HTTPException(status_code=400, detail='9992')
		return ErrorResponseModel(None, 9992, '9992')
	post_dict = vars(post_info)
	post_dict.pop('token', None)
	post_repo.update(id, post_dict)
	return ResponseModel(code=1000, message='Success', data=post_dict)

def get_list_post(request : ListPostRequest):
	request_dict = vars(request)
	results = post_repo.get_list_post(request_dict['last_id'], None, request_dict['count'])
	list_post_res = []
	for post_result in results:
		post_response = process_post_reponse(post_result.to_dict()['id'], request_dict['token'])
		list_post_res.append(post_response)
	print(list_post_res)
	return list_post_res

def delete_post(post_id : str):
	post_repo.delete_post(post_id)
	return ok()

def report_post(report_post : ReportPost):
	if post_repo.find_by_id(id) is None:
		# raise HTTPException(status_code=400, detail='9992')
		return ErrorResponseModel(None, 9992, '9992')
	reported_post_repo.save(report_post.dict())
	return ResponseModel(code=1000, message='Success', data=None)



# post_detail_response = {
#     'id' : None,
#     'describle' : None,
#     'created' : None,
#     'modified' : None,
#     'like' : None,
#     'comment': None,
#     'is_liked': None,
#     'image': None,
#     'video': {
#         'url': None,
#         'thumb': None
#     },
#     'author': {
#         'id' : None,
#         'name' : None,
#         'avatar' : None
#     },
#     'is_blocked' : None,
#     'can_edit': None,
#     'can_comment' : None
# }


def process_post_reponse(id : str, token: str):
	post_res = post_repo.find_by_id(id)
	payload = auth_handle.decode_token(token)
	post_detail_response = {}
	post_detail_response['id'] = post_res['id'],
	post_detail_response['describle'] = post_res['describle']
	post_detail_response['created'] = post_res['created']
	post_detail_response['modified'] = post_res['modified']
	post_detail_response['like'] = str(post_res['like']) if 'like' in post_res else None
	post_detail_response['comment'] = str(post_res['comment']) if 'comment' in post_res else None
	post_detail_response['is_liked'] = 'False'
	post_detail_response['image'] = str(post_res['image']) if 'image' in post_res else None
	post_detail_response['video'] = str(post_res['video']) if 'video' in post_res else None
	author = user_repo.find_by_phonenumber(payload['phonenumber']).to_dict()
	post_detail_response['author'] = {}
	post_detail_response['author']['id'] = author['phonenumber']
	post_detail_response['author']['name'] = author['username']
	post_detail_response['author']['avatar'] = author['avatar']
	post_detail_response['can_edit'] = 'True' if author['phonenumber'] ==  post_res['author_id'] else 'False',
	post_detail_response['is_blocked'] = 'False' if post_res['author_id'] in author['block_list'] else 'True'
	post_detail_response['can_comment'] = str(post_res['can_comment'])
	return post_detail_response