from fastapi import APIRouter
from app.schemas.comment import CommentRequest, GetCommentRequest, EditCommentRequest, DeleteCommentRequest
from app.controllers import comment_controller


router = APIRouter(tags=["comment"])

@router.post("/comment/create")
async def create_comment(request: CommentRequest):
	return comment_controller.create(request)

@router.post("/comment/list")
async def get_list_comment(request: GetCommentRequest):
	return comment_controller.get_list_comment(request)

@router.post("/comment/edit")
async def edit_comment(request: EditCommentRequest):
	return comment_controller.edit_comment(request)

@router.post("/comment/delete")
async def delete_comment(request : DeleteCommentRequest):
	return comment_controller.delete_comment(request)