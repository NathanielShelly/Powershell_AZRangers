$Credentials = Get-Credential

Search-ADAccount `
-Credential $Credentials -AccountExpired `
-UsersOnly -ResultPageSize 2000 `
-resultSetSize $null| Select-Object Name, SamAccountName, DistinguishedName
