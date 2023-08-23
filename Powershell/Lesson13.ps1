<#
    Dot Sourcing
    Profiles
    Working with Modules
    
    Links:
    https://learn.microsoft.com/en-us/powershell/scripting/developer/module/understanding-a-windows-powershell-module?view=powershell-5.1
#>

<#
    Copy Paste a function into the console
    This will load the function into the memory for that console to use.
#>

notepad .\Lesson13\MyFunctions.ps1

<#
    PowerShell Dot Sourcing - Is just the referencing of a script (or Functions)
    You can use this in another script to call and load your functions from another file
    This will help with keeping your files separate and clean. This is good for one off 
    type functions but if you want to have multiple functions that are available you need 
    to look into PowerShell Modules.
    Tip - you can add a function inside of a script but think about why you may or may not 
    want to use it like that.
#> 
get-something -name "Michael"
. .\Lesson13\MyFunctions.ps1
.\Lesson13\testscript.ps1

<#
    There is a leading [.] and a [Space] we are loading this into memory of the console.
    It is not a permanent thing will not be available until you run it again.
#>    
get-something -name "Michael"
set-something -name "Michael"

<#
    PowerShell profiles
    Using a Profile can help you customize how you interact with your console.
    Where is your Profile stored?
    Why would you want to customize your profile?
#>

$PROFILE

$PROFILE | Format-List -Force

Test-Path $PROFILE

New-item –type file –force $profile

notepad $PROFILE

<# 
    PowerShell Modules
    PowerShell has multiple types of Modules
    Script file (.psm1) easy to create and manage 
    Binary - Uses .net Framework .dll's and may be written in C#
    Manifest Modules - contains a (.psd1) will have more information on how the module is processed
    Dynamic Modules - is not loaded from or saved to a file instead created by a script

    How are Modules Loaded?
    Where are Modules stored?
    PowerShell recursively searches each folder in the PSModulePath for module (.psd1 or .psm1)
#>

# What does it take to create a PowerShell Module?
notepad.exe .\Lesson13\MyFunctions.psm1

# Where are your PS Modules being loaded from?
$env:PSModulePath -split ";"

# Look at some of the different Modules that we have loaded
explorer.exe "C:\Program Files\WindowsPowerShell\Modules"

# Binary Module
explorer.exe "C:\Program Files\WindowsPowerShell\Modules\AzureAD\2.0.2.135"

# Manifest Module
explorer.exe "C:\Program Files\WindowsPowerShell\Modules\Microsoft.Graph\1.6.0\"
notepad.exe "C:\Program Files\WindowsPowerShell\Modules\Microsoft.Graph\1.6.0\Microsoft.Graph.psd1"

# Dynamic Module
New-Module -ScriptBlock { function multiple { param ([string]$string)$string * 10 } }
multiple -string "x-x"

<#
    Let's save our module to one of the module paths
    Open up a Powershell Terminal
#>

Test-Path "C:\Users\michael.cruz\Documents\WindowsPowerShell\Modules\MyFunctions\myfunctions.psm1"
mkdir 'C:\Users\michael.cruz\Documents\WindowsPowerShell\Modules\MyFunctions\'
Copy-Item -Path .\Lesson13\myfunctions.psm1 -Destination "C:\Users\michael.cruz\Documents\WindowsPowerShell\Modules\MyFunctions\" -Force
Remove-Item "C:\Users\michael.cruz\Documents\WindowsPowerShell\Modules\MyFunctions\" -Force

<#
    What is the purpose of a package manager?
#> 

Get-PackageProvider

Find-Package -ProviderName NuGet 

<#
    What about a package manager for PowerShell Commandlets?
    https://www.powershellgallery.com/
#>

Get-PSRepository
Find-Module -tag sharepoint

Get-InstalledModule 
Find-Module -Name MicrosoftTeams
Install-Module -Name MicrosoftTeams
Update-Module -Name MicrosoftTeams

<# 
    How can you use this information?
#>