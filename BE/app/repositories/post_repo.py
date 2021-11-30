from datetime import datetime
from BE.app.schemas.post import PostResponse
from app.db_connect import db

post_ref = db.collection(u"posts")

def create(post : dict):

	post['created'] = datetime.now().timestamp()
	post['modified'] = datetime.now().timestamp()
	print("created a new post")
	post_doc = post_ref.document()
	post_doc.set(post)
	return post_doc.id

def update(id :str, post : dict):
	if find_by_id(id) is None:
		return None
	post['modified'] = datetime.now().timestamp()
	post_ref.document(id).set(post)

def find_by_id(id : str):
	post_doc = post_ref.document(id).get()
	post_reponse = PostResponse(post_doc.to_dict())
	return post_reponse

# def find_all_by_user_id(user_id : str):
# 	post_docs = post_ref.get()
# 	results = []
# 	for post in post_docs:
# 		if post['user_id'] == user_id:
# 			results.append(post.to_dict())
# 	return results

def get_list_post(index : int, count : int):
	post_docs = post_ref.stream()
	result = post_docs[index:(index + count)]
	return result
	
def delete_post(post_id : str):
	post_ref.document(post_id).delete()

