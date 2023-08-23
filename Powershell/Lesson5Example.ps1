<# 
    Example Script
#>

<# 
    This is an example of Streams - A Stream can be displayed on the screen but may interfere with your results 
    if your goal is to produce an Object
 #>
 # Write-host "This is writing to the work stream if I use this it may interfere with the script" -ForegroundColor green
 # Write-Output "The Output stream if I use this it may interfere with the script"
 # Write-Warning "The Warning stream"
 # Write-Information "The Information stream" -InformationAction Continue
 # Write-Verbose "Verbose Message - This is the middle of the script" -Verbose

# Here is and example of a function in a script this will go to our logging
 function writelog ($message) {
    [string]$(get-date) + ": " + $message | out-file c:\temp\myFunctionLog.txt -Append 
}

# Comment out the computernames to test
# Good 
$ComputerName = "rdp-esilva"
# Bad
# $ComputerName = "ABadComputerName"

<#
    Try Catch - You are trying to run a section of code and if it is a stopping error (Non terminating error)
    then go to Catch
    Is there an error that is not a stopping error in Powershell?
    Talk about $ErrorActionPreference
#>
try{
    $myErr = $null ; $comp = $null ; $ping = $null
    $comp = get-adcomputer -Identity $ComputerName -properties OperatingSystem -ErrorAction Stop
    $ping = Test-NetConnection $ComputerName -InformationLevel Quiet -Hops 1 -ErrorAction Stop
}Catch{
    write-warning -message "An Error Occurred"
    $_
    $Error[0]
    $myErr = $Error[0].Exception.Message
    $myErr
}

$results = [PSCustomObject]@{
    ComputerName = $ComputerName
    Enabled = [string]$comp.Enabled
    Errors = $myErr
    Ping = $ping
}

$results
if ( $null -ne $results.Errors){
    writelog -message "ComputerName: $ComputerName Error: $($results.Errors)"
} else {
    writelog -message "ComputerName: $ComputerName Passed:  $($results.Enabled)  $($results.Ping)"
}  
    

