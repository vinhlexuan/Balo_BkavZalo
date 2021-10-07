import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from app.constants.constants import USER_DB

cred = credentials.Certificate(USER_DB)
firebase_admin.initialize_app(cred)
db = firestore.client()
