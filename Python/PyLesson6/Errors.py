'''
Error handling
and thinking through your data
Links
https://docs.python.org/3/tutorial/errors.html
https://www.w3schools.com/python/python_ref_exceptions.asp
'''
# CLS
import os

def cls():
    os.system('cls')

cls()


# Using a While Statement and planning to break out of it
# Why would I need to break out of a loop?
# What are some different things you can use as a counter?
''' 
Time Sleep
Return of a value
'''


myVari = 0 # This will be used as my counter
myVargt = 5 # This is the value to stop my counter greater than
myVarx = None # A null variable that will be used later

while (myVari < myVargt): # While Statement - While this is true do the following
    print(myVari)
    myVari += 1 # Increment the int variable
    try: # Try the following code
        myVarx = int(input("Please enter a number\n")) # We are asking for a number declaring int() 
        break # Break out of the Try if the input matches an int
        
    except ValueError: # Create an error and a custom message
        myVarmsg = "Oops! That is not a number! Try Again? You have " + str(myVargt - myVari ) + " Times left."
        print(myVarmsg)
        
    finally:
        print("Your number is " + str(myVarx))


''' At some point you may want to create an error based on 
    what you think needs it and then take action on that error
'''    
# Raising an error
myVar2 = None # an Empty Variable
if not (myVar2):
    raise NameError("here is my error " + str(myVar2))
else:
    print("Results of myVar2 " + myVar2 )     


# how do you deal with an error when you know it will be there but just need to pass over it?
# using Pass to pass on the error
myVari = 0
while (myVari <= 10 ):
    try:
        myVari += 1
        print(myVari)
        if (myVargt == myVari): # We assigned the variable as an int previously
            raise TypeError(str(myVargt) + " does not equal " + str(myVari) + " - Break out of the loop")
        else:
            print("Results " + str(myVargt) + " Not = to " + str(myVari))
        if (myVari == 9):
            raise NameError("A different type of error")
    except (NameError):
        print("An exception occurred")
        pass 


# Adding a note to an exception
try:
    x = int(input("Please enter a number: "))
    isinstance(x, int)
except ValueError as e:
    e.add_note("Oops!  That was no valid number.")
    e.add_note("var x is not type int")
    raise