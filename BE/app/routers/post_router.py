from fastapi import APIRouter, Depends, Request, Header
from typing import Optional
from app.schemas.post import PostRequest
from app.controllers import post_controller


router = APIRouter(tags=["post"])

@router.post("/post/create")
async def create_post(post_info: PostRequest):
	return post_controller.create_post(post_info)

@router.post("/post/delete/{id}")
async def delete_post():
	return post_controller.delete_post(id)