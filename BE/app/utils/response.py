def ResponseModel(code, message, data, count=None):
    if count:
        return {
            "count": count,
            "data": data,
            "code": code,
            "message": message,
        }
    else:
        return {
            "data": data,
            "code": code,
            "message": message,
        }

def ErrorResponseModel(error, code, message):
    return {"error": error, "code": code, "message": message}