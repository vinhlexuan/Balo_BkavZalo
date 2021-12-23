from calendar import c
from app.schemas.comment import GetCommentRequest
from app.schemas.comment import CommentRequest
from app.repositories import comment_repo, user_repo, post_repo
from app.auth.auth import AuthHandler
from app.utils.response import ResponseModel, ErrorResponseModel

auth_handler = AuthHandler()

def create(comment_req : CommentRequest):
    if post_repo.find_by_id(comment_req.id) is None:
		# raise HTTPException(status_code=400, detail='9992')
        return ErrorResponseModel(None, 9992, '9992')
    comment_dict = vars(comment_req)
    comment_dict['post_id'] = comment_req.id
    comment_dict.pop('index', None)
    comment_dict.pop('count', None)
    final_res = get_comment_response(comment_dict, 'create')
    return ResponseModel(1000,'Success',data=final_res)

def get_list_comment(get_comment_req : GetCommentRequest):
    request_dict = vars(get_comment_req)
    if post_repo.find_by_id(request_dict['id']) is None:
		# raise HTTPException(status_code=400, detail='9992')
        return ErrorResponseModel(None, 9992, '9992')
    results = comment_repo.get_list_comment(request_dict['id'], None, request_dict['count'])
    list_comment_res = []
    for result in results:
        comment_response = get_comment_response(result.to_dict(),'get_list')
        list_comment_res.append(comment_response)
    return list_comment_res

def get_comment_response(comment_dict : dict, process : str):
    payload = auth_handler.decode_token(comment_dict['token'])
    comment_poster = user_repo.find_by_phonenumber(payload['phonenumber']).to_dict()
    comment_dict['poster'] = {
        'id' : comment_poster['phonenumber'],
        'name' : comment_poster['username'],
        'avatar' : comment_poster['avatar']
    }
    cur_post = post_repo.find_by_id(comment_dict['post_id'])
    post_author = user_repo.find_by_phonenumber(cur_post['author']['id']).to_dict()
    res = comment_dict
    if process == 'create':
        comment_dict.pop('token', None)
        res = comment_repo.create(comment_dict)
    res['is_blocked'] = 'true' if comment_poster['phonenumber'] in post_author['block_list'] else 'false'
    return res