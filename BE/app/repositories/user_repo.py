from app.model.User import User
from app.db_connect import db

user_ref = db.collection(u"users")

def create(user: User):
	user_ref.document(user.phonenumber).set(user.to_dict())
	print("create new user")

def find_by_phonenumber(phonenumber: str):
	user_doc = user_ref.document(phonenumber).get()
	return user_doc

def find_all():
	user_docs = user_ref.get()
	result = []
	for user in user_docs:
		result.append(user.to_dict())
	return result
