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

get-something -name "Paul"