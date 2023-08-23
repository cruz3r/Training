<#
    WMI and CIM
    Windows Management Instrumentation / Common Information Model
    WMI is installed by default on all Windows OS. WMI Providers may not be installed for certain configurations 
    IE: If you don't install a Windows Feature it may not have the WMI Provider
    What is the purpose of WMI and CIM?
    Allows access to Management information for the OS as well as Applications. Has Methods to provide some 
    control as well. Simmilar to an API
    DCOM / WinRM - Methods of communication
    Powershell made scripting with WMI and CIM easy and allows us to pull information from the OS and Applications 
    and use it with in our scripting.
    Get-WmiObject supersceded by Get-CimInstance
    -- leaving Get-WmiObject in this because it still works on older OS's 
    WQL - writing querries you will have to use WQL and not powershell for the Query
    
    https://learn.microsoft.com/en-us/windows/win32/wmisdk/wmi-start-page
    https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-wmiobject?view=powershell-5.1
    https://learn.microsoft.com/en-us/powershell/module/cimcmdlets/get-ciminstance?view=powershell-5.1
    https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_cimsession?view=powershell-7.2#when-to-use-a-cim-session
#>

WBEMTEST

get-wmiobject -ClassName win32_bios 
Get-CimInstance -Namespace root -ClassName __Namespace
Get-CimInstance -ClassName win32_bios

$pwsh = Get-CimInstance -Query "SELECT * from Win32_Process WHERE name LIKE 'Pwsh%'"
$pwsh[0] 
$pwsh[0] | select-object * | Format-List 

Get-Process -Id $pwsh[0].ProcessId 
Get-Process -Id $pwsh[0].ProcessId | Select-Object * | Format-List

(get-wmiobject -Query "SELECT * from Win32_Process WHERE name LIKE 'Pwsh%'")[0] | Select-Object * | Format-List

# CimSession vs PSSession
get-help about_cimsession
<# 
    There are a few things that are interesting in this information.
    Understanding that the network connection and what is needed for this 
    to work depends on your environment. Older Environment (OS) If you are looking at the clients
    you are connecting to knowing that information can impact what you can 
    or will use.
    Local Client Side Object / Does not open a network connection until needed / Does not require PowerShell
    (PowerShell at this time should be availble on all current Window's OS now)
    PSSession Runs on target computer / it requires PowerShell / Sends data back to the client

    Data is returned both ways but the processing is different
    
#>

# Run as account with permissions
$cred = Get-Credential
$server = 'loc-bignavi01'

# New-CimSessionOption allows you to specify any specific options that are needed
$newCimmSessionOption = New-CimSessionOption -Protocol Dcom
Measure-Command -Expression {
    $session2 = New-CimSession -ComputerName $server -Credential $cred -SessionOption $newCimmSessionOption
    Get-CimInstance -ClassName Win32_Process -CimSession $session2 
}

Measure-Command -Expression {
    Get-CimInstance -ClassName Win32_Process -CimSession $session2    
}
# Measure a CimSession and use that CimSession
Measure-Command -Expression {
    $session = New-CimSession -ComputerName $server -Credential $cred
    Get-CimInstance -ClassName Win32_Process -CimSession $session    
}

# What is in the session
$session
# Measure an existing CimSession
Measure-Command -Expression {
    Get-CimInstance -ClassName Win32_Process -CimSession $session    
}

# See the results of the command
$session = New-CimSession -ComputerName $server -Credential $cred
Get-CimInstance -ClassName Win32_Process -CimSession $session

# Measure Invoke-Command to retrieve the results
Measure-Command -Expression {
    Invoke-Command -ComputerName $server -Credential $cred -ScriptBlock {
        Get-CimInstance -ClassName Win32_Process
    }
}

# See the results of the command
Invoke-Command -ComputerName $server -Credential $cred -ScriptBlock {
    Get-CimInstance -ClassName Win32_Process
}

Get-PSSession # No sessions at this time
# Measure a PowserShell Session using invoke command
Measure-Command -Expression {
    $newpssession = New-PSSession -ComputerName $server -Credential $cred
    Invoke-Command -Session $newpssession -ScriptBlock {
        Get-CimInstance -ClassName Win32_Process
    }
}

#Now there is a session
Get-PSSession

# Measure existing PowerSell Session using invoke command
Measure-Command -Expression {
    Invoke-Command -Session $newpssession -ScriptBlock {
        Get-CimInstance -ClassName Win32_Process
    }
}
<#
    Why is this important?
    Speed
    Protocol DCOM / WSMAN (Accessibility)
    Able to select connection options 
    OS Responses (Older OS, does it have the latest updates for powershell)
    Log on to server disable winrm - Go back to explain DCOM vs WSMAN
#>


<#
    Get-CimAssociatedInstance
    This is a relationship between one instance and another instance within CIM

    Example: win32_logicaldisk has multiple classes that use it. Like a DB it's pulling specific properties 
    and will use that information in different area's
#> 

$disk = Get-CimInstance -ClassName Win32_LogicalDisk -KeyOnly
Get-CimAssociatedInstance -InputObject $disk[0] 
# notice that after running the command above we can see that multiple classes were returned
(Get-CimAssociatedInstance -InputObject $disk[0] | Get-Member).TypeName | select-object -Unique
# Now we can see the Types for each class that was associated to win32_logicaldisk
Get-CimAssociatedInstance -InputObject $disk[0] -ResultClass Win32_DiskPartition 
# By using the -ResultClass Parameter we can call a single associated instance

<#
    the example below is simmilar to the one above the difference here is that 
    we are looking at services you can open up services and look at the dependencies
#>
$s = Get-CimInstance -Query "Select * from Win32_Service where name like 'Winmgmt'"
Get-CimClass -ClassName *Service* -Qualifier "Association"
$c.CimClasName
Get-CimAssociatedInstance -InputObject $s -Association Win32_DependentService

<#
    Methods
    Here I am using win32_process to create an instance of notepad and saving the 
    information into the Variable $create. I then use that variable to terminate the 
    process.
    Depending on what Cim Class you call there will be different Methods this is 
    just one example
#>

$create = Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{CommandLine = 'notepad.exe'}
Invoke-CimMethod -Query "select * from Win32_Process where ProcessID = '$($create.ProcessID)'" -MethodName "Terminate"