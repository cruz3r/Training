<#
    Rock, Paper, Scissors Game
    What is the logic for RPS?
    You have a tie
    Rock beats Scissors but loses to Paper
    Paper beats Rock but loses to Scissors
    Scissors beats Paper but loses to Rock
    This goes over things we have talked about previously
    - Creating a function
    - Using advanced parameter settings
    - ValidateSet allowing only specific parameter ooptions
    - Calling a function inside of your function
    - Using If, ElseIf, and Else Statements for your logic

    This is an exercise on breaking down each step and then reusing pieces.
#>
function RPS {
    param (
        # RPS -Choose (from ValidateSet)
        [Parameter(Mandatory = $true)]
        [ValidateSet("Rock", "Paper", "Scissors")]
        $Choose
    )
    $Choose
    $choices = Get-Random "Rock", "Paper", "Scissors"
    
    if ($Choose -eq $choices) { "You both tied with - $choose" }

    elseif ($choose -eq "Rock") {
        if ($choices -eq "Scissors") { "Rock smashes scissors! You win!" }
        else { "Paper covers rock! You lose." }
    }
    elseif ($choose -eq "Paper") {
        if ($choices -eq "Rock") { "Paper covers Rock! You win!" }
        else { "Scissors cuts Paper! You lose." }
        
    }
    elseif ($choose -eq "Scissors") {
        if ($choices -eq "Paper") { "Scissors cuts Paper! You win!" }
        else { "Rock smashes scissors! You lose." }
    }
}