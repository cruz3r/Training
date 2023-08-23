<#
    Remote Execution
    https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/running-remote-commands?view=powershell-7.2
    https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/wsman-remoting-in-powershell-core?view=powershell-5.1
    https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/winrmsecurity?view=powershell-5.1
    https://docs.microsoft.com/en-us/windows/win32/winrm/portal
    WMI, RPC, and WS-Management, DCOM
    Port's to know
    HTTP: 5985
    HTTPS: 5986
    Kerberos
    NTLM
    CredSSP
    SecondHop
    SSL
    SSH - For Linux and Windows
    Synchronous and Asynchronous (Jobs)
    TroubleShooting - NetWork, Firewall Rules, WINRM
    API - 
#>

<#
    What is involved with PowerShell Remote Execution
    WINRM
#>
<#
    The asterisk is a wildcard symbol for all PCs. If instead you want to restrict computers that can connect, you can replace the asterisk with a comma-separated list of IP addresses or computer names for approved PCs
#>
Get-ChildItem WSMan:\localhost\Client\TrustedHosts

winrm get winrm/config
winrm quickconfig
<#
    Starts the WinRM service, and sets the service startup type to auto-start.
    Configures a listener for the ports that send and receive WS-Management protocol messages using either HTTP or HTTPS on any IP address.
    Defines ICF exceptions for the WinRM service, and opens the ports for HTTP and HTTPS.
#>
# Credentials
$cred = Get-Credential

# Start and end an interactive Session
Enter-PSSession -ComputerName IRV-BIGNAVI01 -Credential $cred
Exit-PSSession
# Run a remote command
Invoke-Command -ComputerName IRV-BIGNAVI01, IRV-BIGNAVI02 -ScriptBlock { get-hotfix } -Credential $cred
# Run a Script
Invoke-Command -ComputerName IRV-BIGNAVI01, IRV-BIGNAVI02 -FilePath C:\Users\michael.cruz\Documents\Training\powershell-training\Lessons\Lesson6Example.ps1 -Credential $cred

# Persistent Connections
Get-PSSession
$session = New-PSSession -ComputerName irv-ops-tsk01 -Credential $cred
$session
# Interesting things to note - It is running in it's own Runspace this will take up resources
Invoke-Command -Session $session { $SchTask = Get-ScheduledTask }
$SchTask # Will not work because it is only stored on the session
Invoke-Command -Session $session { $SchTask | select-object TaskName, State }
Invoke-Command -Session $session { $SchTask | Where-Object TaskName -match  "New hire process" | Get-ScheduledTaskInfo }
Get-PSSession
Remove-PSSession -Session $session

# API's

# I can get all of the information from the portal why do I need to learn about API's?
Took me too long to login and get information from It
Getting information for multiple Servers
Automation
# I only have to do this once in a while what is the benefit of this?
I can script it based on Criteria to update me rather than me go look for it
# Why not use the PS or command line tools for this?
None I would use what ever is easiest cause I am LAZY
# Is it easy to get started with them?

# What are the drawbacks of using an API?

<#
    https://www.postman.com/
    https://rubrikinc.github.io/api-doc-v2-6.0/#section/OpenAPI
    https://portal.nutanix.com/page/documents/details?targetId=Prism-Central-Guide-Prism-vpc_2022_4:mul-rest-api-explorer-pc-t.html
    https://docs.microsoft.com/en-us/azure/active-directory/develop/microsoft-graph-intro
    https://developer.microsoft.com/en-us/graph/graph-explorer
    Show various API's and talk about why I use them. 
#>
