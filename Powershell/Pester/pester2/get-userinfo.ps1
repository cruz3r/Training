function get-userinfo {
    [CmdletBinding()]
    param (
        [string]$samaccountname = 'michael.cruz'
    )
    
    begin {
        $user = get-aduser -Identity $samaccountname -Properties *
    }
    
    process {
        $results = if ($user.Employeeid -gt ""){
            $user | select-object GivenName, Employeeid
        }
    }
    
    end {
        $results
    }
}