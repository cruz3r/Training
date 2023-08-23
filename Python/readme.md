## This is an introduction to Python.

The goal of this is to be a primer to install Python 3.x and talk about Python

Installing Python
Manually you can download and install Python from https://www.python.org/downloads/
- This will install IDLE, pip and documentation
- Select Customize
- My preferences is to install py launcher and pip (We will go over pip later)
- Idle is a development environment I am using VSCode but there are many Development Environments that you use (Integrated Development and Learning Environment)

- Chocolatey this is a PowerShell Package Manager
    - Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    - choco source add -n chocolatey -s 'https://chocolatey.org/api/v2/'
    - choco install python --force



Where else can you run Python?
Why would I need to learn Python?
Interperter vs Compiler - Powershell and Python use an Interperter unlike C, C++ and Java. Slower and take more resources than Compiled languages. 
Oppinionated Language
PY Environment - Modules PIP
PEP
run 
Python --version

Interesting Links 
https://education.minecraft.net/en-us/resources/computer-science-subject-kit/python-101
https://peps.python.org/pep-0008/#naming-conventions
https://github.com/pyenv/pyenv
https://fastapi.tiangolo.com/features/