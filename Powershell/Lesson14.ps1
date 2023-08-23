<#
    Working with Secrets
    What do you consider a secret?
    - Passwords, Account Identities, API Key's, IP Addresses, Information that you don't want seen 
    What are different way's to deal with a secret?
    - Enter it as needed, Request it from another secure location
    What would be another secure location?
    - Microsoft.PowerShell.SecretManagement, Azure Key Vault, file (XML), 3rd party vaults
    $psversiontable - What version is your powershell?
    SecureString 
    Temporary Environment Variables  
    Signing your Script
    
    How do we use this information?
    
    Links:
    https://learn.microsoft.com/en-us/dotnet/standard/security/how-to-use-data-protection
    https://learn.microsoft.com/en-us/dotnet/api/system.management.automation.pscredential.getnetworkcredential?view=powershellsdk-7.2.0
    https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.secretmanagement/?view=ps-modules
    https://devblogs.microsoft.com/powershell/secretmanagement-and-secretstore-are-generally-available/
    https://learn.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.marshal?view=net-7.0
#>



# Show the differenece in convertfrom-securestring 7 and 5 
#Verify Version of Powershell 
$PSVersionTable
help convertfrom-securestring

# Using PS 7 Core
# ConvertTo-SecureString
$password = "PassW0rd"
# Variable is plain text
$password

# $ss Shows 1-5 times the same pw converted creating a unique encryption
$ss = 1..5 | ForEach-Object {ConvertTo-SecureString $password -Force -AsPlainText  }
$ss | ForEach-Object {ConvertFrom-SecureString $_ }

# Show the last 5 characters to see the difference easier to view
$ss | ConvertFrom-SecureString | ForEach-Object{$_.Substring($_.Length - 5)}

# Convert each unique encryption back to plain text
$ss | ForEach-Object {ConvertFrom-SecureString -SecureString $_ -AsPlainText}


# Using a Secure Key to encrypt and decrypt data
# Create a secure key and store it encrypted in a text file - This would need to be secured in a location you have access to
$a = "abcdef1234567890"
$key = $a
$EncryptedKey = $key | ConvertTo-SecureString -AsPlainText -force
$EncryptedKey | ConvertFrom-SecureString | Set-Content c:\temp\encrypted_key.txt
Get-Content C:\Temp\encrypted_key.txt

# Create a Secret use the Key to encrypt the pw
$creds = Get-Credential
$mykey = Get-Content c:\temp\encrypted_key.txt | ConvertTo-SecureString
$creds.Password | ConvertFrom-SecureString -SecureKey $mykey | Set-Content c:\temp\encrypted_password.txt
$creds.username | Set-Content c:\temp\plaintext_username.txt
Get-Content C:\Temp\encrypted_password.txt
Get-Content C:\Temp\plaintext_username.txt

# Read back the secrets using the securekey and recreate the Password 
$mypass = Get-Content c:\temp\encrypted_password.txt | ConvertTo-SecureString -SecureKey $mykey
$myuser = Get-Content c:\temp\plaintext_username.txt 
$credentials = New-Object -TypeName system.management.automation.pscredential -ArgumentList $myuser,$mypass
$credentials

<# 
    This was an example of creating a key storing it in a file using that key to encrypt a secret and then storing that into a file. 
    We can use that key to then decrypt the text file and generate credentials
    This is an example on how some people use Secrets for Automation 
#>

<# 
    Some processes can use the secure password and others can not 
    All this means is that there are some apps that can decrypt the information and some require you to decrypt it first
    You may think about Network Sniffers and clear text passwords across the wire but it depends on if the traffic is secured or not.
#>

# Write Secret to a file 
$secure_pwd = Read-Host -AsSecureString -Prompt "Enter your Secret"
$secure_pwd 
ConvertFrom-SecureString -SecureString $secure_pwd
ConvertFrom-SecureString -SecureString $secure_pwd | Set-Content C:\temp\Encrypted.txt
# Decrypt from file
Get-Content C:\Temp\Encrypted.txt | ConvertTo-SecureString | ConvertFrom-SecureString -AsPlainText

# Export-CLIXml Save to a file
Get-Credential | Export-CliXml -Path c:\temp\Cred_mac.xml
notepad.exe C:\Temp\Cred_mac.xml
$Credential = Import-CliXml -Path c:\temp\Cred_mac.xml
$Credential
$Credential.GetNetworkCredential().Password

<#
    This is simmilar to the previous method
    Why would you use this method or not use this method?
    Scripted task
    You have control of where the file will be stored or accessed from
    It may add complexity to what your trying to accomplish
#> 


# Decrypting a SecureString for apps that require it 
# .net marshal service
$secure_pwd = Read-Host -AsSecureString -Prompt "Enter your Secret"
$secure_pwd | Get-Member
[System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($secure_pwd))

# A network Credential
$secure_pwd.getnetworkcredential().password
# Why doesn't this work?
$secure_netcred = New-Object pscredential("MyUserName",$secure_pwd)
$secure_netcred | Get-Member
$secure_netcred.GetNetworkCredential().Password


<#
    So these are way's to create a secret, read a secret and store a secret in a file. 
    What if we want to work with a vault?
    Microsoft.PowerShell.SecretManagement
#>

# installing the Microsoft.PowerShell.SecretManagement - one time install per box
Install-Module Microsoft.PowerShell.SecretManagement -Force -AcceptLicense -Verbose
# installing the SecretStore a location to store secrets
Install-Module Microsoft.PowerShell.SecretStore -Force -AcceptLicense -Verbose

# Commandlets in the module
Get-Command -Module Microsoft.PowerShell.SecretManagement
Get-Command -Module Microsoft.PowerShell.SecretStore

# Reset-SecretStore Due to creating deleting multiple times it's a good idea to reset everything back so that you can reset your pw for the secretstore

# Registering a SecretVault
Register-SecretVault -Name TempStore -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault

get-secretVault

Get-SecretInfo
Set-Secret -Name WebPageSecret -Vault TempStore -Secret "HelloWorld"
Get-Secret -Name WebPageSecret -Verbose
Get-Secret -Name WebPageSecret -AsPlainText

1..4 | ForEach-Object {Set-Secret -Name $("WebPageSecret" + $_ ) -Vault TempStore -Secret ("HelloWorld" + $_)}
Get-SecretInfo

get-secretinfo | ForEach-Object { Remove-Secret -Name $_.name -Vault $_.VaultName}

# Change up the Secret Store Configuration. You can take off the Password requirement if you are adding it to an automated process.
Set-SecretStoreConfiguration -Scope CurrentUser -Authentication Password -PasswordTimeout 30 -Interaction Prompt
Get-SecretStoreConfiguration

# Registering a Secret with MetaData (Information only)
# $Metadata = @{ Expiration = ([datetime]::new(2022, 5, 1)) }
$expireDate = (get-date).AddMinutes(1)
$Metadata = @{ Expiration = $expireDate; Info = "PW for x" }
$targetToken = ConvertTo-SecureString -AsPlainText "Passw0rdX" -force
Set-Secret -Name TimedSecret -Secret $targetToken -Vault TempStore -Metadata $Metadata
$secretmetadata = Get-SecretInfo -Name TimedSecret | Select-Object Name,Metadata
$secretmetadata
$secretmetadata.Metadata.Expiration
Get-Secret -Name TimedSecret -AsPlainText
get-secretinfo | ForEach-Object { Remove-Secret -Name $_.name -Vault $_.VaultName}

# Registering an Azure Key Vault
# install-module az
$cred = Get-Credential 
Connect-AzAccount -Credential $cred
$parameters = @{
    Name = 'Azure'
    ModuleName = 'Az.KeyVault'
    VaultParameters = @{
        AZKVaultName = 'kv-cruz3r'
        SubscriptionId = (Get-AzContext).Subscription.Id
    }
    DefaultVault = $true
}
Register-SecretVault @parameters
Get-SecretVault

Set-Secret -Name Testing2 -Secret "ThisisATestPW" -Vault Azure
Get-Secret -Name Testing -Vault Azure -AsPlainText

Get-AzContext | Disconnect-AzAccount
Get-SecretInfo

# Environment Variables
<# 
    It's not uncommon to see applications use Environment Variables to hold secrets while the process is running
    Terraform is an example
        $env:TF_VAR_username ="Your UserName for Nutanix AHV"  
        $env:TF_VAR_password="Your PW for Nutanix AHV"  
    Azure Pipelines
        Can store and read variables then use them as the pipeline starts to run
    Containers
        It's a bad practice to save a clear text secret in a file but you need secrets to run your application
        I can pull in a secret into a container use it in an Environment Variable while the process is running 
        then when the process is shut down the secret is no longer available
    
    Are there any others that you have seen?

#>

<#
    PowerShell's SecureString is a way to store sensitive information, such as passwords, in memory in an encrypted format. 
    The encryption helps to protect the information from being read by unauthorized users or processes, even if the computer's memory is compromised.
    
    When you create a SecureString, the plaintext password is encrypted and the encrypted data is stored in memory. 
    Once the SecureString is created, you can then use it in place of the plaintext password in various PowerShell cmdlets and scripts.

    You can use the ConvertTo-SecureString cmdlet to convert a plaintext password to a SecureString and the ConvertFrom-SecureString cmdlet to 
    convert a SecureString back to plaintext. However, for security reasons, it is not recommended to convert a SecureString back to plaintext, 
    instead you should use the SecureString as is to authenticate or provide access to resources.

    It's important to note that SecureString is not a feature that encrypts the data at rest, it is only meant to encrypt the data in memory 
    while the program is running, once the program ends the memory is cleared. And it's also important to note that the encryption used by SecureString is 
    based on the Windows Data Protection API (DPAPI) and the encryption key is specific to the user and the machine, 
    this means that a SecureString created on one machine cannot be decrypted on another machine.
#>

# This came up after but it's a good example for writing a secret for PS 5. Using multiLine text in the secret. 
$test = @"
Hello
goodbye
1234
password
a79a9d63-7f9b-498d-adff-e17197fb1575
"@

ConvertTo-SecureString $test -AsPlainText -Force | Export-Clixml C:\temp\test.xml
notepad C:\temp\test.xml
$secure_pwd = Import-Clixml C:\temp\test.xml
$pw = [System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($secure_pwd))

$pw

($pw -split "\n")[-1]