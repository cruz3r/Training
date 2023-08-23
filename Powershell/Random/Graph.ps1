<#
    Requires GraphViz
#>

graph folders {
   node @{shape='folder'}
   node $serversou -NodeScript {$_.DistinguishedName} @{label={$_.name}}
   edge $serversou -FromScript { ($_.DistinguishedName -split ",",2)[1] -replace ",DC=fairwaymc,DC=com",""} -ToScript {($_.DistinguishedName )}
} | Export-PSGraph -ShowGraph

# ---------------
$folders = Get-ChildItem "\\fs01\corp\Corp IT\IT Ops" -Directory -Recurse  -Depth 2 -Exclude "Branch IT Info"

graph g @{rankdir='LR'}  {
    node -Default @{shape='folder'}
    $folders | ForEach-Object{ node $_.FullName @{label=$_.Name} }
    $folders | ForEach-Object{ edge (Split-Path $_.FullName) -To $_.FullName }
} | Export-PSGraph -ShowGraph

# ---------------
$netstat = Get-NetTCPConnection | Where-Object LocalAddress -EQ '10.4.21.233'
$process = Get-Process | Where-Object id -in $netstat.OwningProcess

graph network @{rankdir='LR'}  {
    node @{shape='rect'}
    node $process -NodeScript {$_.ID} @{label={$_.ProcessName}}
    edge $netstat -FromScript {$_.OwningProcess} -ToScript {$_.RemoteAddress} @{label={'{0}:{1}' -f $_.LocalPort,$_.RemotePort}}
} | Export-PSGraph -ShowGraph