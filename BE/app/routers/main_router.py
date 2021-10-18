from fastapi import FastAPI
from app.routers import auth_router
from starlette.exceptions import HTTPException as StarletteHTTPException
from fastapi.responses import JSONResponse, PlainTextResponse
from fastapi.exceptions import RequestValidationError
from app.constants.constants import ERRORS


app = FastAPI()
app.include_router(auth_router.router, prefix= "/it4788")


@app.exception_handler(StarletteHTTPException)
async def http_exception_handler(request, exc):
    return JSONResponse(status_code=exc.status_code, content={"code": exc.detail, "message": ERRORS[exc.detail]})

@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request, exc):
	print(exc.errors()[0]["type"])
	if exc.errors()[0]["type"] == "value_error.missing":
		return JSONResponse(status_code=400, content={"code": "1002", "message": ERRORS["1002"]})
	
	return JSONResponse(status_code=400, content={"code": "9997", "message": ERRORS["9997"]})