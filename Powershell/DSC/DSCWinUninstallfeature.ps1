Configuration SampleIISUnInstall
{
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    node ('irv-bignavi01')
    {
        File HelloWorld {
            DestinationPath = "C:\Temp\index.htm"
            Ensure = "absent" # { Present | Absent }
            Contents   = @"
<head>DSC</head>
<body>
<p>Hello World from DSC!</p>
</body>

"@
        }
        
        WindowsFeature IIS
        {
            Ensure = 'absent' # { Present | Absent }
            Name   = 'Web-Server'
            DependsOn = '[file]HelloWorld'
        }

        File WebsiteContent {
            Ensure = 'absent' # { Present | Absent }
            SourcePath = 'c:\temp\index.htm'
            DestinationPath = 'c:\inetpub\wwwroot\index.htm'
            DependsOn = '[WindowsFeature]IIS'
        }

        Service ServiceExample
        {
            Name        = "W3SVC"
            StartupType = "Manual"
            State       = "Stopped" # { Running | Stopped }
        }
    }
}