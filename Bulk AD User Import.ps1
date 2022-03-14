Import-Module ActiveDirectory
Import-Csv "C:\ScriptsNewADUsers.csv" | ForEach-Object {
Write-Host "Creating AD user:" $_.Name
New-ADUser -Name $_.Name `
 -Path $_."ParentOU" `
 -SamAccountName  $_."samAccountName" `
 -UserPrincipalName $_."userPrinicpalName" `
 -OtherAttributes @{title=$_."JobTitle";mail=$_."userPrinicpalName";proxyaddresses=$_."proxyAddresses"}`
 -AccountPassword (ConvertTo-SecureString "MyPassword123" -AsPlainText -Force) `
 -ChangePasswordAtLogon $true  `
 -Enabled $true
Add-ADGroupMember "Remote Desktop Users" $_."samAccountName";
}
Write-Host "---------------------------------"
Write-Host "Bulk AD Users created successfully from CSV file."
Write-Host "---------------------------------"