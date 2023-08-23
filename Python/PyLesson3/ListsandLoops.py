# Read from list in previous lesson
with open("..\PyLesson2\Readfile.txt","r") as mylist:
    read_data = mylist.read()

# Read from list in in this lesson
with open("Readfile.txt","r") as mylist2:
    read_data2 = mylist2.read()

print("- read_data string -")
print(read_data)
print("- read_data2 string -")
print(read_data2)

# Loop through the second list and add it to the first list as a string
for x in read_data2 :
    read_data += x
# Because this is a string I am using the operator to add to the Variable read_data

print("\n+ read_data concactenate string +\n")
print(read_data)

# Going back to the type - We are now declaring a type of list rather than just string
varHello = ['GivenName', 'add to a list']
varHello.append("SurName")
print(varHello)

# rstrip removes trailing characters on the right side of the text what is to the right of the text?
# We are now reading the text file and for each line we are creating a type of lists
with open("Readfile.txt","r") as myList3:
    varLines = [varLine.rstrip() for varLine in myList3]

print("\n+ lines append 'World!' List +\n")
print(varLines) 

print("varHello  " + (type(varHello).__name__))
print("read_data " +  type(read_data).__name__)
print("read_data2  " + type(read_data2).__name__)
print("lines  " + type(varLines).__name__)