from fastapi import APIRouter, Depends, Request, Header
from app.model.User import User
from app.controller import auth_controller
from app.dto.LoginRequest import LoginRequest
from typing import Optional


router = APIRouter(tags=["auth"])

@router.post("/signup")
async def signup(user: User):
	return auth_controller.create_user(user)

@router.post("/login")
async def login(login_request: LoginRequest):
	return auth_controller.login(login_request)

@router.get("/logout")
async def logout():
	return {"message": "logout"}

@router.get("/find-one")
async def find_one(phonenumber: str):
	return auth_controller.find_one_by_phonenumber(phonenumber)

@router.get("/find-all")
async def find_all():
	return auth_controller.find_all()

def test(login_request: LoginRequest):
	return True

@router.post("/test")
async def find_all(login_request: LoginRequest, verify: bool = Depends(test), token: Optional[str] = Header(None)):
	return {"phonenumber": login_request.phonenumber, "password": login_request.password, "token": token, "verify": verify}