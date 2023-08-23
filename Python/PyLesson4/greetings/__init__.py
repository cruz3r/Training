# Hello module for Python
import os

def cls():
    os.system('cls')

cls()

def hello(firstname):
    varGreetings = "Hello"
    if firstname:
        print(varGreetings + " " + firstname)
    else:
        print("Enter your name")

def goodbye(firstname):
    varGreetings = "Good Bye"
    if firstname:
        print(varGreetings + " " + firstname)
    else:
        print("Enter your name")