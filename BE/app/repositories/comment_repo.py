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

def get_list_comment(post_id : str, index : str, count : str):
    query = comment_ref.where(u'post_id','==',post_id).order_by(
        u'created', direction=firestore.Query.DESCENDING).limit(int(count))
    results = query.stream()
    return results

def find_comment_by_id(id_com : str):
    return comment_ref.document(id_com).get().to_dict()

def edit_comment(id_com : str, comment : str):
    comment_ref.document(id_com).set({
        'comment': comment,
        'modified' : firestore.SERVER_TIMESTAMP
    }, merge = True)

def delete_comment(id_cmt : str):
    comment_ref.document(id_cmt).delete()

def delete_by_post_id(post_id : str):
    query = comment_ref.where(u'post_id','==',post_id)
    results = query.stream()
    for result in results:
        result.reference.delete()