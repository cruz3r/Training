<#
    help about_function | select name
    Parameterization
    https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-7.2
    https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_output_streams?view=powershell-7.2
    Try Catch and Error Handling
    
#>

function Get-Example {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline,
        Mandatory=$true,
        HelpMessage="You should put a name here")]
        [string]$name,
        # Unless [string[]]$name,
        [Parameter(Mandatory=$true,
                   HelpMessage="Literal path to one or more locations.")]
        [validateset("test","test2")]
        $testValue
    )
    
    begin {
        "Begin block will only run once per call"
        $name
        $testValue
        #Write-Verbose $name
    }
    
    process {
        "Process block will run on every object that might be passed to the function. 
        But won't run each time if you pass it a variable 
        Unless?"
       $results += $name
        $testValue
    }
    
    end {
        "End"
        $results #$name
        # $testValue
    }
}

<#
    Validate - What does it mean
    There are a lot of parameters that will use the term validate you will use those to help you ensure 
    that the data coming in is in the proper format.
    Why would you use validate in a parameter?
    Go through the link to see the various Parameter's

#>

<#
    Naming Standards
    1-2-3
    Application Name (Limited to ? characters) - Environment (3 Characters) - Application Type (Limited to ? characters)

#>

function Set-myEnvironment {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,
        HelpMessage="Abbreviated Environments")]
    [validateset("Prd","Dev","Tst","Stg")]
    [string]$environment,
    [Parameter(Mandatory=$true,
    HelpMessage="Enter Computer Name")]
    [string]$ComputerName
    )
    DynamicParam {
        if ($environment -eq "Prd"){
            $TicketNumber = New-Object System.Management.Automation.ParameterAttribute
            $TicketNumber.Mandatory = $true
            $TicketNumber.HelpMessage = "Enter your Service Now Ticket Number"
            $attributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            $attributeCollection.Add($TicketNumber)
            $ticketParam = New-Object System.Management.Automation.RuntimeDefinedParameter('TicketNumber', [string], $attributeCollection)
            $paramDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
            $paramDictionary.Add('TicketNumber', $ticketParam)
            return $paramDictionary
        }
    }
    
    begin {
        if ( get-adcomputer -Identity $ComputerName -ErrorAction SilentlyContinue){
            Write-Warning "$ComputerName exists in Active Directory Use a different Name"
            Break
        }else{
            Write-Verbose "Just a verbose message letting me know where I am in the script ComputerName is not in AD"
        }
    }
    
    process {
        $ou = Switch ($environment){
            Prd {"OU=Prd,OU=Servers,DC=fairwaymc,DC=com"}
            Dev {"OU=Dev,OU=Servers,DC=fairwaymc,DC=com"}
            Tst {"OU=Tst,OU=Servers,DC=fairwaymc,DC=com"}
            Stg {"OU=Stg,OU=Servers,DC=fairwaymc,DC=com"}
        }
        "$ComputerName should be added to: " + $ou
    }
    
    end {
        Write-host $("Added computer name to: " + "cn=" + $ComputerName + "," + $ou) -ForegroundColor green
        if ($environment -eq "Prd"){
            "Here is your Ticket Number since this was a Production Request " + $TicketParam.Value
            "We can use the SNOW API to verify the ticket Number"
        }
    }
}

<#
    This is not how I normally approach a function. Dynamic Parameters are complicated, 
    and can be useful but for Automation you don't want to use them. Can anyone tell me why?
    This is just a touch on what you can do with Advanced Parameters it is good to know what is availabe.
    How and When you would use them comes into play. 
#>

<#
    What is the difference between a script and a function?
    An inline function can reside in a script. Think of it as a helper in the script
#>

function randomfunction ($computername) {
    return $ComputerName
}
function writelog ($message) {
    "$(get-date)" + ": " + $message | out-file c:\temp\myFunctionLog.txt -Append 
}