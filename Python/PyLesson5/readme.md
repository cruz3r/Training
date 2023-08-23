# Python - Virtual Environment 

Why is it useful to use a virtualenv?
- Separate your packages from the system
- Makes it easy to reproduce what you are using
- Keeps dependencies from being over written

Show the install of virtualenv
pip list  
pip install virtualenv  

Show the creation of a virtualenv folder
mkdir .\myVenv
python -m venv .\myVenv\myAppName

Show the contents of the folder 
ls .\myVenv\myAppName

Activate the virtualenv  
(I am using ps so will use the ps actavate.ps1)
. .\myVenv\myAppName\Scripts\Activate.ps1
(Notice the change in the Console Window)
pip list

Install your python package
python -m pip install flask
(once flask is installed I can save it to a requirements.txt)
pip freeze > requirements.txt
(I can use the requirements.txt later for others to do the install and manage the Versions)
pip install -r requirements.txt

We can now deactivate our virtualenvironment
deactivate 
(this command was imported when we made our virtual environment)

---

Flask Demo

The rest of the demo is showing importing modules / Flask and the differences of using a virtualenvironment

Why I chose Flask?

Notice the Flask import error in VSCode:
VSCode CTRL SHIFT P
Select your interpreter
Why would you need multiple interpreters?

Flask / Jinja - Is this a different language?

Show Previous Button and StartOver Button

What Use Case can you come up with 

Links
https://docs.python.org/3/tutorial/venv.html
https://jinja.palletsprojects.com/en/3.1.x/
https://flask.palletsprojects.com/en/2.2.x/
https://flask-sqlalchemy.palletsprojects.com/en/3.0.x/
https://fastapi.tiangolo.com/

