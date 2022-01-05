from fastapi import APIRouter
from app.schemas.friend import SetRequestFriend, GetRequestedFriend, SetAcceptFriend
from app.controllers import friend_controller


router = APIRouter(tags=["friend"])

@router.post("/friend-request/create")
async def create_friend_request(request: SetRequestFriend):
	return friend_controller.set_request_friend(request)

@router.post("/friend-request/list")
async def get_list_comment(request: GetRequestedFriend):
	return friend_controller.get_requested_friend(request)

@router.post("/friend-request/accept")
async def edit_comment(request: SetAcceptFriend):
	return friend_controller.set_accept_friend(request)
