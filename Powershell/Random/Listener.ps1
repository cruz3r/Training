
# Create a listner
$Listener = [System.Net.Sockets.TcpListener]9999;
$Listener.Start();
#wait, try connect from another PC etc.
$Listener.Stop();

Get-NetTCPConnection -State Listen
#Get-Process -Id 5092