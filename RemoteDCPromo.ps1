# Enter the Domain Name and NetBios name for the new Domain
$ServerName = 'LON-SVR2'
$Credential = Get-Credential
$NewDomainName = 'TestTree.com'
$NewNetBIOSName = 'TestTree'

$DomainParams = @{
    DomainName = $NewDomainName
    DomainNetbiosName = $NewNetBIOSName
    DatabasePath = 'C:\Windows\NTDS'
    SysvolPath = 'C:\Windows\SYSVOL'
    DomainMode = 'WinThreshold'
    ForestMode =' WinThreshold'
    InstallDNS = $true
    Force = $true
    }
Invoke-Command -ComputerName $ServerName -Credential $Credential -ScriptBlock {Add-WindowsFeature ad-domain-services}
Invoke-Command -ComputerName $ServerName -Credential $Credential -ScriptBlock {Install-ADDSForest @using:DomainParams}
