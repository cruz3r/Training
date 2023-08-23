"""
Operators
Input and Output
"""
# Operators
# +, -, /, %, **, //
3 + 3

# Assignment Operators
# =, +=, -=, *=, /=, %=, //=, **=, BitWise  &=, |=, ^=, >>=, <<=
x = 3
print(x)
x += 4
print(x)

# Comparison Operators
# ==, !=, >, <, >=, <=
x == 3

# Logical Operators
# and, or, not
x == 3 and x > 2 
x == 3 or x < 9

# Identity operators
# is, is not
myList = []
myList.append("John")
myList.append("Ringo")
myList.append("Paul")
myList.append("George")
varName = "Ringo"
myList[1] is varName

# Membership Operators
# in, not in
"John" in myList


# Bitwise Operators
# &, |, ^, ~, <<, >>
(3<<3) + 3
3 * 9
''' 
I have only used Bitwise Operators once before, but its dealing with Binary
used for higher level programs / communication with hardware and registers
12 = 0 0 0 0 1 1 0 0
13 = 0 0 0 0 1 1 0 1
12 & 13 = 12 - Example of & ampersand (and) return all of the matching bits
12 | 13 = 13 - Example of | pipe (or) return all of the on bits
'''


