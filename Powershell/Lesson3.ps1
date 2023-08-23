<#
    Logic - Take some time to think through what you want or PieceMeal it
    If, Else, Elseif - help about_if - Go over Boolean logic 
    Switch - help about_Switch -Statements 
    Going through a list -  What options do we have for Looping through a list
    Functions - about_Functions - When does it make sense to create a function 
#> 

<#
    Why are you creating a script a Function or just using a PS Commandlet?
    Most of it starts with I want to get or do something based on information that I have or can get.
    An example starts out as a request to do something - I get a ticket and in that ticket it has some
    information that can get me started.
#>

# What is a Boolean?
# If Statements have a test and a result if you don't account for the test results what will happen?

If ($true){"This Was a True Statement"}Else{"This was a False Statement"}
$a = 5
$b = 4
$c = 3
If ($a -gt $b){
    "A is Greater than B"
    }elseif($b -gt $c){
        "B is Greater than C"
    }else{
        "The other 2 statements failed but we did not compare c to anything"
    }

# Switch is simmilar to an if else but allows you some more options

$giveMeaName = Read-Host "Enter your name"
switch ($giveMeaName){
    "Michael" {"you Picked a"}
    "Kazzy" {"you Picked b"}
    "Manuel" {"you Picked c"}
    Default {"No Options"}
}

# Going through the list - What I mean here is when you have a list you need to go through that list and do things

$myList = (
    "michael.cruz",
    "ed.silva",
    "kazzy.kazeem",
    "manuel.gonzalez"
    )

Foreach ($person in $myList){
    $user = get-aduser -Identity $person| Select-Object givenname, enabled 
    "Hello " + $user.GivenName + " your account is " + $user.Enabled
    Start-Sleep -Seconds 1.5
}

$person = $null
$myList | ForEach-Object {
    "hello $_"
    Start-Sleep -Seconds 2.5
}


1..10
$i = 0
Do {
    $i++
    "I will count $i till I reach 10"
} until ($i -eq 10 )

Start-process notepad

$processName = "notepad"
$i = 0
Do {
    "$processName found at $(get-date)"
    $proc = Get-Process -Name notepad
    $i
    $i++
    start-sleep 2
} until (($proc.name -notcontains 'notepad') -or ($i -ge 3)) 

# Functions - A function is simmilar to a Cmdlet you can create a custom function that is as complex as you need it to complete the task
Function get-myname {
    param(
        [string]$myName 
    )
    $user = Get-aduser $myName
    "hello " + $user.givenname
}