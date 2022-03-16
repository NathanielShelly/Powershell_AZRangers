Install-WindowsFeature RSAT-AD-PowerShell
$timespan = New-Timespan –Days 90
Search-ADAccount –UsersOnly –AccountInactive –TimeSpan $timespan | Get-ADuser -Properties Department,Title | Sort LastLogOnDate | Select Name,Department,Title,DistinguishedName

Search-ADAccount –UsersOnly –AccountInactive –TimeSpan $timespan | Disable-ADAccount
