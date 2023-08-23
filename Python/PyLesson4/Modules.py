'''
Basics of Python Modules?
- Modules can contain Functions, Classes, and Variables. It can also contain runnable code.
- What defines a module?
    - A Module will have a .PY extension
    - There is the Module Name and then the Function name
    - A Module can be a stand alone file or part of a package
- Modules should follow these guidelines
    - Simplicity - A module does not have to do all of the things just focus on the task you need it to do.
    - Maintainability - Is your module readable, can it be updated? 
    - Reusability - Do you have hard coded things in your code? Path's, Names, applications. Eliminate duplicating code.
    - Scoping - Avoid Naming and / or duplicating identifiers.
What is a Python Package

Json

Links
https://docs.python.org/3/tutorial/modules.html
https://pypi.org/
https://packaging.python.org/en/latest/key_projects/#virtualenv
https://docs.chocolatey.org/en-us/features/shim
https://docs.python-requests.org/en/latest/
https://jsonlint.com/
https://www.rfc-editor.org/rfc/rfc7159#section-11
'''
import os

def cls():
    os.system('cls')

cls()

import sys

sys.modules
# in Lesson 3 we went over Data Structures - What is the data structure of sys.modules?
# How can you tell what the Data Structure is by looking at it?

print(type(sys.modules))

for x in sys.modules:
     print(x)

print(sys.modules['hello'])
print(sys.modules['re'])
     
import hello
'''
    __pycache__ is a directory that is created by the Python interpreter when it imports a module. 
    It contains the compiled bytecode of the module, which can be used to speed up subsequent imports of the same module. 
    The bytecode is specific to the version of Python that was used to generate it, 
    so different versions of Python will create different bytecode files.
'''
'''
    pip, choco, brew, yum, apt, NuGet 
    These are examples of a Package Manager
    
    A package manager is a collection of software tools that automates the process of 
    installing, upgrading, configuring, and removing computer programs
    
    pip inspect
    choco source list
    It's useful to understand the source of the packages. 
    There are restrictions on some of these that can impact you in various ways.
    
    Shim - Symlinks Choco uses a Shim to manage the packages that you install with it. 
    These Packages are not installed like regular Windows software. 
    C:\ProgramData\chocolatey\.chocolatey

'''
# pip search requests
# pip download 
# pip install
# pip uninstall
# pip install --upgrade pip
# pip list requests --verbose
# pip show requests

'''
    Json
    PS Gotcha
    Get-Service | ConvertTo-Json | out-file C:\Temp\python\test3.json
    Get-Service | ConvertTo-Json | out-file C:\Temp\python\test3.json -Encoding Default
    When your pulling data from different locations you may run into this.
    Get-Content 'C:\Temp\python\PrismServers.json' | Out-File C:\Temp\servers.json -Encoding default

    Python Gotcha
    Escaping characters \

'''

import json

# Json from another project. You can create your Json file based one item's that maybe useful to you
myJson = 'C:\\Temp\\python\\test1.json'

# read file Encoding was an issue I ran into
with open(myJson, 'r', encoding='utf-16') as myfile:
    data=myfile.read()

# parse file
obj = json.loads(data)

type(obj)

type(obj[0])

for x in obj:
    print(x)    

for x in obj:
    print(x['Name'], x['powerState'] )

for x in obj:
    for y in x:
        print( y,x[y])


print(json.dumps(obj, indent = 4, sort_keys=True))