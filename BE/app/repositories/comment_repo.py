from firebase_admin import firestore
from app.db_connect import db

comment_ref = db.collection(u'comments')

def create(comment : dict):
    comment['created'] = firestore.SERVER_TIMESTAMP
    comment['modified'] = firestore.SERVER_TIMESTAMP
    comment_doc = comment_ref.document()
    comment['id'] = comment_doc.id
    comment_doc.set(comment)
    return comment_doc.get().to_dict()

def get_list_comment(post_id : str, index : int, count : int):
    query = comment_ref.where(u'post_id','==',post_id).order_by(
        u'created', direction=firestore.Query.DESCENDING).limit(int(count))
    results = query.stream()
    return results