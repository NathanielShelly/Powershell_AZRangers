#Enter the information on the new OU below.
$Credential = Get-Credential
$DomainController = 'LON-DC1'
$OUName = 'TestIT'
$OUCity = 'Redmond'
$OUState = 'Washington'
$OUZipCode = '98052'
$OUCountry = 'US'
$OUDisplayName = 'Information Technology Department'
$OUManagedBy = 'DomainAdmins'

$Inputs = @{
    'Name' = $OUName
    'City' = $OUCity
    'Country' = $OUCountry
    'DisplayName' = $OUDisplayName
#   'ManagedBy'  $OUManagedBy
    'PostalCode' = $OUZipCode
    'ProtectedFromAccidentalDeletion' = $true
    'State' = $OUState
}
Invoke-Command -ComputerName $DomainController -Credential $Credential -ScriptBlock {New-ADOrganizationalUnit @using:Inputs}