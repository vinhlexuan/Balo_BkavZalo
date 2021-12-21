from fastapi import APIRouter, Depends, Request, Header
from typing import Optional
from app.schemas.post import PostRequest, ListPostRequest
from app.controllers import post_controller


router = APIRouter(tags=["post"])

@router.post("/post/create")
async def create_post(post_info: PostRequest):
	return post_controller.create_post(post_info)

@router.get("/post/find_by_id")
async def find_by_id(id : str, token: str):
	return post_controller.find_by_id(id, token)

@router.post("/post/update")
async def update_post(id : str,post_info: PostRequest):
	return post_controller.update_post(id,post_info)

@router.post("/post/delete")
async def delete_post(id : str):
	return post_controller.delete_post(id)

@router.post("/post/list_post")
async def create_post(request: ListPostRequest):
	return post_controller.get_list_post(request)