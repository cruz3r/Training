'''
    https://peps.python.org/pep-0020/
    https://docs.python.org/3/library/functions.html#open
    https://docs.python.org/3/tutorial/inputoutput.html#tut-files
    https://en.wikipedia.org/wiki/Windows-1252
    https://www.utf8-chartable.de/

'''
# Open a text file as read only using encoding utf-8 
# Why is Encoding important?
myFile = open("Readfile.txt","r",encoding="utf-8")
myLines = myFile.readlines()
print(myLines)
myFile.close()
print("\n")

# open a text file as read only and print the first line readlines vs readline
myFile2 = open("Readfile.txt","r")
line1 = myFile2.readline()
print(line1)
myFile2.close()
print("\n")

# open a text file as read only and print each line while the new line is true - Boolean
myFile3 = open("Readfile.txt","r")
while True:
    next_line = myFile3.readline()
    if not next_line:
        break;
    print(next_line.strip())

print("\n")
myFile3.close()

# open a text file as read only and loop through each line in myFile4 - Print line until the end "" 
# (Return characters can be an issue)
myFile4 = open("Readfile.txt","r")
for line in myFile4:
    print(line, end="")
    #print(line)#, end="")

print("\n")
myFile4.close()

# with (open this file) as myVariable - Then perform this action create a variable from the myFile5 read
# Afterwards print the variable to the screen
with open("Readfile.txt","r") as myFile5:
    read_data = myFile5.read()

print(read_data)    

# Notice I do not need to close the file

'''
Which Method do you prefer?
Why is it important to close the files?
Why is Encoding important?
Why did we select read?

We looked at quite a few things here
Reading from a file
Looping through each line of a file
using a boolean to find the end of a file
Selecting the Encoding of a file

We looked at input from the command line
We went through Different types of Operators

Before we get into Modules it's a good idea to get comfortable with these items

'''

