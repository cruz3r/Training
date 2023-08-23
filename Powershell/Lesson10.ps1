<#
    PowerShell Desired State Configuration - DSC
    With all of the tools out there to install and deploy application and configure settings why would you use DSC?
    - It's Built in to Windows
    - Logging is enabled by default
    - There are community packages built to assist with multiple uses
    - It can be used in multiple way's
    - You have Push and Pull configurations
    Get, Test, and Set
    I find that these 3 methods are helpful to understand the basics of what you are trying to accomplish
    - I want to Get the state of my resource
    - I want to Test that my resource is in the state I have configured it to be - Return a boolean value
    - I want to Set my resource with the configuration I specified
    What is a MOF File?
    Managed Object Format file used to describe CIM Classes Common Information Model
    List of Resources
    https://learn.microsoft.com/en-us/powershell/dsc/reference/psdscresources/resources/processset/start?view=dsc-2.0
    https://learn.microsoft.com/en-us/azure/virtual-machines/extensions/dsc-overview
    https://github.com/PowerShell/PSDscResources/blob/dev/README.md
    https://dsccommunity.org/resources/
    > A good article from OctopusDeploy
    https://octopus.com/blog/getting-started-with-powershell-dsc#:~:text=PowerShell%20DSC%20is%20an%20Infrastructure%20as%20Code%20%28IaC%29,uses%20PowerShell%20to%20programmatically%20configure%20your%20Windows-based%20computers.

#>

Install-Module PsDesiredStateConfiguration -Verbose

# Nothing is configured at this time
Get-DscConfiguration
Get-DscConfigurationStatus

# Run Files from Folder DSC
. .\DSC\DSCFile.ps1
# look at file .\DSC\DSCFile.ps1 What is the name of the configuration?
HelloWorld 
<#
    Look at your Directory structure you should have a new folder called HelloWorld
    Inside the folder you have a MOF File
#>
Start-DscConfiguration -wait -verbose -path .\HelloWorld
<#
    Now a lot of things popped up on the screen so let's go through them to see what happened
    Perform operation Invoke CimMethod - Last week we went over CIM and WMI Lesson 9
    LCM stands for Local Configuration Manager This will use the Meta Configuration (MOF File) to 
    see what the configuration is and then go from there.
    You can see it pulls in Start Set, Start Resource, and Start Test
    The Test Starts
    Was the File found?
    If the file was not found it will start Set
    If all is right it finished the set
    The resource is now there
    The process is using Invome CimMethod to complete the task
    The configuration job completes and tells you how long it took  
#>

Test-DscConfiguration -Verbose
Test-DscConfiguration
<#
    using the -Verbose Parameter we can see what the test looks like
    Using it with out the -Verbose returns just the boolean
    Why would you want this?
    Possibility to check the status of your DSC in another script
    Need to come back later and see if the Configuration has changed
    IE: If you have ever done configurations for IIS and have some one come in make changes 
    you can revert those changes
#>

<#
    Let's look at the DSC File DSCFile.ps1
    "Configuration" is a Key Word in Powershell similar to Function
    My Configuration's Name is "HelloWorld"
    The Script Block portion (everything in the {}) is what I want to run
    I am importing the module for DSCResource "PsDesiredStateConfiguration" - there are other modules to look at
    This will load the cmdlets for me
    (Get-Module PsDesiredStateConfiguration).ExportedCmdlets
    The Resource I am using is "File" - There are other resources that are not listed
    https://learn.microsoft.com/en-us/powershell/dsc/reference/resources/windows/fileresource?view=dsc-1.1
    Properties - DestinationPath, Ensure, Contents (there are more available)
#> 

(Get-Module PsDesiredStateConfiguration).ExportedCmdlets
Get-DscResource
# Look at the different modules and see what is available 
# DSCCommunity.org Various Modules available

<#
    At this point we have only gone through a small portion of DSC
    Push and Pull - I won't go into the pull model of DSC at this time
    There are other tools that can be used in conjunction with DSC to provide
    similar functionality.
    DSC Creates jobs to actually run our configurations 
    How do we find out what our LCM configurations are?
    What configurations do you see that are interesting?
    https://learn.microsoft.com/en-us/powershell/dsc/managing-nodes/metaconfig?view=dsc-1.1
    The Push model allows us to use tools like Powershell, Azure PipeLine, Terraform, Ansible, Puppet,
    OctopusDeploy, and Jenkins
    These are just some of the tools that I know of that can use DSC
    Things to think about -
        Are you wanting this for the initial configuration or to reapply after a change?
        How often do you need to check on this?
        Do you have to take a look at Dependencies?
        Are you going to use this to monitor drift?
        Will your Monitoring Tools take advantage of this or do you have to write something for this?
    Like all scripts and configuration this will require the same kind of maintenance and documentation so that
    it can be read / updated / discontinued as things change in your environment
#>
Get-DscLocalConfigurationManager

# Another Example using the WindowsFeature resource
. .\DSC\DSCWinfeature.ps1 # Dot Source the PowerShell
# Call the Powershell Configuration
SampleIISInstall
# Get Windows Feature from remote server 
Invoke-Command -ComputerName loc-bignavi01 -Credential $cred -ScriptBlock { Get-WindowsFeature web-server }
# Start the DSCConfiguration
Start-DscConfiguration -Path .\SampleIISInstall\ -Verbose -Credential $cred
# Creates the new directory and the Mof file
# What is the name of this file? 
# Update the Ensure to absent
# Re run commands
. .\DSC\DSCWinfeature.ps1 # Dot Source the PowerShell
SampleIISInstall
Start-DscConfiguration -Path .\SampleIISInstall\ -Verbose -Credential $cred


# Clean up
Remove-DscConfigurationDocument -Stage current
# Next week will continue with this to show some more DSC Configurations
# Pester?