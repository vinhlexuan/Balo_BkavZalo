from fastapi import APIRouter, Depends, Request, Header
from app.controllers import auth_controller
from app.schemas.auth import LoginRequest, SignupRequest
from typing import Optional


router = APIRouter(tags=["auth"])

@router.post("/signup")
async def signup(signup_info: SignupRequest):
	return auth_controller.create_user(signup_info)

@router.post("/login")
async def login(login_request: LoginRequest):
	return auth_controller.login(login_request)

@router.get("/logout")
async def logout():
	return {"message": "logout"}


### FOR TEST ###
@router.get("/user/find-one")
async def find_one(phonenumber: str):
	return auth_controller.find_one_by_phonenumber(phonenumber)

@router.get("/user/find-all")
async def find_all():
	return auth_controller.find_all()

def test(login_request: LoginRequest):
	return True

@router.post("/user/test")
async def test_user(login_request: LoginRequest, verify: bool = Depends(test), token: Optional[str] = Header(None)):
	return {"phonenumber": login_request.phonenumber, "password": login_request.password, "token": token, "verify": verify}