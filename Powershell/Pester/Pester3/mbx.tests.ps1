describe randomtest {
    Context "test mbx" {
        it "Should find only False enabled"{
            $mbx = Get-ADUser -SearchBase 'OU=Resource Mailboxes,OU=ServiceAccts,DC=fairwaymc,DC=com' -Filter *
            $mbx.enabled | should -not -Contain $true
        }
        
        it "should only find enabled computers" {
            $comp = Get-ADComputer -SearchBase "OU=DEV,OU=Servers,DC=fairwaymc,DC=com" -Filter *
            $comp.enabled | should -not -Contain $false
        }
    }
}