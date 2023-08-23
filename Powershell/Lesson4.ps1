<#
    Putting it together

    In Lesson 1 we went over common terminology in PowerShell, we also went over 
    some basic commandlets to help you get more information and storing information
    Get-Help Get-Member Creating a Variable
    
    In Lesson 2 we learned about Filtering, Lists, Hashtables, TXT Files, CSV Files, and JSON Files.
    Reading and Writing to those files as well
    
    In Lesson 3 we talked about Logic and what you need to think through before you start writing.
    We also talked about If, Else, Elseif, Switch, Looping and lastly creating a basic PowerShell function.

    A Function should do one thing - This doesn't mean it can't do multiple things it means it should 
    return one thing. An Example would be I have a script that will read from multiple sources and then do 
    multiple things with that data, but my result should be the same 

    So what can you do with this now?
    We can go over some of our scripts or we can create new scripts with you.

    Advanced_Functions
    
    https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-7.2
    https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_parameters?view=powershell-7.2
    https://docs.microsoft.com/en-us/powershell/scripting/developer/module/how-to-write-a-powershell-script-module?view=powershell-7.2
    https://docs.microsoft.com/en-us/powershell/scripting/developer/module/how-to-write-a-powershell-script-module?view=powershell-7.2
    https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables?view=powershell-7.2
#>

# What version of Powershell are you running?
$PSVersionTable

# What is your executionpolicy and what does it mean?
Get-ExecutionPolicy

# Where do Powershell Modules Live?
$env:PSModulePath -split ";"

# How do you see what Modules are available?
Get-Module -listavailable

# What are the differences between Script Modules and Binary Modules?
# Script - you can find them and read them because they are a script
# Binary - you will need a DLL and if you want to read them you will need another tool to read them

# PSEdition - Core vs Desk
$PSEdition

# dot sourcing
. c:\temp\test.ps1

# Downloading scripts from unknown sources - Things t o question about downloading scripts
Unblock-File
