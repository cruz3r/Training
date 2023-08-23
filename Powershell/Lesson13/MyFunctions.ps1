function get-something {
    param (
        $name,
        $date
    )
    if ($name) {
        write-host "Welcome to PowerShell $name!" -ForegroundColor "blue"
    }
    if ($date) { "Today's date is $(Get-Date)" }
}

function set-something {
    param (
        [string]$name
    )
    write-host "LowerCase - $($name.ToLower())"
    write-host "UpperCase - $($name.ToUpper())"
}