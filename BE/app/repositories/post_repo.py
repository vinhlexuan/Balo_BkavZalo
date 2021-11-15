from app.db_connect import db

post_ref = db.collection(u"posts")

def create(post : dict):
	post['comments'] = None
	post['likes'] = None
	post['content'] = None
	post['files'] = None
	post_ref.document().set(post)
	print("created a new post")

def find_all():
	post_docs = post_ref.get()
	result = []
	for post in post_docs:
		result.append(post.to_dict())
	return result

def find_all_by_user_id(user_id : str):
	post_docs = post_ref.get()
	results = []
	for post in post_docs:
		if post['user_id'] == user_id:
			results.append(post.to_dict())
	return results

def delete_post(post_id : str):
	post_ref.document(post_id).delete()

