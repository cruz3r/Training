<#
    Pester
    What is Pester?
    - Pester is a testing and mocking framework for PowerShell.
    Why would I need to know about Pester?
    - Having a better understanding of development practices 
    can help to create better Operational practices
    - Creating tests and understanding what is required to create a test or 
    mock framework can help you write better scripts.
    - Pester was a community driven project that was added into PowerShell
    - It can be used in different way's ***
    Pester has some unique naming structure which is another thing to learn
    - *.tests.ps1

    https://pester.dev/
    https://pester.dev/docs/assertions/
#>

Import-Module pester -PassThru
# What version are you running of Pester? Is it the lateste Version?
Install-Module Pester -Force -Verbose

<#
    Describe - logical grouping of tests
    Context - Optional provides additional of grouping of IT Blocks
    IT - The IT Block is the actual test
    Assertion - What makes this test True, Truthy or False 

Describe "Get-Something" {
        Context "when parameter ThingToGet is not used" {
            It "should return 'I got something!'" {
                # Assertion
            }
        }

        Context "when parameter ThingToGet is used" {
            It "should return 'I got ' follow by a string" {
                # Assertion
            }
        }
}
#>
# Example 1
invoke-pester -Output Detailed -Path .\pester1\get-planet.Tests.ps1

# Example 2
invoke-pester -Output Detailed -Path .\pester2\get-userinfo.Tests.ps1

# Example 3
invoke-pester -Output Detailed -Path .\pester3\get-computer.tests.ps1

<# 
    What does this mean to you?
    How does this apply to you? 
    How I see this as beneficial
        - If you think about how your going to test your 
        script / code / process / change 
        before you start the process. You can see the bigger picture of what 
        will be needed to produce a solid product. 
        - A valid test can help when you have to make changes with in your Script / Code

#>