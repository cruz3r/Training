<#
    Regex - Regular Expressions a fun way to search through mountains of text
    Select-String - PowerShell Verb-Noun I want to Select the String 
    Switch statement - PowerShell command that is simmilar to multiple IF Statements
    Operators - PowerShell prefix starts with 'C' -cmatch -csplit -creplace
    Character Groups - A group of characters that are in []
    Character Ranges - A pattern / a range of characters [0-9][a-z][A-Z]
    Numbers - Yep you can search for Numbers
    Word Characters - (Word Like Characters)
    Wildcards - (.) not a * or a ?
    Whitespace - How many spaces did they use? Or is it a Tab?
    Quantifiers - How many times should I expect to see what I am looking for (Characters and non characters)
        ?, *, +, {n}, {min,}, {0,max}, {min,max}
    Anchors - The Start and End 
    $Matches - An Automatic Variable in PowerShell available with in the matching statement block
    https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_regular_expressions?view=powershell-7.2
    https://docs.microsoft.com/en-us/dotnet/standard/base-types/regular-expression-language-quick-reference
    https://regex101.com/
#>

# What is Regex?
# Do I really need to learn about Regex?
# Why not just use the find feature in NotePad ++ or some other tool?
# What can I do with regex?


# Select-String
get-help select-string -Online

$one = ("There23423alskj'fdds are many reasons to learn regex" | Select-String "(?<first>^.+\s)" ).Matches
$one.Count
$one

$many = ("There are many reasons to learn regex" | Select-String -AllMatches "\w+" ).Matches
$many.count
$many

# Switch Examples
switch -Regex ('my5.sa@domain.com'){
    '\w+' {"a word like - " + $Matches.Values}
    '\W+' {"Not a word - " + $Matches.Values}
    '\d' {"a digit - " + $Matches.Values}
    '\.'{"Escaped Charater - " + $Matches.Values}
    '.' {"a wild card - " + $Matches.Values}
    '.+' {"a wild card plus some more charaters - " + $Matches.Values}
    '.*' {"a wild card plus some more charaters until it reaches a different non alphanumeric character - " + $Matches.Values}
    '@' {"Match a character - " + $Matches.Values}
    '@.+$' {"match from the start of a character to the end of the string - " + $Matches.Values}
    '^.+@'  {"match from the beginning of a string to a character - " + $Matches.Values}
}

# Operators - PowerShell prefix starts with 'C' -cmatch -csplit -creplace
"There are many reasons to learn Regex" -match "^t" # not Case Sensitive
"There are many reasons to learn regex" -cmatch "^t" # Case Sensitive
"There are many reasons to learn regex" -split "\s"
"There are many reasons to learn regex" -csplit "to"
"There-are@many)reasons#to{learn%regex" -replace "[-@#$%{}<>())]"," "

# Numbers validate boolean
$myRegex = '\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}'

$ip = "10.1.3.252"
$ip -match $myRegex
$matches

$badIP = "m.cruz.1.2"
$badIP -match $myRegex
$matches

# Anchors Away
("There are many reasons to learn regex" | Select-String "\s\w+$").matches.Value # (Dollar Sign Shift 4) $ represents the end of a line
("There are many reasons to learn regex" | Select-String ("^\s|^\w+")).matches.Value # (caret Shift 6) ^ represents the beginning of the line

# Named Matches
$namedMatch = "(?<First>^.+)\s(?<Last>\w+$)"
("There's are many reasons to learn regex" -match $namedMatch) 
$Matches
$Matches.First
$Matches.Last

function Get-Netstat {
    [CmdletBinding()]
    param (
        [parameter(mandatory=$true)]
        [validateset("Established","Listening")]
        $Match
    )
    
    begin {
        try{
            $netstat = netstat -ano
        }catch{
            $_
        }
        
    }
    
    process {
        $listening = $netstat -match $Match
        $namedMatch = "(?<Protocol>^\w+)\s{2,}(?<LocalAddress>\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}:\d{1,})\s{2,}(?<RemoteAddress>\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}:\d{1,}).+\s(?<Pid>\w+$)"
        ForEach($line in $listening.trim()) { 
            if ( $line -match $namedMatch ){
                [PSCustomObject]@{
                    Protocol = $matches.Protocol
                    LocalAddress = $matches.LocalAddress
                    RemoteAddress = $matches.RemoteAddress
                    Pid = $matches.Pid
                    ProcessName = $(get-process -Id $($matches.Pid)).Name
                    ProcessPath = $(get-process -Id $($matches.Pid)).Path
                }
            }
        }

    }
    
    end {
        $return
    }
}

function Add-Money {
    [CmdletBinding()]
    param (
        [validatescript(
            {if($_ -match "\d{3,}"){
                $true
            }else{
                throw "$_ I need 3 digits"
            } 
        }
        )]
        $Dollars
        
    )
    Write-Host -ForegroundColor Green "Thank you for your $Dollars"
}

<#
    Regex can be super useful when looking at Patterns
    Regex can be used for Validation Before you Run your Function or in your function
    Regex will make your head hurt at times
#>