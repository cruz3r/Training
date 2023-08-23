from flask import (Flask, render_template, abort, jsonify, request, 
    redirect, url_for)
from datetime import datetime
from model import (db, save_db)

# Global Flask constructor
app = Flask(__name__)

# Changes it from a function to a view function
# @ is a decorator / is the url path Root
@app.route("/")
# Function
def welcome():
    return render_template(
        "welcome.html",
        message="Jinja Message",
        cards=db

        )

@app.route("/card/<int:index>")        
def card_view(index):
    try:
        card = db[index]
        return render_template(
            "card.html", 
            card=card,
            index=index,
            max_index=len(db) -1
        )
    except IndexError:
        abort(404)

@app.route("/api/card/")
def api_card_list():
    return jsonify(db)

@app.route('/api/card/<int:index>')
def api_card_detail(index):
    try:
        return db[index]
    except IndexError:
        abort(404)

@app.route('/add_card', methods=["GET","POST"])
def add_card():
    try:
        if request.method == "POST":
            # Form has been submitted
            card = {"question":request.form['question'],
                "answer":request.form['answer']}
            db.append(card)
            save_db()  
            return redirect(url_for('card_view', index=len(db) -1))
        else:
            return render_template("add_card.html")
    except IndexError:
        abort(404)

@app.route('/remove_card/<int:index>', methods=["GET","POST"])
def remove_card(index):
    try:
        if request.method == "POST":
            del db[index]
            save_db()
            return redirect(url_for('welcome'))
        else:
            return render_template("remove_card.html", card=db[index])
    except IndexError:
        abort(404)
    