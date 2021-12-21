from app.db_connect import db

reported_post_ref = db.collection(u'reported post')

def save(report_dict : dict):
    reported_post_ref.document().set(report_dict)
