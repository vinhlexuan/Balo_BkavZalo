from firebase_admin import firestore
from app.db_connect import db

friend_request_ref = db.collection(u'friend_request')

def create_friend_request(friend_request : dict):
    friend_request['created'] = firestore.SERVER_TIMESTAMP
    friend_request_ref.document().set(friend_request)

def find_all_requested_friend(user_id : str, count : str):
    query = friend_request_ref.where(u'user_id','==',user_id).order_by(
        u'created', direction=firestore.Query.DESCENDING).limit(int(count))
    results = query.stream()
    return results

def delete(request_id : str, user_id : str):
    query = friend_request_ref.where(u'request_id','==',request_id).where(
        u'user_id','==',user_id)
    results = query.stream()
    for result in results:
        result.reference.delete()
