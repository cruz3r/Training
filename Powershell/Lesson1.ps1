<#
    PowerShell tips and tricks
    
    Terms to know:
    Verb-Noun - PS should be easy to read but it starts with understanding that your using a Verb describe an action or state and a Noun refers to a thing
    Module - A group of cmdlets that can be used for a common purpose (AD Module allows us to manage AD) Where are your Modules coming from? $Env:PSModulePath
    Cmdlet - A cmdlet is a lightweight command and typically return a Microsoft .NET object
    Object - PS is an Object Based language it has properties and methods that can be used in various way's
    Pipe - Symbol on the keyboard used to connect commands 
    Parameter - Input for your cmdlet
    Property - Return from your cmdlet / Object
    Method - Actions that can be applied to an Object
    Variables - Are used to store data Starts with a $ Doesn't use numbers or symbols to start the Variable
    Filter - Filtering Cmds should start to the left think of the data that is coming across the Pipe 
    Assignment_Operators - Get-Help About_Assignment_Operators There are many operators + * - / = ++ == They are used to perform actions
    Comments for PS - It's a good habbit to have comments in your code as it becomes more complex # sign for a single line for multiple lines 
    Aliases - Get-Alias An Alias is great for shorthand or typing in the cli but when it comes to a script try not to use them. 
    Scopes - Global, Local, Script
   
 #>
    
 

# Verb - Noun
Get-Verb # A list of common verbs and the group where you may see them used

Get-Module #
Get-Module -Name  Microsoft.PowerShell.Management 
Get-Module -Name  Microsoft.PowerShell.Management  | Select-Object -ExpandProperty ExportedCommands

# There are more Modules Available but don't get installed until they are called the Parameter ListAvailable will 
# show what and where they are being loaded from.
Get-Module -ListAvailable

# List Services on a Windows Computer
Get-Service
Get-Service | Get-Member 

Get-Help Get-Service -Parameter *
Get-Help Get-Service -Parameter name
get-help spooler 

# use the Property Name to return one Service
Get-Service | Where-Object name -eq "Spooler"

# Pipe to a command 
"Spooler" | Get-Service

# ** TIP ** Filter to the Left when possible
Get-Service -Name Spooler

Measure-Command {Get-Service | Where-Object name -eq "Spooler"}
Measure-Command {Get-Service -Name Spooler}

# Variable
$Spooler = Get-Service -Name Spooler
$Spooler.Status
$Spooler.Stop() # this will only work if you are running as an Admin
# Which one will return the status now
$Spooler.Status 
Get-Service -Name Spooler


# String's and  Operators
"Hello World" | GM # GM is the alias for Get-Member if this was in a script I would type out Get-Member if I am running it I would use GM

$MyVariable = "Hello World"
$MyVariable | Get-Member
# 
$MyVariable.Contains("Wo") # Returns a Boolean

$MyVariable2 = "   Hello World      "

# using the + Operator works on words as well as numbers but the characters need to be first
"MyVariable 2 has this many characters in it: " + $MyVariable2.Length 
"MyVariable 2 has this many characters in it Without the spaces on the front and end: " + $MyVariable2.Trim().Length
"MyVariable 2 has this many characters in it Without the spaces on the front: " + $MyVariable2.TrimStart().Length
"MyVariable 2 has this many characters in it Without the spaces on the end: " + $MyVariable2.TrimEnd().Length

$MyVariable.Split(" ") # Split the variable using a Space as the Separator
$a = $MyVariable.Split(" ")

$MyVariable.count
$a.Count
$a[0]
$a[1]


# Scopes the hidden gotcha

get-variable -scope local
get-variable -Scope global
$x = "Hello" # Is this Global, Local, or Script?
$y = "Busy"
$z = "Bee"

# a Basic Function with one parameter
function test-myScopes {
param (
    [string]$z
)
    get-date
    "This is coming in from the Local Scope it should not be here - " + $x
    "This is coming in from my Global Scope I may want this in my function " + $env:USERNAME 
    $rndServiceName = (get-service | get-random).name
    "This is the Local Scope interfering with the script scope " + $y
    $y = get-service -name $rndServiceName
    "This is the Script Scope which will not be availabel in the Local Scope " + $y
    "Z now = " + $z
}  

test-myScopes

# Update wha Z is
$randomCars = Get-Random "Toyota","Chevy","Ford","Tesla","Mercedes"
test-myScopes -z $randomCars

# Local Scope was not changed by Script Scope
$z

<#
    Tip - PowerShell is not case sensitive but may cause issues when your dealing with things that are case sensitive
    Reading from a Linux based System to a Windows Based System 
    fsutil.exe file queryCaseSensitiveInfo 'C:\Program Files'
#>
$mycase = "Michael","michael","MichaeL"

$mycase | Select-String -SimpleMatch "Michael"

$mycase | Select-String -CaseSensitive "Michael"

