Import-Module ActiveDirectory

# Specify target OU where the users will be moved to
$TargetOU = "OU=TestIT,DC=Adatum,DC=com"

Get-ADUser -Filter {Department -like "ITTest"} | Move-ADObject  -TargetPath "OU=TestIT,DC=Adatum,DC=com"
Write-Host "Completed move"