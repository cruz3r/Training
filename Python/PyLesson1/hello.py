"""
Python Types
What are Types? - A way to classify / categorize data

Numeric data types: int, float, complex
String data types: str
Sequence types: list, tuple, range
Binary types: bytes, bytearray, memoryview
Mapping data type: dict
Boolean type: bool
Set data types: set, frozenset

"""
import os

def cls():
    os.system('cls')

cls()

# Python --version

# print() allows you to print to screen
print("Hello World")

# Variables are case sensitive they can start with an underscore _ or a letter Aa can not start with a number can only contain AlphaNumeric characters

myMsg = "Hello World2"
print(myMsg)

myInt = 7
print(myInt)

# type() is a built-in function that is used to return the type of data stored in the objects or variables in the program

print(type(myMsg))

print(type(myInt))

# print(myInt + msg)

# print(msg + myInt)

#Declaring a type

myInt2 = int(7 + 3)
print(myInt2)
print(type(myInt2))

myList = []
myList.append(int)
myList.append(str)
myList.append(bool)
myList.append(list)

if isinstance(myInt, (myList[0], myList[1], myList[2])):
    print(isinstance( myInt, int))

if type(myInt) in myList:
    print("Exists")
else:
    print("Not Exists")

"""
We talked about installing Python
How are these different than Powershell?
Spacing is important in Python. You can see this more in larger scripts

"""    