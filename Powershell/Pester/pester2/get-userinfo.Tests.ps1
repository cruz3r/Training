BeforeDiscovery {
    # Loads and registers my custom assertion. Ignores usage of unapproved verb with -DisableNameChecking
    Import-Module "$PSScriptRoot/get-Userinfo.ps1" -DisableNameChecking
}
Describe 'userinfo' {
    Context 'When I run this I should get an employeeid back'{
        it 'returns the employeeid' {
            . .\pester2\get-userinfo
            (get-userinfo).Employeeid | should -Be $true
        }
    }
    Context 'Testing the name field'{
        it 'returns a string for the name' {
            . .\pester2\get-userinfo
            (get-userinfo).GivenName | Should -BeOfType system.string
        }

        it 'returns the name' {
            . .\pester2\get-userinfo
            (get-userinfo).GivenName | Should -Be "Michael"
        }
    }
}