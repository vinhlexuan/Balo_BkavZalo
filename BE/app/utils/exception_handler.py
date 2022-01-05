from starlette.exceptions import HTTPException as StarletteHTTPException
from fastapi.responses import JSONResponse, PlainTextResponse
from fastapi.exceptions import RequestValidationError
from app.constants.constants import ERRORS


def custom_exception_handler(app):
	@app.exception_handler(StarletteHTTPException)
	async def http_exception_handler(request, exc):
		code = exc.detail
		return JSONResponse(status_code=exc.status_code, content={"code": code, "message": ERRORS[code]})

	@app.exception_handler(RequestValidationError)
	async def validation_exception_handler(request, exc):
		error_type = exc.errors()[0]["type"]
		status_code = 400
		code = "9997"	# Method is invalid

		print(error_type)

		if error_type == "value_error.missing":
			code = "1002"
	
		if error_type.startswith("type_error"):
			code = "1003"
	
		return JSONResponse(status_code=status_code, content={"code": code, "message": ERRORS[code]})