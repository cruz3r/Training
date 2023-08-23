Configuration SampleIISInstall
{
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    node ('irv-bignavi01')
    {
        File HelloWorld {
            DestinationPath = "C:\Temp\index.htm"
            Ensure = "Present" # { Present | Absent }
            Contents   = @"
<head>DSC</head>
<body>
<p>Hello World from DSC!</p>
</body>

"@
        }
        
        WindowsFeature IIS
        {
            Ensure = 'Present' # { Present | Absent }
            Name   = 'Web-Server'
            DependsOn = '[file]HelloWorld'
        }

        File WebsiteContent {
            Ensure = 'Present' # { Present | Absent }
            SourcePath = 'c:\temp\index.htm'
            DestinationPath = 'c:\inetpub\wwwroot\'
            DependsOn = '[WindowsFeature]IIS'
        }

        Service ServiceExample
        {
            Name        = "W3SVC"
            StartupType = "Manual"
            State       = "Running" # { Running | Stopped }
        }
    }
}