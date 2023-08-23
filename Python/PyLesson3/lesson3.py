'''
    Go over Data Structures: 
    Lists - A collection of items that are Ordered, Mutable, Can be different data types, does not have to be unique
    Tuples - A collection of items that are Ordered, Immutable, Can be different data types, does not have to be unique
    Sets - A collection of items that are UnOrdered, Immutable, Can be different data types, must be unique
    Dictionay - A collection of items that are Ordered (after ver 3.6), Mutable, can be different data types, must be unique

    https://docs.python.org/3/tutorial/datastructures.html#
'''
import os

def cls():
    os.system('cls')

cls()

# List starts with a [] Square Bracket
myList = [3, 6, 9, 12, 'Hello', 'Hello']
print(myList)
print(type(myList))
myList[-1] = "goodbye"
myList.append("NewItem")

# Tuple starts with () Parenthesis
myTuple = (3, 6, 9, 12, 'Hello', 'Hello')
print(myTuple)
print(type(myTuple))
myTuple[-1] = "goodbye"
myTuple

# Set starts {} Curly Braces
mySet = {3, 6, 9, 12, 'Hello', 'Hello'}
print(mySet)
print(type(mySet))

# Dictionary also starts with {} Curly Braces but are defined with a : Colon
myDictionary = {'FirstName':'Michael','LastName':'Cruz','myKey':'myValue'}
myDictionary['FirstName']
myDictionary['LastName']
print(type(myDictionary))

# pop Remove's the Key Value Pair based off the Key
myDictionary.pop('myKey')
# Updating an existing 
myDictionary.update({'myKey': 'myNewValue'})
myDictionary['myKey'] = 'anotherNewValue'

set("hello")
list("hello")
tuple("hello")
dict({"key":"value"})