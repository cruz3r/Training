'''
model.py
this is to help simulate a DB (Not a production model)
Would you like to know more?
https://flask-sqlalchemy.palletsprojects.com/en/3.0.x/
'''

import json

def load_db():
    with open("flaskcards_db.json") as f:
        return json.load(f)

def save_db():
    with open("flaskcards_db.json", 'w') as f:
        return json.dump(db, f)

db = load_db()