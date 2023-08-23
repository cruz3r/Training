<#
    Practice: 
    - Create a Function
    - Use a parameter to get credential 
    - Use a Switch as a Parameter
    - Use IF Else ElseIf 
    - Use Filtering 
    - Return a powershell object
#>

function Get-MYScheduledTask {
    [CmdletBinding()]
    param (
        [pscredential]$cred,
        [parameter(HelpMessage="SchTasks Path",Mandatory=$true)]
        [validateset("Workday Tasks","Inventory")]
        [String]$SchTaskPath,
        [string]$ComputerName = "loc-ops-tsk01",
        [switch]$status
        
    )
    
    if (($cred.UserName -match ".sa") -and (!($status))){
        Write-Verbose $ComputerName
        
        Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            Get-ScheduledTask -TaskPath $args[0] | Select-Object PSComputerName, TaskName, State
        } -Credential $cred -ArgumentList "\$SchTaskPath\" 
        
        Write-Verbose "You chose $("\$SchTaskPath`\")"
    }elseif ( ($cred.UserName -match ".sa") -and ($status) ) {
        Write-Verbose $ComputerName

        Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            Get-ScheduledTask -TaskPath $args[0] | 
            Get-ScheduledTaskInfo | Select-Object PSComputerName, TaskName, LastRunTime, NextRunTime, LastTaskResult, NumberOfMissedRuns
        } -Credential $cred -ArgumentList "\$SchTaskPath\"

        Write-Verbose "You chose \$SchTaskPath\"
    }
    else{
        Write-Warning "Use your Priveleged Account"
    }
    
}


<#
    API Basics for PS
    Invoke-Restmethod - Sends an HTTP or HTTPS request to a RESTful web service.
    Invoke-Webrequest - Gets content from a web page on the internet.
    REpresentational State Transfer
    CRUD - Create, Read, Update, Delete
    Rest = Get, Post, Put, Patch, Delete
    read => GET
    Create NEW record => POST
    If the record exists then update else create a new record => PUT
    update/modify => PATCH
    delete => DELETE
    JSON
    XML
    HTML
#>

Invoke-RestMethod -Uri "https://icanhazdadjoke.com/" -Method "get" -Headers @{accept="application/json"}

Invoke-WebRequest -Uri "https://icanhazdadjoke.com/" -Method "get" -Headers @{accept="application/json"}

$restm = Invoke-RestMethod -Uri "https://icanhazdadjoke.com/" -Method "get" -Headers @{accept="application/json"}

$restm

$webr = Invoke-WebRequest -Uri "https://icanhazdadjoke.com/" -Method "get" -Headers @{accept="application/json"}

$webr

$webr.Content | convertfrom-json


<#
    Notes: https://swapi.dev/
#>