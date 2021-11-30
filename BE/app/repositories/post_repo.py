from app.db_connect import db

post_ref = db.collection(u"posts")

def create(post : dict):
	post['comments'] = None
	post['likes'] = None
	post['content'] = None
	post['files'] = None
	print("created a new post")
	post_doc = post_ref.document()
	post_doc.set(post)
	return post_doc.id

def update(id :str, post : dict):
	if find_by_id(id) is None:
		return None
	post_ref.document(id).set(post)
	return

def find_all():
	post_docs = post_ref.get()
	result = []
	for post in post_docs:
		result.append(post.to_dict())
	return result

def find_by_id(id : str):
	post_docs = post_ref.document(id).get()
	return post_docs.to_dict()

def find_all_by_user_id(user_id : str):
	post_docs = post_ref.get()
	results = []
	for post in post_docs:
		if post['user_id'] == user_id:
			results.append(post.to_dict())
	return results

def delete_post(post_id : str):
	post_ref.document(post_id).delete()

