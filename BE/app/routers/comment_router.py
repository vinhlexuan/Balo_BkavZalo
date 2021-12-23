from fastapi import APIRouter
from app.schemas.comment import CommentRequest, GetCommentRequest
from app.controllers import comment_controller


router = APIRouter(tags=["comment"])

@router.post("/comment/create")
async def create_post(request: CommentRequest):
	return comment_controller.create(request)

@router.post("/comment/list")
async def create_post(request: GetCommentRequest):
	return comment_controller.get_list_comment(request)